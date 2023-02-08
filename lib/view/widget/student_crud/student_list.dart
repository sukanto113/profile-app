import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/snackbar.dart';
import 'package:profile_app/view/widget/buttons.dart';

class StudentListView extends ConsumerWidget {
  const StudentListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(studentsListProvider).when(
      data: (students) {
        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Card(
              child: StudentListItem(student: students.elementAt(index)),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text(
            "Error!",
            style: TextStyle(color: Colors.red),
          )
        );
      }, 
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );

  }
}

class StudentListItem extends ConsumerWidget {
  const StudentListItem({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  void _onEditTap(BuildContext context){
    DialogUtil.showStudentEditDialog(context, student);
  }

  void _onDeleteTap(BuildContext context, WidgetRef ref){
    DialogUtil.showConfirmDeleteDialog(
      context: context,
      onDeleteConfirm:(){
        _deleteStudent(ref);
        SnackBarUitl.showStudentDeleteSnackBar(context);
      }
    );
  }

  void _onListItemTap(BuildContext context){
    DialogUtil.showStudentDialog(context, student);
  }

  void _deleteStudent(WidgetRef ref) {
    ref.read(studentsListNotifireProvider.notifier).removeStudent(student);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(student.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditIconButton(onPressed: ()=> _onEditTap(context)),
          DeleteIconButton(onPressed: () => _onDeleteTap(context, ref)),
        ],
      ),
      subtitle: Text(student.id.toString()),
      onTap: ()=> _onListItemTap(context),
    );
  }
}