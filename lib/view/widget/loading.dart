import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:const [
        Opacity(
          opacity: 1,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}