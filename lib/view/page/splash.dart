import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/view/page/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      bool hasUser = await UserManager.hasUser();
      
      if(!mounted) return;

      if(hasUser){
        NavigationUtil.openHomePage(context);
      }else{
        NavigationUtil.pushAndRemoveAllPreviousRoute(context, const LoginPage());
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