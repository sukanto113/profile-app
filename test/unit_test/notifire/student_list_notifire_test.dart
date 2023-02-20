import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/notifiers/student_list_notifire.dart';

@GenerateNiceMocks([MockSpec<IStudentRepository>()])
import 'student_list_notifire_test.mocks.dart';
void main() {
  late StudentsListNotifire studentsListNotifire;
  late MockIStudentRepository mockStudentRepo;
  setUp(() {
    mockStudentRepo = MockIStudentRepository();
    studentsListNotifire = StudentsListNotifire(0, mockStudentRepo);
  });
  group('StudentListNotifire.removeStudent', () {
    test('should increase its state', () async {
      expect(studentsListNotifire.state, equals(0));

      await studentsListNotifire.removeStudent(
        Student(id: 1, name: "John Doe", roll: "101")
      );

      expect(studentsListNotifire.state, equals(1));
    });

    test('should call repo remove with same', () async {
      await studentsListNotifire.removeStudent(
        Student(id: 1, name: "John Doe", roll: "101")
      );

      verify(mockStudentRepo.delete(1)).called(1);
    });
  });
  group('StudentListNotifire.addStudent', () {
    test('should increase its state', () async {
      expect(studentsListNotifire.state, equals(0));

      await studentsListNotifire.addStudent( name: "John Doe", roll: "101");

      expect(studentsListNotifire.state, equals(1));
    });

    test('should call repo create with name and roll', () async {
      await studentsListNotifire.addStudent(name: "John Doe", roll: "101");

      verify(mockStudentRepo.create(name: "John Doe", roll: "101")).called(1);
    });
  });

  group('StudentListNotifire.editStudent', () {
    test('should increase its state', () async {
      expect(studentsListNotifire.state, equals(0));

      await studentsListNotifire.editStudent(
        Student(id: 1, name: "John Doe", roll: "102"),
        name: "Jane Doe", roll: "101"
      );

      expect(studentsListNotifire.state, equals(1));
    });

    test('should call repo update', () async {
      await studentsListNotifire.editStudent(
        Student(id: 1, name: "John Doe", roll: "101"),
        name: "Jane Doe", roll: "102"
      );

      verify(mockStudentRepo.update(
        Student(id: 1, name: "Jane Doe", roll: "102")
      )).called(1);
    });
  });
}