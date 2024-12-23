import 'dart:developer';

import 'package:clean_architecture_practice/features/presentation/pages/signup_page.dart';
import 'package:clean_architecture_practice/features/presentation/widgets/auth_text_fields/auth_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform the desired action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is valid!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              AuthTextField(title: 'Email',
                  nameController: _emailController,
                  validationMessage: 'please enter your email'),
              const SizedBox(height: 16,),
              AuthPasswordField(onPressed:() {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
                  isPasswordVisible: _isPasswordVisible,
                  passController: _passController),
              const SizedBox(height: 16),
              Row(
                  children:[ Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Sign in',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                    ),
                  ),
                  ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                child: GestureDetector(
                  onTap: (){
                    log('sign in tap');
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>SignupPage()));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'Dont have an account? ',
                          style: TextStyle(
                            fontSize:14.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
