import 'package:flutter/material.dart';

abstract class SimpleButton extends StatelessWidget{
  const SimpleButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context);
}

class SimpleTextButton extends SimpleButton{
  final String text;
  
  const SimpleTextButton({
    super.key,
    required super.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}

abstract class FixedTextButton extends SimpleButton{

  const FixedTextButton({super.key, super.onPressed});

  String getButtonText();

  @override
  Widget build(BuildContext context) {
    return SimpleTextButton(onPressed: onPressed, text: getButtonText());
  }
}

abstract class FixedIconButton extends SimpleButton{
  const FixedIconButton({super.key, required super.onPressed});
  
  Icon getButtonIcon();

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: getButtonIcon());
  }
} 

class DeleteIconButton extends FixedIconButton{
  const DeleteIconButton({super.key, required super.onPressed});

  @override
  Icon getButtonIcon() => const Icon(Icons.delete);
}

class EditIconButton extends FixedIconButton{
  const EditIconButton({super.key, required super.onPressed});

  @override
  Icon getButtonIcon() => const Icon(Icons.edit);
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