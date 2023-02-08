import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/util/auth.dart';
import 'package:profile_app/util/build.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/background.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';

class RegistrationPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  RegistrationPage({super.key});

  void _openLoginPage(BuildContext context) {
    NavigationUtil.pushReplacement(context, LoginPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: "");
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final isMounted = useIsMounted();
    final isLoading = ref.watch(loadingProvider);
    ref.listen(authNotifireProvider,(previous, next) {
      if(next != null){
        NavigationUtil.openHomePage(context);
      }
    },);

    RegistrationExecutor executor = RegistrationExecutor(
      buildInfo: FormBuildInfo(context: context, 
        ref: ref,
        isMounted: isMounted,
        formKey: _formKey
      ),
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController
    );

    return Stack(
      children: [
        Scaffold(
          body: ThreeLayerFloatingCard(
            marginBottom: 80,

            background: const BackgroundWithHomeIcon(),

            stackedChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedFormActionButton(
                  buttonText: StringConstants.registerButtonText,
                  onPressed: executor.register,
                ),
                const SizedBox(height: 10,),
                SimpleTextButton(
                  onPressed: () => _openLoginPage(context),
                  text: StringConstants.alreadyUserLoginButtonText,
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
                  NameFormField(controller: nameController),
                  EmailFormField(controller: emailController),
                  PasswordFormField(controller: passwordController,),
                  const SizedBox(height: 50,),
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
