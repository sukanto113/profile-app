import 'package:flutter/material.dart';
import '/view/page/profile.dart';
import '/view/page/login.dart';
import '/view/page/registration.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  void openOnDrawerItemTap(BuildContext context, Widget page){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> page)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            SizedBox(
              height: 230,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/sukanto_profile_pic.jpg")
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Sukanto Saha",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MenuItem(
              name: "Home",
              icon: Icons.home_outlined,
              onTap: (){
              }
            ),
            MenuItem(
              name: "Profile",
              icon: Icons.person_outline,
              onTap: (){
                openOnDrawerItemTap(context, const ProfilePage());
              }
            ),
            MenuItem(
              name: "Logout",
              icon: Icons.logout_outlined,
              onTap: (){
                openOnDrawerItemTap(context, const LoginPage());
              }
            ),
            const Divider(color: Colors.black,),
            MenuItem(
              name: "Register",
              icon: Icons.add_outlined,
              onTap: (){
                openOnDrawerItemTap(context, const RegistrationPage());
              }
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Welcome to home"),
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