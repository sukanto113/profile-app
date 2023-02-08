import 'package:flutter/material.dart';
import 'package:profile_app/model/student.dart';

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