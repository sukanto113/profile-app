import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/floating_card_form_screen.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view_model/user_manager.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {

  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<void> _onRegisterButtonPressed() async {
    if(!_formKey.currentState!.validate()) return;

    String name = _userNameController.text ;
    String email = _userEmailController.text;
    String password = _userPasswordController.text;

    UserManager userVM = ref.read(userProvider.notifier);
    bool isRegistrationSuccessfull = 
      await userVM.register(name, email, password);
          
    if(isRegistrationSuccessfull){
      bool isLoginSuccessfull = await userVM.login(email, password);
      if(!mounted) return;
      if(!isLoginSuccessfull){
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
    ref.listen(userProvider,(previous, next) {
      if(next != null){
        NavigationUtil.openHomePage(context);
      }
    },);

    return Scaffold(
      body: FloatingCardFormScreen(
        background: const BackgroundWithHomeIcon(),
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 80),
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedFormActionButton(
              buttonText: StringConstants.registerButtonText,
              onPressed: _onRegisterButtonPressed,
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: _onLoginPressed,
              child: const Text(StringConstants.alreadyUserLoginButtonText),
            )
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeaderText(text: StringConstants.registerFormHeader),
              NameFormField(controller: _userNameController),
              EmailFormField(controller: _userEmailController),
              PasswordFormField(controller: _userPasswordController,),
              const SizedBox(height: 50,),
            ],
          ),
        ), 
      ),
    );
  }
}
