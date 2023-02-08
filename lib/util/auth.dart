
import 'package:flutter/material.dart';
import 'package:profile_app/util/build.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/view_model/user_manager.dart';



class RegistrationExecutor{

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginExecutor loginExecutor;
  final FormBuildInfo buildInfo;

  RegistrationExecutor({
    required this.buildInfo,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : loginExecutor = LoginExecutor(
    buildInfo: buildInfo,
    emailController: emailController,
    passwordController: passwordController, 
  );

  void register() async {
    if(!buildInfo.formKey.currentState!.validate()) return;
    AuthNotifire userVM = buildInfo.ref.read(authNotifireProvider.notifier);
    buildInfo.ref.read(loadingProvider.notifier).state = true;

    bool isRegistrationSuccessfull = 
      await userVM.register(
        nameController.text,
        emailController.text,
        passwordController.text
      );
    buildInfo.ref.read(loadingProvider.notifier).state = false;

    if(isRegistrationSuccessfull){
      loginExecutor.login();
    }else{
      if(!buildInfo.isMounted()) return;
      DialogUtil.showRegistrationFailedDialog(buildInfo.context);
    }
  }

}

class LoginExecutor{

  final FormBuildInfo buildInfo;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginExecutor({
    required this.buildInfo,
    required this.emailController,
    required this.passwordController,
  });

  void login() async {
    if(!buildInfo.formKey.currentState!.validate()) return;
    buildInfo.ref.read(loadingProvider.notifier).state = true;
    final bool isLoginSuccessfull = 
      await buildInfo.ref.read(authNotifireProvider.notifier).login(
        emailController.text,
        passwordController.text
      );
    buildInfo.ref.read(loadingProvider.notifier).state = false;

    if(!isLoginSuccessfull){
      if(!buildInfo.isMounted()) return;
      DialogUtil.showLoginFailedDialog(buildInfo.context);
    }
  }
}
