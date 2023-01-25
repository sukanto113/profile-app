
import 'package:flutter/material.dart';

class BackgroundWithHomeIcon extends StatelessWidget {
  const BackgroundWithHomeIcon({
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