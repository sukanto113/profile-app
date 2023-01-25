import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/background.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _onLoginButtonPressed() async {
    if(!_formKey.currentState!.validate()) return;
    final String email = _userEmailController.text;
    final String password = _userPasswordController.text;

    final bool isLoginSuccessfull = 
      await ref.read(userProvider.notifier).login(email, password);

    if(!mounted) return;

    if(!isLoginSuccessfull){
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
    ref.listen(userProvider, (previous, next) {
      if(next != null){
        NavigationUtil.openHomePage(context);
      }
    });
    return Scaffold(
      body: ThreeLayerFloatingCard(
        background: const BackgroundWithHomeIcon(),
        marginBottom: 110,
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedFormActionButton(
              buttonText: StringConstants.loginButtonText,
              onPressed: _onLoginButtonPressed
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: _onRegisterPressed,
              child: const Text(StringConstants.needAccountButtonText),
            ),
            const SizedBox(height: 10,),
            const Text(
              StringConstants.forgetPasswordButtonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey
              ),
            )
          ],
        ),
        
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeaderText(text: StringConstants.loginFormHeader),
              EmailFormField(controller: _userEmailController),
              PasswordFormField(controller: _userPasswordController),
              const SizedBox(height: 50,)
            ],
          ),
        ), 
      ),
    );
  }
}
