import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/background.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/form.dart';
import 'package:profile_app/view/widget/layout.dart';
import 'package:profile_app/view_model/user_manager.dart';


class RegistrationPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  RegistrationPage({super.key});

  Future<void> _onRegisterButtonPressed(
    {
      required BuildContext context,
      required WidgetRef ref, 
      required String name,
      required String email,
      required String password,
      required IsMounted isMounted
    }
  ) async {
    if(!_formKey.currentState!.validate()) return;
    UserManager userVM = ref.read(userProvider.notifier);
    bool isRegistrationSuccessfull = 
      await userVM.register(name, email, password);
          
    if(isRegistrationSuccessfull){
      bool isLoginSuccessfull = await userVM.login(email, password);
      if(!isLoginSuccessfull){
        if(!isMounted()) return;
        DialogUtil.showLoginFailedDialog(context);
      }
    }else{
      if(!isMounted()) return;
      DialogUtil.showRegistrationFailedDialog(context);
    }
  }

  void _onLoginPressed(BuildContext context) {
    NavigationUtil.pushReplacement(context, LoginPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController(text: "");
    final userEmailController = useTextEditingController(text: "");
    final userPasswordController = useTextEditingController(text: "");
    final isMounted = useIsMounted();
    
    //todo make it futureProvider
    ref.listen(userProvider,(previous, next) {
      if(next != null){
        NavigationUtil.openHomePage(context);
      }
    },);

    return Scaffold(
      body: ThreeLayerFloatingCard(
        background: const BackgroundWithHomeIcon(),
        marginBottom: 80,
        stackedChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedFormActionButton(
              buttonText: StringConstants.registerButtonText,
              onPressed: () =>  _onRegisterButtonPressed(
                context: context,
                ref: ref,
                name: userNameController.text,
                email: userEmailController.text,
                password: userPasswordController.text,
                isMounted: isMounted
              ),
            ),
            const SizedBox(height: 10,),
            SimpleTextButton(
              onPressed: () => _onLoginPressed(context),
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
              NameFormField(controller: userNameController),
              EmailFormField(controller: userEmailController),
              PasswordFormField(controller: userPasswordController,),
              const SizedBox(height: 50,),
            ],
          ),
        ), 
      ),
    );
  }
}
