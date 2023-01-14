import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view/page/login.dart';

import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      User? user = await UserManager.getCurrentUser();
      if(!mounted) return;
      
      if(user != null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=> HomePage(user: user,)),
          (route) => false
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=> const LoginPage()),
          (route) => false
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(     
      alignment: Alignment.center,                 
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue, 
            Color.fromARGB(255, 115, 30, 227)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: const SizedBox(
        height: 100,
        child: FittedBox(
          child: CircleAvatar(                            
            backgroundColor: Colors.white,
            child: Icon(Icons.home),
          ),
        ),
      ),
    );
  }
}