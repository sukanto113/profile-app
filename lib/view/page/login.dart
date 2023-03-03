import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/util/auth.dart';
import 'package:profile_app/util/build.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/background.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';

class LoginPage extends HookConsumerWidget {

  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  _openRegisterPage(BuildContext context){
    NavigationUtil.pushReplacement(context, RegistrationPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final isMounted = useIsMounted();

    final isLoading = ref.watch(loadingProvider);

    final LoginExecutor executor = LoginExecutor(
      buildInfo: FormBuildInfo(
        context: context,
        ref: ref,
        isMounted: isMounted,
        formKey: _formKey
      ),
      emailController: emailController,
      passwordController: passwordController
    );

    return Stack(
      children: [
        Scaffold(
          body: ThreeLayerFloatingCard(
            marginBottom: 140,

            background: const BackgroundWithHomeIcon(),

            stackedChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedFormActionButton(
                  key: const Key("loginButoon"),
                  buttonText: StringConstants.loginButtonText,
                  onPressed: executor.login,
                ),
                const SizedBox(height: 10,),
                SimpleTextButton(
                  key: const Key("needAccountRegisterButton"),
                  onPressed: () => _openRegisterPage(context),
                  text: StringConstants.needAccountButtonText,
                ),
                const SizedBox(height: 10,),
                GreyTextButton(
                  onPressed: () {  },
                  text: StringConstants.forgetPasswordButtonText,
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
                  EmailFormField(key: const Key("LoginEmailFormField"), controller: emailController),
                  PasswordFormField(key: const Key("LoginPasswordFormField"), controller: passwordController),
                  const SizedBox(height: 50,)
                ],
              ),
            ), 
          ),
        ),

        if(isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if(isLoading)        
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
