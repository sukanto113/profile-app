import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/floating_card_form_screen.dart';
import 'package:profile_app/view/widget/form_util.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<void> _onRegisterButtonPressed() async {
    if(!_formKey.currentState!.validate()) return;

    String name = _userNameController.text ;
    String email = _userEmailController.text;
    String password = _userPasswordController.text;
    bool isRegistrationSuccessfull = await UserManager.register(name, email, password);
    
    if(isRegistrationSuccessfull){
      bool isLoginSuccessfull = await UserManager.login(email, password);
      if(!mounted) return;
      if(isLoginSuccessfull){
        NavigationUtil.openHomePage(context);
      }else{
        DialogUtil.showLoginFailedDialog(context);
      }
    }else{
      if(!mounted) return;
      DialogUtil.showRegistrationFailedDialog(context);
    }
  }

  void _onLoginPressed() {
    NavigationUtil.pushReplacement(context, const LoginPage());
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
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedFormActionButton(onPressed: _onRegisterButtonPressed,),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: _onLoginPressed,
              child: const Text("Already a user? LOGIN"),
            )
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeaderText(text: "REGISTER"),
              NameFormField(userNameController: _userNameController),
              EmailFormField(userEmailController: _userEmailController),
              PasswordFormField(userPasswordController: _userPasswordController,),
              const SizedBox(height: 50,),
            ],
          ),
        ), 
      ),
    );
  }
}
