import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/snackbar.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';


typedef EditStudentFieldsCallback =
 Function(StudentEditableFields editedFields);
 
class StudentEditableFields{
  const StudentEditableFields({required this.name, required this.roll});
  final String name;
  final String roll;
}

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


class EditStudentView extends ConsumerWidget {
  final Student student;
  const EditStudentView({super.key, required this.student});

  _onEditStudentSave(
    BuildContext context,
    WidgetRef ref,
    StudentEditableFields fields
  ){
    _editStudent(ref, fields);
    SnackBarUitl.showStudentEditSnackBar(context);
  }

  void _editStudent(WidgetRef ref, StudentEditableFields fields) {
    ref.read(studentsListNotifireProvider.notifier).editStudent(student,
      name: fields.name,
      roll: fields.roll,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentFieldsWidget(
      headerText: StringConstants.editStudentFormHeader,
      onEditStudentSave: (editedFields) =>
        _onEditStudentSave(context, ref, editedFields),    
      oldFieldsValue: StudentEditableFields(
        name: student.name, roll: student.roll
      )
    );
  }
}

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
    ref.read(studentsListNotifireProvider.notifier).addStudent(
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

class EditStudentFieldsWidget extends HookWidget {

  final StudentEditableFields oldFieldsValue;
  final String headerText;
  final EditStudentFieldsCallback onEditStudentSave;
  final _formKey = GlobalKey<FormState>();

  EditStudentFieldsWidget({
    super.key,
    required this.headerText,
    required this.onEditStudentSave,
    required this.oldFieldsValue
  });

  @override
  Widget build(BuildContext context) {
    const nameLabel = StringConstants.editStudentFormNameLabel;
    const rollLabel = StringConstants.editStudentFormRollLabel;
    
    final nameController = useTextEditingController(text:oldFieldsValue.name);
    final rollController = useTextEditingController(text: oldFieldsValue.roll);


    return SingleChildScrollView(
      child: Form(
				key: _formKey,
        child: Column(
          children: [
            FormHeaderText(text: headerText,),
            SimpleTextFormField(
              controller: nameController,
              label: nameLabel,
              validatorText: StringConstants.studentEditFormNameValidationText,
            ),
            SimpleTextFormField(
              controller: rollController,
              label: rollLabel,
              validatorText: StringConstants.studentEditFormRollValidationText,
            ),
            const SizedBox(height: 10,),
            RightAlignRow(
              children: [
                SimpleCancleButton(
                  onPressed: () => _onCanclePressed(context),
                ),
                SimpleSaveButton(
                  onPressed: () =>
                   _onSavePressed(
                    context,
                    nameController.text,
                    rollController.text
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSavePressed(BuildContext context, String name, String roll) {
		if(!_formKey.currentState!.validate()) return;
    Navigator.pop(context);
    onEditStudentSave(StudentEditableFields(name: name, roll: roll));
  }

  void _onCanclePressed(BuildContext context){
    Navigator.pop(context);
  }

}

class StudentView extends StatelessWidget {
  final Student student;
  const StudentView({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Name: ${student.name}"),
        Text("Roll: ${student.roll}"),
      ],
    );
  }
}
