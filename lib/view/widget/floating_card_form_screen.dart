import 'package:flutter/material.dart';

class FloatingCardFormScreen extends StatelessWidget {
  const FloatingCardFormScreen({
    this.background,
    this.child, 
    this.stackedChild, 
    this.margin,
    Key? key,
  }) : super(key: key);

  final Widget? background;
  final Widget? child;
  final Widget? stackedChild;

  /// use margin to controll positioning of stackedChild
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    Widget currentBackground = Container();
    if(background != null){
      currentBackground = background!;
    } 

    return Stack(
      alignment: Alignment.center,
      children: [
        currentBackground,
        SingleChildScrollView(
          child: _CardStyleForm(
            margin: margin,
            stackedChild: stackedChild,
            child: child,
          ),
        ),
      ] 
    );
  }
}

class _CardStyleForm extends StatelessWidget {
    const _CardStyleForm({
    this.child, 
    this.stackedChild, 
    this.margin,
    Key? key,
  }) : super(key: key);

  final Widget? child;
  final Widget? stackedChild;

  /// use margin to controll positioning of stackedChild
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: margin,
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
          bottom: 0,
          left: 60,
          right: 60,
          child: stackedChild ?? Container(),
        ),
      ]                
    );
  }
}

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