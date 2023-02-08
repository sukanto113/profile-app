import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/background.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';


class LoginPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  Future<void> _onLoginButtonPressed(
    {
      required BuildContext context,
      required WidgetRef ref,
      required String email,
      required String password,
      required IsMounted isMounted,
    }
  ) async {
    if(!_formKey.currentState!.validate()) return;

    final bool isLoginSuccessfull = 
      await ref.read(userProvider.notifier).login(email, password);

    if(!isLoginSuccessfull){
      if(!isMounted()) return;
      DialogUtil.showLoginFailedDialog(context);
    }
  }

  _onRegisterPressed(BuildContext context){
    _openRegisterPage(context);
  }

  void _openRegisterPage(BuildContext context){
    NavigationUtil.pushReplacement(context, RegistrationPage());
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmailController = useTextEditingController(text: "");
    final userPasswordController = useTextEditingController(text: "");
    final isMounted = useIsMounted();

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
              onPressed: ()=> _onLoginButtonPressed(
                context: context,
                ref: ref,
                email: userEmailController.text,
                password: userPasswordController.text,
                isMounted: isMounted
              )
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () => _onRegisterPressed(context),
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
              EmailFormField(controller: userEmailController),
              PasswordFormField(controller: userPasswordController),
              const SizedBox(height: 50,)
            ],
          ),
        ), 
      ),
    );
  }
}
