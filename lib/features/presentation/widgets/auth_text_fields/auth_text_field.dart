import 'package:flutter/material.dart';
class AuthTextField extends StatelessWidget {
  const AuthTextField({super.key,required this.title,required this.nameController,required this.validationMessage});
  final TextEditingController nameController;
  final String title;
  final String validationMessage;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({super.key,required this.onPressed,required this.isPasswordVisible,required this.passController});
   final TextEditingController passController;
   final  Function()onPressed;
   final bool isPasswordVisible;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed:onPressed,
        ),
      ),
      obscureText: !isPasswordVisible, // Hides password input by default
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
    );
  }
}
