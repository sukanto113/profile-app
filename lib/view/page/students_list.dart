import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/view_model/student_list.dart';

final studentsListProvider = 
  StateNotifierProvider<StudentsListViewModel, StudentsListState>(
    (ref) => StudentsListViewModel(StudentsDatabase.instance ,StudentsListState([]))
  );


class StudentList extends HookConsumerWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsListProvider).students;
    final isMounted = useIsMounted();

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
          await ref.read(studentsListProvider.notifier).addStudent();
          if(isMounted()){
            DialogUtil.showStudentEditDialog(context, students.last);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
