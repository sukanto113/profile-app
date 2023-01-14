import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view/page/home.dart';
import 'package:profile_app/view/page/login.dart';
import '/view/floating_card_form_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  Future<void> _onRegisterButtonPressed() async {
    String name = _userNameController.text ;
    String email = _userEmailController.text;
    String password = _userPasswordController.text;
    bool isRegistrationSuccessfull = await UserManager.register(name, email, password);
    
    if(isRegistrationSuccessfull){
      bool isLoginSuccessfull = await UserManager.login(email, password);
      if(isLoginSuccessfull){
       User user = await UserManager.getCurrentUser();
        _openHomePage(user);
      }else{
        _showLoginFailedDialog();
      }
    }else{
      _showRegistrationFailedDialog();
    }
  }

  void _onLoginPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=> const LoginPage())
    );
  }

  //todo remove this duplicate function from this and login file
  void _openHomePage(User user) {
    if(!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=> HomePage(user: user,)),
      (route) => false
    );
  }

  void _showRegistrationFailedDialog(){
    if(!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text(
            "Registration Failed! \n Please try again later",
           textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  void _showLoginFailedDialog(){
    if(!mounted) return;

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

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingCardFormScreen(
        background: const BackgroundWithHomeIcon(),
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 80),
        stackedChild: [
          Positioned(
            bottom: 60,
            left: 60,
            right: 60,
            child: ElevatedButton(
              onPressed: _onRegisterButtonPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
              child: const Text(
                "REGISTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ),
            
          Positioned(
            bottom: 0,
            left: 60,
            right: 60,
            child: TextButton(
              onPressed: _onLoginPressed,
              child: const Text("Already a user? LOGIN"),
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
                "REGISTER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            TextFormField(
              controller: _userNameController,
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                hintText: 'John Doe',
                labelText: 'NAME *',
              ),
            ),
            TextFormField(
              controller: _userEmailController,
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
                controller: _userPasswordController,
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