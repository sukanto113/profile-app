import 'package:flutter/material.dart';

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
}