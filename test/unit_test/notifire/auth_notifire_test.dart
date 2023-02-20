import 'dart:ffi';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/notifiers/auth_notifier.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
import 'auth_notifire_test.mocks.dart';

void main() {
  late MockIUserRepository mockUserRepo;
  late AuthNotifire authNotifire;

  setUp(() {
    mockUserRepo =  MockIUserRepository();
    authNotifire = AuthNotifire(0, mockUserRepo);       
  },);
  group('AuthNotifire.login', () {
    test('should increase its state', () async {
      expect(authNotifire.state, 0);

      await authNotifire.login("john@example.com", "password");

      expect(authNotifire.state, 1);
    });

    test('should call userRepo.login with same email and password', () async {
      await authNotifire.login("john@example.com", "password");

      verify(mockUserRepo.login("john@example.com", "password")).called(1);
      verifyNoMoreInteractions(mockUserRepo);
    });

    test('should return true when login successfull', () async {
      when(mockUserRepo.login(any, any)).thenAnswer((_) async => true);

      final isSuccess = await authNotifire.login("john@example.com", "password");

      expect(isSuccess, true);
    });

    test('should return false when login failed', () async {
      when(mockUserRepo.login(any, any)).thenAnswer((_) async => false);

      final isSuccess = await authNotifire.login("john@example.com", "password");
      expect(isSuccess, false);
    });
  });

  group('AuthNotifire.logout', () {
    test('should increase its state', () async {
      expect(authNotifire.state, 0);

      await authNotifire.logout();

      expect(authNotifire.state, 1);
    });

    test('should call userRepo logout', () async {
      await authNotifire.logout();

      verify(mockUserRepo.logout()).called(1);
      verifyNoMoreInteractions(mockUserRepo);
    });
  });

  group('AuthNotifire.register', () {
    test('should call userRepo.register', () async {
      await authNotifire.register("John Doe", "john@example.com", "password");
      verify(mockUserRepo.register("John Doe", "john@example.com", "password"))
        .called(1);
    });
    test('should return true when register successufll', () async {
      when(mockUserRepo.register(any, any, any)).thenAnswer((_) async => true);
      final isSuccess = await authNotifire.register(
        "John Doe", "john@example.com", "password"
      );
      expect(isSuccess, true);
    });
    test('should return false when register failed', () async {
      when(mockUserRepo.register(any, any, any)).thenAnswer((_) async => false);
      final isSuccess = await authNotifire.register(
        "John Doe", "john@example.com", "password"
      );
      expect(isSuccess, false);
    });
  });
}