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

  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  Future<void> _onRegisterButtonPressed() async {
    String name = userNameController.text ;
    String email = userEmailController.text;
    String password = userPasswordController.text;
    bool? isSuccessfull = await UserManager.register(name, email, password);

    if(isSuccessfull){
       User? user = await UserManager.login(email, password);
      if(user != null){
        _openHomePage(user);
      }else{
        _showWLoginFailedDialog();
      }
    }
  }

  //todo remove this duplicate function from this and login file
  void _openHomePage(User user) {
    if(!mounted) return;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> HomePage(user: user,))
    );
  }

  void _showWLoginFailedDialog(){
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
    userNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
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
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const LoginPage())
                );
              },
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
              controller: userNameController,
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                hintText: 'John Doe',
                labelText: 'NAME *',
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