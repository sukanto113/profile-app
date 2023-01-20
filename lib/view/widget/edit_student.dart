import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view/page/student_crud.dart';

class EditStudentDialog extends ConsumerStatefulWidget {
  final StudentModel student;
  const EditStudentDialog({required this.student, super.key});

  @override
  ConsumerState<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends ConsumerState<EditStudentDialog> {

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
            ref.read(studentsListProvider.notifier).editStudent(widget.student,
              name: _nameController.text,
              roll: _rollController.text,
            );
            Navigator.pop(context);
          },
          child: const Text("Save")
        ),
      ],
    );
  }
}

class StudentDialog extends StatelessWidget {
  final StudentModel student;
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