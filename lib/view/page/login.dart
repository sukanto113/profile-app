import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: Column(
                children: [
                  Expanded(
                    child: Container(     
                      alignment: Alignment.topCenter,                 
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
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 50),
                        child: const FittedBox(
                          child: CircleAvatar(                            
                            backgroundColor: Colors.white,
                            child: Icon(Icons.home),
                          ),
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    )
                  )
                ]
              ),
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.fromLTRB(30, 150, 30, 80),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: const Text(
                              "LOGIN",
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
                              hintText: 'Your Name',
                              labelText: 'NAME *',
                            ),
                            validator: (String? value) {
                              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
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
                  ),
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
                        "LOGIN",
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
                      child: const Text("Forgot password?"),
                    )
                  ),
                ],                
              ),
            ),
          ] 
        ),
      ),
    );
  }
}