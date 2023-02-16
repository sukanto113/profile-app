import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/values/providers.dart';

import '../../lib/riverpod/future_provider.dart';
import '../../lib/riverpod/test_util.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
import 'user_provider_test.mocks.dart';

void main() {
  group('userProvider', () {
    late ProviderContainer container;
    late MockListener listener;
    late MockIUserRepository userRepository;

    setUp(() async {
      listener = MockListener();
      userRepository = MockIUserRepository();
      container = buildProviderContainerForTest(
        addTearDown: addTearDown,
        overrides: [
          userRepoProvider.overrideWithValue(userRepository),
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
  });
}
