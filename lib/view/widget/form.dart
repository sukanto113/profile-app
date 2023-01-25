import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:profile_app/values/strings.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({
    Key? key,
    required TextEditingController controller,
  }) : _userNameController = controller, super(key: key);

  final TextEditingController _userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        return (value == null || value.isEmpty)
          ? StringConstants.registerUserFormNameValidationText
          : null;
      },
      decoration: const InputDecoration(
        hintText: StringConstants.registerUserFormNameHint,
        labelText: StringConstants.registerUserFormNameLabel,
      ),
    );
  }
}


class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key? key,
    required TextEditingController controller,
  }) : _userPasswordController = controller, super(key: key);

  final TextEditingController _userPasswordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userPasswordController,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: StringConstants.registerUserFormPasswordHint,
        labelText: StringConstants.registerUserFormPasswordLabel,
      ),
      validator: (String? value) {
        return (value == null || value.isEmpty)
          ? StringConstants.registerUserFormPasswordValidationText
          : null;
      },
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required TextEditingController controller,
  }) : _userEmailController = controller, super(key: key);

  final TextEditingController _userEmailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userEmailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: StringConstants.registerUserFormEmailHint,
        labelText: StringConstants.registerUserFormEmailLabel,
      ),
      validator: (String? value) {
        return (value == null || !EmailValidator.validate(value)) 
          ? StringConstants.registerUserFormEmailValidationText
          : null;
      },
    );
  }
}


class ElevatedFormActionButton extends StatelessWidget {

  const ElevatedFormActionButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}


class FormHeaderText extends StatelessWidget {
  const FormHeaderText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
      ),
    );
  }
}


class SimpleTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const SimpleTextFormField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}