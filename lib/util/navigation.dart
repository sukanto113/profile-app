import 'package:flutter/material.dart';
import 'package:profile_app/view/page/home.dart';

class NavigationUtil{
  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> page)
    );
  }  

  static void pushAndRemoveAllPreviousRoute(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=> page),
      (route) => false
    );
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=> page)
    );
  }

  static void openHomePage(BuildContext context) {
    NavigationUtil.
      pushAndRemoveAllPreviousRoute(context, const HomePage());
  }
}