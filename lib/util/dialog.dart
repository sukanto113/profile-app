import 'package:flutter/material.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view/widget/edit_student.dart';

class DialogUtil{
  static void showRegistrationFailedDialog(BuildContext context){
    _showTextDialog(
      context, 
      "Registration Failed! \n Please try again later"
    );
  }

  static void showLoginFailedDialog(BuildContext context){
    _showTextDialog(context, "Login Failed! \n Wrong email or password");
  }

  static void _showTextDialog(BuildContext context, String text){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
          text,
           textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  static Future<dynamic> showStudentEditDialog(BuildContext context, StudentState student) async {
    return await showDialog(
      context: context, 
      builder: (context) {
        return EditStudentDialog(
          student: student,
        );
      },
    );
  }

  static void showStudentDialog(BuildContext context, StudentState student) {
    showDialog(
      context: context, 
      builder: (context) {
        return StudentDialog(
          student: student,
        );
      },
    );
  }
}