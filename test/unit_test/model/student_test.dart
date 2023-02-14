import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/model/student.dart';

void main() {
  final aStudent = Student(id: 1, name: "John Doe", roll: "101");
  final anotherAStudent = Student(id: 1, name: "John Doe", roll: "101");

  final aStudentWithDifferentId = 
    Student(id: 2, name: "John Doe", roll: "101");

  final aStudentWithDifferentName = 
    Student(id: 1, name: "Jane Doe", roll: "101");

  final aStudentWithDifferentRoll = 
    Student(id: 1, name: "John Doe", roll: "102");

  group('student', () {
    test('with same id, name and roll are equal', () {
      expect(aStudent, equals(anotherAStudent));
    });

    test('with different id are not equal', () {
      expect(aStudent, isNot(equals(aStudentWithDifferentId)));
    });

    test('with different name are not equal', () {
      expect(aStudent, isNot(equals(aStudentWithDifferentName)));
    });

    test('with different roll are not equal', () {
      expect(aStudent, isNot(equals(aStudentWithDifferentRoll)));
    });
  });
  group('student hashCode', () {
    test('with same id, name and roll are equal', () {
      expect(aStudent.hashCode, equals(anotherAStudent.hashCode));
    });

    test('with different id are not equal', () {
      expect(
        aStudent.hashCode,
        isNot(equals(aStudentWithDifferentId.hashCode))
      );
    });

    test('with different name are not equal', () {
      expect(
        aStudent.hashCode,
        isNot(equals(aStudentWithDifferentName.hashCode))
      );
    });

    test('with different roll are not equal', () {
      expect(
        aStudent.hashCode,
        isNot(equals(aStudentWithDifferentRoll.hashCode))
      );
    });
  });
}