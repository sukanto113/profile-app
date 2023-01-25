import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/values/strings.dart';
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
        title: const Center(child: Text(
          StringConstants.profileAppBarTitleText
        )),
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

class _UserImage extends ConsumerWidget {
  const _UserImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userImage = ref.watch(userImageProvider);
    return SizedBox(
      height: 150,
      child: CirculerImage(
        image: userImage,
      ),
    );
  }
}

class _UserBio extends ConsumerWidget {
  const _UserBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String bio = ref.watch(userBioProvider);
    return Container(
      margin: const EdgeInsets.all(25),
      child: Text(
        bio,
        textAlign: TextAlign.justify,
        style: const TextStyle(
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