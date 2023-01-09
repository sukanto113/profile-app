import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '/view/floating_card_form_screen.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingCardFormScreen(
        background: const BackgroundWithHomeIcon(),
        margin: const EdgeInsets.fromLTRB(30, 150, 30, 80),
        stackedChild: [
          Positioned(
            bottom: 60,
            left: 60,
            right: 60,
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
              child: const Text(
                "REGISTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ),
            
          Positioned(
            bottom: 0,
            left: 60,
            right: 60,
            child: TextButton(
              onPressed: (){},
              child: const Text("Already a User? LOGIN"),
            )
          ),
        ],
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text(
                "REGISTER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                hintText: 'John Doe',
                labelText: 'NAME *',
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                hintText: 'user@example.com',
                labelText: 'EMAIL *',
              ),
              validator: (String? value) {
                if( value == ""){
                  return null;
                }else{
                  return (value !=null && EmailValidator.validate(value)) ? null : "Please enter a valid email";
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'PASSWORD *',
                ),
              ),
            ),
          ],
        ), 
      ),
    );
  }
}