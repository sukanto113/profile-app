import 'package:flutter/material.dart';
import 'package:profile_app/values/strings.dart';

class TryAgainErrorWidget extends StatelessWidget {
  const TryAgainErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringConstants.errorTryLater),
    );
  }
}