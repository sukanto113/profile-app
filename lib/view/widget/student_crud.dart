import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/providers.dart';
import 'package:profile_app/strings.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/snackbar.dart';
import 'package:profile_app/view/widget/buttons.dart';


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
    final students = ref.watch(studentsListProvider).students;

    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            child: StudentListItem(student: students.elementAt(index)),
          );
        },
    );
  }
}

class StudentListItem extends ConsumerWidget {
  const StudentListItem({
    Key? key,
    required this.student,
  }) : super(key: key);

  final StudentState student;

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
    ref.read(studentsListProvider.notifier).removeStudent(student);
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
  final StudentState student;
  const EditStudentView({super.key, required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentFields(
      headerText: "Edit student",
      onEditStudentSave: (editedFields){
        ref.read(studentsListProvider.notifier).editStudent(student,
          name: editedFields.name,
          roll: editedFields.roll,
        );
        SnackBarUitl.showStudentEditSnackBar(context);
      },       
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
     StudentEditableFields fields)
  {
    _addNewStudent(ref, fields);
    SnackBarUitl.showStudentAddSnackBar(context);
  }

  void _addNewStudent(WidgetRef ref, StudentEditableFields fields){
    ref.read(studentsListProvider.notifier).addStudent(
      name: fields.name,
      roll: fields.roll,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentFields(
      headerText: StringConstants.addStudentFormHeader,   
      onEditStudentSave: (editedFields) =>
       _onNewStudentAdd(context, ref, editedFields),
      oldFieldsValue: const StudentEditableFields(name: "", roll: "")
    );
  }
}

class EditStudentFields extends ConsumerStatefulWidget {
  const EditStudentFields({
    super.key,
    required this.headerText,
    required this.onEditStudentSave,
    required this.oldFieldsValue
  });

  final StudentEditableFields oldFieldsValue;
  final String headerText;

  final EditStudentFieldsCallback onEditStudentSave;

  @override
  ConsumerState<EditStudentFields> createState() => _EditStudentViewState();
}




class _EditStudentViewState extends ConsumerState<EditStudentFields> {

  final _nameController = TextEditingController();
  final _rollController = TextEditingController();


  @override
  void initState() {
    _nameController.text = widget.oldFieldsValue.name;
    _rollController.text = widget.oldFieldsValue.roll;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.headerText),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'NAME',
              ),
            ),
            TextFormField(
              controller: _rollController,
              decoration: const InputDecoration(
                labelText: 'ROLL',
              ),
            ),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DialogCancleButton(),
                  SimpleSaveButton(
                    onPressed: (){
                      Navigator.pop(context);

                      final name = _nameController.text;
                      final roll = _rollController.text;
                      widget.onEditStudentSave(
                        StudentEditableFields(name: name, roll: roll)
                      );

                    },
                  ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}

class StudentView extends StatelessWidget {
  final StudentState student;
  const StudentView({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Name: ${student.name}"),
          Text("Roll: ${student.roll}"),
        ],
      ),
    );
  }
}