import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view/page/home.dart';
import 'package:profile_app/view/page/registration.dart';
import '../widget/floating_card_form_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  Future<void> _onLoginButtonPressed() async {
    final bool isLoginSuccessfull = await UserManager.login(
      _userEmailController.text,
      _userPasswordController.text
    );

    if(isLoginSuccessfull){
      User user = await UserManager.getCurrentUser();
      _openHomePage(user);
    }else{
      _showLoginFailedDialog();
    }
  }

  _onRegisterPressed(){
    _openRegisterPage();
  }

  void _openRegisterPage(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=> const RegistrationPage())
    );
  }
  
  Future<void> _openHomePage(User user) async {
    if(!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=> HomePage(user: user,)),
      (route) => false
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
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingCardFormScreen(
        background: const BackgroundWithHomeIcon(),
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 90),
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
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
            ),
            TextButton(
              onPressed: _onRegisterPressed,
              child: const Text("Need an account? REGISTER"),
            ),
            const Text(
              "Forgot password?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey
              ),
            )
          ],
        ),
        
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
