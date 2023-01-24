import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/snackbar.dart';
import 'package:profile_app/view/widget/buttons.dart';


typedef EditStudentFieldsCallback =
 Function(EditableStudentFields editedFields);
 
class EditableStudentFields{
  EditableStudentFields({required this.name, required this.roll});
  String name;
  String roll;
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
                      DialogUtil.showConfirmDeleteDialog(
                        context: context,
                        onDeleteConfirm:(){
                          ref.read(studentsListProvider.notifier).
                            removeStudent(students.elementAt(index));
                          SnackBarUitl.showStudentDeleteSnackBar(context);
                        }
                      );
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
      oldFieldsValue: EditableStudentFields(
        name: student.name, roll: student.roll
      )
    );
  }
}

class AddStudentView extends ConsumerWidget {
  const AddStudentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentFields(
      headerText: "Add student",   
      onEditStudentSave: (editedFields) {
        ref.read(studentsListProvider.notifier).addStudent(
          name: editedFields.name,
          roll: editedFields.roll,
        );
        SnackBarUitl.showStudentAddSnackBar(context);
      },  
      oldFieldsValue: EditableStudentFields(name: "", roll: "")
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

  final EditableStudentFields oldFieldsValue;
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
                        EditableStudentFields(name: name, roll: roll)
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