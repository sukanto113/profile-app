import 'package:flutter/material.dart';
import 'package:profile_app/view/page/splash.dart';
import 'package:profile_app/view/page/student_crud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentCRUD(),
    );
  }
}
