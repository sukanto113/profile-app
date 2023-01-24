import 'package:flutter/material.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/student_crud.dart';

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
      barrierDismissible: false,
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

  static Future<void> showAddStudentDialog(BuildContext context) async {
    return await showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return const AddStudentDialog();
      },
    );
  }

  static void showConfirmDeleteDialog({
    required BuildContext context,
    required VoidCallback onDeleteConfirm
    }) {

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            SimpleCancleButton(onPressed: ()=> Navigator.pop(context)),
            SimpleDeleteButton(
              onPressed: (){
                Navigator.pop(context);
                onDeleteConfirm();
              },
            )
          ],
        );
      }
    );

  }
}