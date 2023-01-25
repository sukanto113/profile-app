import 'package:flutter/material.dart';

class RightAlignRow extends StatelessWidget {
  final List<Widget> children;
  
  const RightAlignRow({
    Key? key,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class CirculerImage extends StatelessWidget {
  const CirculerImage({
    Key? key,
    this.image
  }) : super(key: key);

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CircleAvatar(
        backgroundImage: image,
      ),
    );
  }
}


class ThreeLayerFloatingCard extends StatelessWidget {
  const ThreeLayerFloatingCard({
    this.background = const Center(),
    this.child, 
    this.stackedChild = const Center(), 
    this.marginBottom = 0,
    Key? key,
  }) : super(key: key);

  final Widget background;
  final Widget? child;
  final Widget stackedChild;

  /// use margin to controll positioning of stackedChild
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        background,
        SingleChildScrollView(
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.fromLTRB(30, 150, 30, marginBottom),
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
                child: stackedChild,
              ),
            ]                
          ),
        ),
      ] 
    );
  }
}
