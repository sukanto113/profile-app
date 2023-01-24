import 'package:flutter/material.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/student_crud.dart';

class DialogUtil{
  static void showRegistrationFailedDialog(BuildContext context){
    showTextDialog(
      context, 
      "Registration Failed! \n Please try again later"
    );
  }

  static void showLoginFailedDialog(BuildContext context){
    showTextDialog(context, "Login Failed! \n Wrong email or password");
  }

  static void showTextDialog(BuildContext context, String text){
    showDismissibleDialog(
      context,
      Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  static void showStudentEditDialog(
    BuildContext context, StudentState student
  ){
    showNonDismissibleDialog(context, EditStudentView(student: student));
  }

  static void showAddStudentDialog(BuildContext context) {
    showNonDismissibleDialog(context, const AddStudentView());
  }

  static void showStudentDialog(BuildContext context, StudentState student) {
    showDismissibleDialog(context, StudentView(student: student));
  }

  static void showNonDismissibleDialog(BuildContext context, Widget content){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: content
        );
      },
    );
  }

  static void showDismissibleDialog(BuildContext context, Widget content){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          content: content
        );
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