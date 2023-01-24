import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view/page/students_list.dart';

class EditStudentDialog extends ConsumerWidget {
  final StudentState student;
  const EditStudentDialog({super.key, required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentView(
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

class EditStudentView extends ConsumerStatefulWidget {
  const EditStudentView({super.key, required this.onEditStudentSave, required this.student});
  final EditStudentFields student;

  ///void Function(String name, String roll)
  final void Function(String, String) onEditStudentSave;

  @override
  ConsumerState<EditStudentView> createState() => _EditStudentViewState();
}

class EditStudentFields{
  EditStudentFields({required this.name, required this.roll});
  String name;
  String roll;
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
      title: const Text("Edit student"),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Cancle")
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
            widget.onEditStudentSave(_nameController.text, _rollController.text);
          },
          child: const Text("Save")
        ),
      ],
    );
  }
}

class AddStudentDialog extends ConsumerWidget {
  const AddStudentDialog({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditStudentView(
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