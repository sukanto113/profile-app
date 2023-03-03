import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/main.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/values/providers.dart';

import '../test/lib/integration_test_util.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
import 'app_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    late MockIUserRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockIUserRepository();
    });
    
    testWidgets('register a user', (tester) async {
      
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => null
      );

      when(mockUserRepository.login(any, any)).thenAnswer(
        (_) async => true
      );

      when(mockUserRepository.register(any, any, any)).thenAnswer(
        (_) async => true
      );

      runApp(ProviderScope(
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository),
        ],
        child: const MyApp(),
      ));
      await tester.pumpAndSettle();

      final needAccountButtonFinder = find.byKey(const Key("needAccountRegisterButton"));
      expect(needAccountButtonFinder, findsOneWidget);

      await tester.tap(needAccountButtonFinder);
      await tester.pumpAndSettle();

      await enterText(tester, "RegistrationNameFormField", "John Doe");
      await tester.pumpAndSettle();

      await enterText(tester, "RegistrationEmailFormField", "john@example.com");
      await tester.pumpAndSettle();

      await enterText(tester, "RegistrationPasswordFormField", "password");
      await tester.pumpAndSettle();

      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => const User(name: "John Doe", email: "john@example.com")
      );
      await tester.tap(find.byKey(const Key("registerButoon")));
      await tester.pumpAndSettle(); // wait to load home page

      verify(mockUserRepository.register(
        "John Doe", "john@example.com", "password"
      )).called(1);

      verify(mockUserRepository.login(
        "john@example.com", "password"
      )).called(1);
      
      expect(find.text("WELCOME TO HOME"), findsOneWidget);
    });

    testWidgets('login a user', (tester) async {
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => null
      );

      when(mockUserRepository.login(any, any)).thenAnswer(
        (_) async => true
      );

      runApp(ProviderScope(
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository),
        ],
        child: const MyApp(),
      ));
      
      await tester.pumpAndSettle();

      final loginButtonFinder = find.byKey(const Key("loginButoon"));
      expect(loginButtonFinder, findsOneWidget);


      await enterText(tester, "LoginEmailFormField", "john@example.com");
      await tester.pumpAndSettle();

      await enterText(tester, "LoginPasswordFormField", "password");
      await tester.pumpAndSettle();
    

      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => const User(name: "John Doe", email: "john@example.com")
      );

      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      
      expect(find.text("WELCOME TO HOME"), findsOneWidget);

      verify(mockUserRepository.login(
        "john@example.com", "password"
      )).called(1);
    });

    testWidgets('open home page if has current user', (tester) async {
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => const User(name: "John Doe", email: "john@example.com")
      );

      runApp(ProviderScope(
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository),
        ],
        child: const MyApp(),
      ));
      await tester.pumpAndSettle(); // wait to load initial screen      
      
      expect(find.text("WELCOME TO HOME"), findsOneWidget);
    });

    testWidgets('tap "View Profile" button to go to Profile Page.' 
        'And tap "Go back" to back into Home Page.', (tester) async {
      
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => const User(name: "John Doe", email: "john@example.com")
      );

      runApp(ProviderScope(
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository)
        ],
        child: const MyApp())
      );

      await tester.pumpAndSettle();

      expect(find.text("WELCOME TO HOME"), findsOneWidget);

      await tester.tap(find.byKey(const Key("viewProfileButton")));
      await tester.pumpAndSettle();

      expect(find.text("Profile"), findsOneWidget);

      await tester.tap(find.byKey(const Key("goBackButton")));
      await tester.pumpAndSettle();

      expect(find.text("WELCOME TO HOME"), findsOneWidget);
    });

    testWidgets('back press from home exit the app when has current user', (tester) async {
      when(mockUserRepository.getCurrentUser()).thenAnswer(
        (_) async => const User(name: "John Doe", email: "john@example.com")
      );

      runApp(ProviderScope(
        overrides: [
          userRepoProvider.overrideWithValue(mockUserRepository)
        ],
        child: const MyApp())
      );

      await tester.pumpAndSettle();

      final NavigatorState navigator = tester.state(find.byType(Navigator));
      expect(navigator.canPop(), isFalse);
    });
  });
}
