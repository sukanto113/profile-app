import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.user, super.key});

  final User user;

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
                user.name,
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
              onPressed: (){
                Navigator.pop(context);
              },
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