import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/values/providers.dart';

import '../../lib/riverpod/future_provider.dart';
import '../../lib/riverpod/test_util.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
import 'user_provider_test.mocks.dart';

void main() {
  group('userProvider', () {
    late ProviderContainer container;
    late MockListener listener;
    late MockIUserRepository mockUserRepository;

    setUp(() async {
      listener = MockListener();
      mockUserRepository = MockIUserRepository();
      container = buildProviderContainerForTest(
        addTearDown: addTearDown,
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository),
        ]
      );
    });
    test('watch authNotifire', () async {
      await verifyFutureProviderWatchingOn(
        container: container,
        provider: userProvider,
        onUpdate: (){
          container.read(authNotifireProvider.notifier).state++;
        }
      );
    });

    test('return user from repo', () async {
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => User(name: "John Doe", email: "john@example.com")
      );
      container.listen(userProvider, listener, fireImmediately: true);

      await awaitToCompleteProviderFuture(container, userProvider);

      verifyInitialAsyncLoadingCall(listener);
      verifyAsyncDataCallHavingValue(
        listener,
        equals(User(name: 'John Doe', email: "john@example.com"))
      );
      verifyNoMoreInteractions(listener);
    });

    test('called repository getCurrentUser once', () async {
      container.listen(userProvider, listener, fireImmediately: true);
      
      await awaitToCompleteProviderFuture(container, userProvider);
      
      verify(mockUserRepository.getCurrentUser()).called(1);
    });
  });
}
