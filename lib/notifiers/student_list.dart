
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';


class StudentsListNotifire extends StateNotifier<int> {
  final IStudentRepository repository;

  StudentsListNotifire(super.state, this.repository);

  Future<void> removeStudent(Student student) async {   
    await repository.delete(student.id);
    state++;

  }

  Future<void> addStudent({String? name, String? roll}) async {
    await repository.create(
      name: name ?? "",
      roll: roll ?? "");
    state++;
  }

  Future<void> editStudent(Student student, {String? name, String? roll}) async {
    final newStudent = student.copyWith(name: name, roll: roll);
    await repository.update(newStudent);
    state++;
  }

}