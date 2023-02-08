import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/view/page/home.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/error.dart';


class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(initialAppStateProvider).when(
      data: (data) {
        if(data.user != null){
          return const HomePage();
        }else{
          return LoginPage();
        }
      },
      error: (error, stackTrace) {
        return const TryAgainErrorWidget();
      },
      loading: () {
        return const SplashView();
      },
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(     
      alignment: Alignment.center,                 
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue, 
            Color.fromARGB(255, 115, 30, 227)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: const SizedBox(
        height: 100,
        child: FittedBox(
          child: CircleAvatar(                            
            backgroundColor: Colors.white,
            child: Icon(Icons.home),
          ),
        ),
      ),
    );
  }
}