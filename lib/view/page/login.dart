import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login"),
      // ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children:  [
            _PageBackground(),
            SingleChildScrollView(
              child: _CardStyleForm(
                // inputes
                // buttons
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
                // stackedChild: Column,
              ),
            ),
          ] 
        ),
      ),
    );
  }
}

class _CardStyleForm extends StatelessWidget {
   const _CardStyleForm({
    this.child, 
    this.stackedChild, 
    // this.n,
    Key? key,
  }) : super(key: key);

  // final int? n;
  final Widget? child;
  final Widget? stackedChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(30, 150, 30, 80),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: child,
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
    );
  }
}

class _PageBackground extends StatelessWidget {
  const _PageBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}