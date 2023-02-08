import 'package:profile_app/model/student.dart';

abstract class IStudentRepository{
  Future<Student> create({
    required String name,
    required String roll,
    });
  Future<Student> read(int id);
  Future<Iterable<Student>> readAll();
  Future<int> update(Student student);
  Future<int> delete(int id);
  Future<void> close();

}
class InMemoryStudentRepo extends IStudentRepository {
  
  List<Student> students = [];
  int nextIndex = 1;
  
  @override
  Future<void> close() async {
  }

  @override
  Future<Student> create({required String name, required String roll}) async {
    var student = Student(id: nextIndex++, name: "", roll: "");
    students.add(student);
    return student;
  }

  @override
  Future<int> delete(int id) async {
    final student = await read(id); 
    students.remove(student);
    return 1;
  }

  @override
  Future<Student> read(int id) async {
    for(final student in students){
      if(student.id == id) return student;
    }
    throw Exception("id not found");
  }

  @override
  Future<Iterable<Student>> readAll() async {
    return students;
  }

  @override
  Future<int> update(Student student) async {
    var index = _getIndex(student);
    students[index] = student;
    return index;
  }

  int _getIndex(Student student){
    for(var i = 0; i < students.length; ++i){
      if(student.id == students[i].id) return i;
    }
    throw Exception("id not found");
  }
}
