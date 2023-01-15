import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({
    Key? key,
    required TextEditingController userNameController,
  }) : _userNameController = userNameController, super(key: key);

  final TextEditingController _userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        return (value == null || value.isEmpty) ? "Please enter your name" : null;
      },
      decoration: const InputDecoration(
        hintText: 'John Doe',
        labelText: 'NAME *',
      ),
    );
  }
}


class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key? key,
    required TextEditingController userPasswordController,
  }) : _userPasswordController = userPasswordController, super(key: key);

  final TextEditingController _userPasswordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userPasswordController,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Password',
        labelText: 'PASSWORD *',
      ),
      validator: (String? value) {
        return (value == null || value.isEmpty) ? "Please enter password" : null;
      },
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required TextEditingController userEmailController,
  }) : _userEmailController = userEmailController, super(key: key);

  final TextEditingController _userEmailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userEmailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'user@example.com',
        labelText: 'EMAIL *',
      ),
      validator: (String? value) {
        return (value == null || !EmailValidator.validate(value)) ? "Please enter a valid email" : null;
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

