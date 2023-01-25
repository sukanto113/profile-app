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
