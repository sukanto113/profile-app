import 'package:flutter/material.dart';
import 'package:profile_app/view/page/home.dart';

class UserManager{
  static void login(BuildContext context, String email, String password){
    _openHomePage(context);
  }

  static void register(BuildContext context, String name, String email, String password){
    _openHomePage(context);
  }

  static void _openHomePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> const HomePage())
    );
  }

  static void _showWLoginFailedDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text(
            "Login Failed! \n Wrong email or password",
           textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}