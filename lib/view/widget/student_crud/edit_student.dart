import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/values/strings.dart';
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