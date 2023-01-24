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