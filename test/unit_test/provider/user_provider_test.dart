import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/values/providers.dart';

import 'provider_test_util.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
import 'user_provider_test.mocks.dart';

void main() {
  group('userProvider', () {
    late ProviderContainer container;
    late Listener listener;
    late MockIUserRepository userRepository;

    setUp(() async {
      listener = Listener();
      userRepository = MockIUserRepository();
      container = ProviderContainer(
        overrides: [
          userRepoProvider.overrideWithValue(userRepository),
        ]
      );
      addTearDown(container.dispose);
    });
    test('watch authNotifire', () async {
      container.listen(userProvider, listener, fireImmediately: true);
      await container.read(userProvider.future);
      verify(listener(null, isA<AsyncLoading>())).called(1);
      verify(listener(isA<AsyncLoading>(), isA<AsyncData>())).called(1);
      verifyNoMoreInteractions(listener);

      container.read(authNotifireProvider.notifier).state ++;
      await  container.read(userProvider.future);
      verify(listener(isA<AsyncData>(), isA<AsyncLoading>())).called(1);
      verify(listener(isA<AsyncLoading>(), isA<AsyncData>())).called(1);
    });
  });
}