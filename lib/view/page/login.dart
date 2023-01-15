import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/floating_card_form_screen.dart';
import 'package:profile_app/view/widget/form_util.dart';


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

    if(!mounted) return;
    if(isLoginSuccessfull){
      NavigationUtil.openHomePage(context);
    }else{
      DialogUtil.showLoginFailedDialog(context);
    }
  }

  _onRegisterPressed(){
    _openRegisterPage();
  }

  void _openRegisterPage(){
    NavigationUtil.pushReplacement(context, const RegistrationPage());
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
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 110),
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedFormActionButton(onPressed: _onLoginButtonPressed),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: _onRegisterPressed,
              child: const Text("Need an account? REGISTER"),
            ),
            const SizedBox(height: 10,),
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
            const FormHeaderText(text: "LOGIN"),
            EmailFormField(userEmailController: _userEmailController),
            PasswordFormField(userPasswordController: _userPasswordController),
            const SizedBox(height: 50,)
          ],
        ), 
      ),
    );
  }
}
