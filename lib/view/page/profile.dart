import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user = const User(name: "", email: "");

  void _onGoBackPressed(){
    Navigator.pop(context);
  }

    @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      User user = await UserManager.getCurrentUser();
      setState(() {
        _user = user; 
      });

    });
    super.initState();
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
            Container(
              height: 150,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: const FittedBox(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/sukanto_profile_pic.jpg")
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                _user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: const Text(
                "Hi, I'm Sukanto saha, I'm M.Sc. student of Rajshahi "
                "University. I completed my graduation in "
                "Mathematics from Rajshahi University.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onGoBackPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back),
                  Text("Go Back"),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}