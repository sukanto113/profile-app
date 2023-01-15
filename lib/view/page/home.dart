import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/util/navigation.dart';
import '/view/page/profile.dart';
import '/view/page/login.dart';
import '/view/page/registration.dart';

class HomePage extends StatefulWidget{
  const HomePage({required this.user, super.key});

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _onViewProfileTab() {
    _openProfilePage();
  }

  void _onNavHomeTab(){
    _closeDrawer();
    NavigationUtil.openHomePage(widget.user, context);
  }

  void _onNavProfileTab() {
    _closeDrawer();
    _openProfilePage();
  }

  void _onNavRegisterTab() {
    _closeDrawer();
    _openRegisterPage();
  }

  Future<void> _onNavLogoutTab() async {
    _closeDrawer();

    await UserManager.logout();
    if(!mounted) return;

    _openLogoutPage();

  }

  void _openProfilePage(){
    NavigationUtil.push(context, ProfilePage(user: widget.user));
  }

  void _openLogoutPage() {
    NavigationUtil.pushAndRemoveAllPreviousRoute(context, const LoginPage());
  }

  void _openRegisterPage() {
    NavigationUtil.push(context, const RegistrationPage());
  }

  void _closeDrawer(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children:  [
                    const Expanded(
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/sukanto_profile_pic.jpg")
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      widget.user.email,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            MenuItem(
              name: "Home",
              icon: Icons.home_outlined,
              onTap: _onNavHomeTab,
            ),
            MenuItem(
              name: "Profile",
              icon: Icons.person_outline,
              onTap: _onNavProfileTab,
            ),
            MenuItem(
              name: "Logout",
              icon: Icons.logout_outlined,
              onTap: _onNavLogoutTab,
            ),
            const Divider(color: Colors.black,),
            MenuItem(
              name: "Register",
              icon: Icons.add_outlined,
              onTap: _onNavRegisterTab,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "WELCOME TO HOME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _onViewProfileTab,
                child: const Text("View Profile"),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class MenuItem extends StatelessWidget{
  const MenuItem({required this.name, required this.icon, required this.onTap, super.key});
  final String name;
  final IconData icon;
  final VoidCallback onTap; 
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 17
        ),
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}