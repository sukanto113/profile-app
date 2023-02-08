
import 'package:flutter/material.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/profile.dart';
import 'package:profile_app/view/widget/buttons.dart';

class HomeBody extends StatelessWidget {
  final User user;
  const HomeBody({
    Key? key,
    required this.user
  }) : super(key: key);

  void _onViewProfileTab(BuildContext context) {
    _openProfilePage(context);
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, ProfilePage(user: user,));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            StringConstants.welcomeToHomeText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedTextButton(
              onPressed: () => _onViewProfileTab(context),
              text: StringConstants.viewProfileButtonText,
            )
          )
        ],
      ),
    );
  }
}
