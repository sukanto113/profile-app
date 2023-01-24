import 'package:flutter/material.dart';

class SimpleTextButton extends StatelessWidget {
  const SimpleTextButton({
    super.key, required
    this.onPressed,
    required this.text
  });
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}

abstract class FixedTextButton extends StatelessWidget{
  const FixedTextButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  String getButtonText();

  @override
  Widget build(BuildContext context) {
    return SimpleTextButton(onPressed: onPressed, text: getButtonText());
  }
}

class SimpleCancleButton extends FixedTextButton{
  const SimpleCancleButton({super.key, required super.onPressed});
  @override
  String getButtonText() => "Cancle";
}

class SimpleSaveButton extends FixedTextButton{
  const SimpleSaveButton({super.key, required super.onPressed});

  @override
  String getButtonText() => "Save";
}

class SimpleDeleteButton extends FixedTextButton{
  const SimpleDeleteButton({super.key, required super.onPressed});

  @override
  String getButtonText() => "Delete";
}

class DialogCancleButton extends StatelessWidget{
  const DialogCancleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCancleButton(onPressed: ()=>Navigator.pop(context));
  }
}