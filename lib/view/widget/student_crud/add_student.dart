import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/notifiers/student_list.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/util/snackbar.dart';
import 'package:profile_app/view/widget/student_crud/edit_student.dart';



class AddStudentView extends ConsumerWidget {
  const AddStudentView({super.key});

  void _onNewStudentAdd(
     BuildContext context,
     WidgetRef ref,
     StudentEditableFields fields
  ){
    _addNewStudent(ref, fields);
    SnackBarUitl.showStudentAddSnackBar(context);
  }

  void _addNewStudent(WidgetRef ref, StudentEditableFields fields){
    ref.read<StudentsListNotifire>(studentsListNotifireProvider.notifier).addStudent(
      name: fields.name,
      roll: fields.roll,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentFieldsWidget(
      headerText: StringConstants.addStudentFormHeader,   
      onEditStudentSave: (editedFields) =>
       _onNewStudentAdd(context, ref, editedFields),
      oldFieldsValue: const StudentEditableFields(name: "", roll: "")
    );
  }
}
