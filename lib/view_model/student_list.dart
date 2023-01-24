
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';


class StudentsListViewModel extends StateNotifier<StudentsListState> {
  final StudentRepository repository;

  StudentsListViewModel(this.repository, super.state){
    _refressData();
  }

  Future<void> _refressData() async {
    state = StudentsListState(await repository.readAll()) ;
  }

  void removeStudent(StudentState student) async {   
    await repository.delete(student.id);
    _refressData();

  }

  Future<void> addStudent({String? name, String? roll}) async {
    await repository.create(
      name: name ?? "",
      roll: roll ?? "");
    await _refressData();
  }

  void editStudent(StudentState student, {String? name, String? roll}) async {
    final newStudent = student.copyWith(name: name, roll: roll);
    await repository.update(newStudent);
    _refressData();
  }

}