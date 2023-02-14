import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/model/user.dart';

void main() {
  const johnName = "John Doe";
  const johnEmail = "jonh.doe@example.com";

  const janeName = "Jane Doe";
  const janeEmail = "jane.doe@example.com";

  final userWithJohnNameAndJohnEmail = 
    User(name: johnName, email: johnEmail);

  final anotherUserWithJohnNameAndJohnEmail = 
    User(name: johnName, email: johnEmail);

  final userWithJaneNameAndJohnEmail = 
    User(name: janeName, email: johnEmail);

  final userWithJohnNameAndJaneEmail = 
    User(name: johnName, email: janeEmail);

  group('user', () {

    test('with same name and email are equal', () {
      expect(
        userWithJohnNameAndJohnEmail,
        equals(anotherUserWithJohnNameAndJohnEmail)
      );
    });

    test('with different name are not equal', () {
      expect(
        userWithJohnNameAndJohnEmail,
        isNot(equals(userWithJaneNameAndJohnEmail))
      );
    });

    test('with different email are not equal', () {
      expect(
        userWithJohnNameAndJohnEmail,
        isNot(equals(userWithJohnNameAndJaneEmail))
      );
    });
  });

  group('user hashCode', () {
    test('with same name and email are equal', () {
      expect(
        userWithJohnNameAndJohnEmail.hashCode,
        equals(anotherUserWithJohnNameAndJohnEmail.hashCode)
      );
    });

    test('with different name are not equal', () {
      expect(
        userWithJohnNameAndJohnEmail.hashCode, 
        isNot(equals(userWithJaneNameAndJohnEmail.hashCode))
      );
    });

    test('with different email are not equal', () {
      expect(
        userWithJohnNameAndJohnEmail.hashCode, 
        isNot(equals(userWithJohnNameAndJaneEmail.hashCode))
      );
    });
  });
}