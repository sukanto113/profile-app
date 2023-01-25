import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/providers.dart';
import 'package:profile_app/user_manager/user_reopsitory.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  void _onGoBackPressed(BuildContext context){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Profile")),
        automaticallyImplyLeading: false,
      ),
      body:  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _UserImage(),
            const _UserName(),
            const _UserBio(),
            GoBackElevatedButton(onPressed: () => _onGoBackPressed(context))
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: CirculerImage(
        image: AssetImage("images/sukanto_profile_pic.jpg"),
      ),
    );
  }
}

class _UserBio extends StatelessWidget {
  const _UserBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: const Text(
        "Hi, I'm Sukanto Saha, I'm M.Sc. student of Rajshahi "
        "University. I completed my graduation in "
        "Mathematics from Rajshahi University.",
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }
}


class _UserName extends ConsumerWidget {
  const _UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? User.emptyUser;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 28,
        ),
      ),
    );
  }
}