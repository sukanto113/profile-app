import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view/page/registration.dart';
import '/view/floating_card_form_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  void _onLoginButtonPressed(){
    UserManager.login(
      context,
      userEmailController.text,
      userPasswordController.text
    );
  }

  @override
  void dispose() {
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login"),
      // ),
      body: FloatingCardFormScreen(
        background: const BackgroundWithHomeIcon(),
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 120),
        stackedChild: [
          Positioned(
            bottom: 100,
            left: 60,
            right: 60,
            child: ElevatedButton(
              onPressed: _onLoginButtonPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ),
            
          Positioned(
            bottom: 40,
            left: 60,
            right: 60,
            child: TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const RegistrationPage())
                );
              },
              child: const Text("Need an account? REGISTER"),
            )
          ),
            
          Positioned(
            bottom: 0,
            left: 60,
            right: 60,
            child: TextButton(
              onPressed: (){},
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            )
          ),
        ],
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            TextFormField(
              controller: userEmailController,
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                hintText: 'user@example.com',
                labelText: 'EMAIL *',
              ),
              validator: (String? value) {
                if( value == ""){
                  return null;
                }else{
                  return (value !=null && EmailValidator.validate(value)) ? null : "Please enter a valid email";
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: TextFormField(
                controller: userPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'PASSWORD *',
                ),
              ),
            ),
          ],
        ), 
      ),
    );
  }
}
