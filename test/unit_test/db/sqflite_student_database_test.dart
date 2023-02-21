import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/db/sqflite_student_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:sqflite/sqflite.dart';

import '../../lib/sqflite/test_util.dart';

void main() {
  group('SqfliteStudentsRepository', () {    
    late SqfliteStudentsRepository repository;
    late Database database;

    setUpAll(() {
      setupSqfliteTestEnv();
    });

    setUp(() async {
      final path = await SqfliteStudentsRepository.getDatabaseFilePath();
      await deleteDatabase(path);
      repository = SqfliteStudentsRepository();
      database = await repository.database;
    });

    test('database version should be 1', () async {
      final version = await database.getVersion();
      expect(version, equals(1));
    });

    test('students table should have _id, name and roll column', () async {
      final columns = await queryColumnsName(database, 'students');
      expect(columns, containsAll(["_id", "name", "roll"]));
    });

    group('.', () {
      setUp(() async {
        await database.insert('students', {'name': "John Doe", "roll": "101"});
        await database.insert('students', {'name': "Jack", "roll": "102"});
        await database.insert('students', {'name': "Jane Doe", "roll": "103"});
      });

      test('create should insert a student in database', () async {
        await repository.create(name: "Josep", roll: "104");

        final rows = await database.rawQuery("SELECT * FROM students;");
        expect(rows, equals([
          {'_id': 1, 'name': "John Doe", "roll": "101"},
          {'_id': 2, 'name': "Jack", "roll": "102"},
          {'_id': 3, 'name': "Jane Doe", "roll": "103"},
          {'_id': 4, 'name': 'Josep', 'roll': '104'}
        ]));
      });

      test('read should return student with associated id', () async {

        final student = await repository.read(2);

        expect(student, equals(Student(id: 2, name: 'Jack', roll: '102')));
      });

      test('read should throw Exception if id not found', () async {        
        expect(
          () async => await repository.read(4),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message, "message", "Id 4 not found"
          ))
        );
      });

      test('readAll should return all students in database', () async {
        final students = await repository.readAll();
        expect(students, equals([
          Student(id: 1, name: 'John Doe', roll: '101'),
          Student(id: 2, name: 'Jack', roll: '102'),
          Student(id: 3, name: 'Jane Doe', roll: '103')
        ]));
      });

      test('update should update a student', () async {
        await repository.update(Student(id: 1, name: "Josep", roll: "104"));
        
        final rows = await database.rawQuery("SELECT * FROM students WHERE _id = 1;");
        expect(rows.first, equals({'_id': 1, 'name': 'Josep', 'roll':'104'}));
      });

      test('delete should delete a student', () async {
        await repository.delete(2);

        final rows = await database.rawQuery("SELECT * FROM students;");
        expect(rows, equals([
          {'_id': 1, 'name': "John Doe", "roll": "101"},
          {'_id': 3, 'name': "Jane Doe", "roll": "103"},
        ]));
      });

    });
  });
}
