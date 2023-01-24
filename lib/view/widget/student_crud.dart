import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/providers.dart';
import 'package:profile_app/strings.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/view/widget/buttons.dart';



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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                StringConstants.snackBarStudentDeleteMessage
                              ),
                              behavior: SnackBarBehavior.floating,
                            )
                          );
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


class EditStudentDialog extends ConsumerWidget {
  final StudentState student;
  const EditStudentDialog({super.key, required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentView(
      headerText: "Edit student",
      onEditStudentSave: (String name, String roll){
        ref.read(studentsListProvider.notifier).editStudent(student,
          name: name,
          roll: roll,
        );
      },       
      student: EditStudentFields(name: student.name, roll: student.roll)
    );
  }
}

class AddStudentDialog extends ConsumerWidget {
  const AddStudentDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentView(
      headerText: "Add student",
      onEditStudentSave: (String name, String roll){
        ref.read(studentsListProvider.notifier).addStudent(
          name: name,
          roll: roll,
        );
      },       
      student: EditStudentFields(name: "", roll: "")
    );
  }
}

class EditStudentView extends ConsumerStatefulWidget {
  const EditStudentView({
    super.key,
    required this.headerText,
    required this.onEditStudentSave,
    required this.student
  });

  final EditStudentFields student;
  final String headerText;

  ///void Function(String name, String roll)
  final void Function(String, String) onEditStudentSave;

  @override
  ConsumerState<EditStudentView> createState() => _EditStudentViewState();
}

class _EditStudentViewState extends ConsumerState<EditStudentView> {

  final _nameController = TextEditingController();
  final _rollController = TextEditingController();


  @override
  void initState() {
    _nameController.text = widget.student.name;
    _rollController.text = widget.student.roll;
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
                      widget.onEditStudentSave(_nameController.text, _rollController.text);
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


class EditStudentFields{
  EditStudentFields({required this.name, required this.roll});
  String name;
  String roll;
}

class StudentDialog extends StatelessWidget {
  final StudentState student;
  const StudentDialog({super.key, required this.student});

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