import 'package:flutter/material.dart';
import 'package:profile_app/values/strings.dart';

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

class GreyTextButton extends SimpleTextButton {
  const GreyTextButton({
    super.key,
    required super.onPressed,
    required super.text
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey
        ),
      )
    );
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
  String getButtonText() => StringConstants.simpleCancleButtonText;
}

class SimpleSaveButton extends FixedTextButton{
  const SimpleSaveButton({super.key, required super.onPressed});

  @override
  String getButtonText() => StringConstants.simpleSaveButtonText;
}

class SimpleDeleteButton extends FixedTextButton{
  const SimpleDeleteButton({super.key, required super.onPressed});

  @override
  String getButtonText() =>StringConstants.simpleDeleteButtonText;
}

class CancleButtonWithNavigatorPop extends StatelessWidget{
  const CancleButtonWithNavigatorPop({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCancleButton(onPressed: ()=>Navigator.pop(context));
  }
}

class ElevatedTextButton extends SimpleButton {
  const ElevatedTextButton({super.key, super.onPressed, required this.text});
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

}

class GoBackElevatedButton extends SimpleButton{
  const GoBackElevatedButton({super.key, super.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.arrow_back),
          Text(StringConstants.goBackButtonText),
        ],
      )
    );
  }

}