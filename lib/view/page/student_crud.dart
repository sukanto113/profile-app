import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/util/dialog.dart';
// import 'package:profile_app/model/student.dart';
// import 'package:profile_app/util/dialog.dart';


class StudentsListModel{
  final Iterable<StudentModel> students;
  StudentsListModel(Iterable<StudentModel> students):students = List.unmodifiable(students);
}


class StudentModel{
  
  final int id;
  final String name;
  final String roll;

  const StudentModel({
    required this.id,
    required this.name,
    required this.roll
  });

  StudentModel copyWith({String? name, String? roll}){
    return StudentModel(
      id: id,
      name: name ?? this.name,
      roll: roll ?? this.roll,
    );
  }
}



class StudentsListViewModel extends StateNotifier<StudentsListModel> {
  final StudentRepository repository;

  StudentsListViewModel(this.repository, super.state){
    _refressData();
  }

  void _refressData() async {
    state = StudentsListModel(await repository.readAll()) ;
  }

  void removeStudent(StudentModel student) async {   
    await repository.delete(student.id);
    _refressData();

  }

  void addStudent() async {
    await repository.create(name: "", roll: "");
    _refressData();
  }

  void editStudent(StudentModel student, {String? name, String? roll}) async {
    final newStudent = StudentModel(
      id: student.id,
      name: name ?? student.name,
      roll: roll ?? student.roll,
    );
    await repository.update(newStudent);
    _refressData();
  }

}



final studentsListProvider = 
  StateNotifierProvider<StudentsListViewModel, StudentsListModel>(
    (ref) => StudentsListViewModel(StudentsDatabase.instance ,StudentsListModel([]))
  );



class StudentCRUD extends ConsumerWidget {
  const StudentCRUD({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsListProvider).students;

    return Scaffold(body: Center(
      child: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(students.elementAt(index).name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      DialogUtil.showStudentEditDialog(context, students.elementAt(index));
                    },
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: (){
                      ref.read(studentsListProvider.notifier).
                        removeStudent(students.elementAt(index));
                    },
                    icon: const Icon(Icons.delete)
                  ),
                ],
              ),
              subtitle: Text(students.elementAt(index).id.toString()),
              onTap: (){
                DialogUtil.showStudentDialog(context, students.elementAt(index));
              },
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ref.read(studentsListProvider.notifier).addStudent();
          // var newStudent = Student(id: 1, name: "", roll: "");
          // students.add(newStudent);
          // await DialogUtil.showStudentEditDialog(context, newStudent);
          // setState(() {
            
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// class StudentCRUD extends StatefulWidget {
//   const StudentCRUD({super.key});

//   @override
//   State<StudentCRUD> createState() => _StudentCRUDState();
// }

// class _StudentCRUDState extends State<StudentCRUD> {

// }