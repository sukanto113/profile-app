import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view/page/login.dart';
import 'view/page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<User?>(
        future: UserManager.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data != null){
              return const HomePage();
            }
          }
          return const LoginPage();
        },
      )
    );
  }
}
