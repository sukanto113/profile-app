import 'package:flutter/material.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/util/dialog.dart';

class StudentCRUD extends StatefulWidget {
  const StudentCRUD({super.key});

  @override
  State<StudentCRUD> createState() => _StudentCRUDState();
}

class _StudentCRUDState extends State<StudentCRUD> {
  final students = [
    Student(id: 1, name: "Sukanto Saha", roll: '1'),
    Student(id: 2, name: "Animesh Kumar", roll: '2'),
    Student(id: 3, name: "Pradip Chandraw", roll: '3'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(students[index].name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      await DialogUtil.showStudentEditDialog(context, students[index]);
                      setState(() {
                      });
                    },
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: (){
                      students.remove(students[index]);
                      setState(() {
                        
                      });
                    },
                    icon: const Icon(Icons.delete)
                  ),
                ],
              ),
              subtitle: Text(students[index].roll),
              onTap: (){
                DialogUtil.showStudentDialog(context, students[index]);
              },
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newStudent = Student(id: 1, name: "", roll: "");
          students.add(newStudent);
          await DialogUtil.showStudentEditDialog(context, newStudent);
          setState(() {
            
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}