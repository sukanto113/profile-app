import 'package:flutter/material.dart';
import 'package:profile_app/strings.dart';

class SnackBarUitl{

  static showSnackBar(BuildContext context, String text){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
        )
      );
  }

  static void showStudentDeleteSnackBar(BuildContext context){
    showSnackBar(
      context,
      StringConstants.snackBarStudentDeleteMessage
    );
  }

  static void showStudentAddSnackBar(BuildContext context){
    showSnackBar(
      context,
      StringConstants.snackBarStudentAddMessage,
    );
  }

  static void showStudentEditSnackBar(BuildContext context){
    showSnackBar(
      context,
      StringConstants.snackBarStudentEditMessage,
    );
  }
}
