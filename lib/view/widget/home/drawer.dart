import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/profile.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/items.dart';
import 'package:profile_app/view/widget/layout.dart';

class HomePageDrawer extends ConsumerWidget {

  final User user;
  final ImageProvider userImage;
  const HomePageDrawer({
    super.key, 
    required this.user,
    required this.userImage,
  });

  void _onNavHomeTab(BuildContext context){
    _closeDrawer(context);
    NavigationUtil.openHomePage(context);
  }

  void _onNavProfileTab(BuildContext context) {
    _closeDrawer(context);
    _openProfilePage(context);
  }

  void _onNavRegisterTab(BuildContext context) {
    _closeDrawer(context);
    _openRegisterPage(context);
  }

  _onNavLogoutTab(BuildContext context, WidgetRef ref) async {
    _closeDrawer(context);
    ref.read(authNotifireProvider.notifier).logout();
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, ProfilePage(user: user,));
  }

  void _openRegisterPage(BuildContext context) {
    NavigationUtil.push(context, RegistrationPage());
  }

  void _closeDrawer(BuildContext context){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          _DrawerHeader(user: user, userImage: userImage),
          DrawerMenuItem(
            name: StringConstants.drawerHomeItemName,
            icon: Icons.home_outlined,
            onTap:() =>  _onNavHomeTab(context),
          ),
          DrawerMenuItem(
            name: StringConstants.drawerProfileItemName,
            icon: Icons.person_outline,
            onTap: () => _onNavProfileTab(context),
          ),
          DrawerMenuItem(
            name: StringConstants.drawerLogoutItemName,
            icon: Icons.logout_outlined,
            onTap: () =>  _onNavLogoutTab(context, ref),
          ),
          const Divider(color: Colors.black,),
          DrawerMenuItem(
            name: StringConstants.drawerRegisterItemName,
            icon: Icons.add_outlined,
            onTap: () => _onNavRegisterTab(context),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final User user;
  final ImageProvider userImage;
  const _DrawerHeader({
    required this.user,
    required this.userImage,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          children:  [
            Expanded(
              child: CirculerImage(
                image: userImage,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Text(
              user.email,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}