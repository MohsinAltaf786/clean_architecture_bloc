import 'dart:developer';

import 'package:clean_architecture_practice/core/common/widgets/loader.dart';
import 'package:clean_architecture_practice/core/utils/show_snackbar.dart';
import 'package:clean_architecture_practice/features/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_practice/features/presentation/widgets/auth_text_fields/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthSignUp(_emailController.text.trim(),
          _passController.text.trim(), _nameController.text.trim()));
      // ScaffoldMessenger.of(context).showSnackBar(
      //  const SnackBar(content: Text('Form is valid!')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthFailure) {
              showSnackBar(context: context, content: state.message);
              log('=================> error occured');
            }
            if (state is AuthSuccess) {}
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            } else if (state is AuthSuccess) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                        title: 'Name',
                        nameController: _nameController,
                        validationMessage: 'please enter your name'),
                    const SizedBox(height: 16),
                    AuthTextField(
                        title: 'Email',
                        nameController: _emailController,
                        validationMessage: 'please enter your email'),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthPasswordField(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        isPasswordVisible: _isPasswordVisible,
                        passController: _passController),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: GestureDetector(
                        onTap: () {
                          log('sign in tap');
                          Navigator.pop(context);
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: [
                              TextSpan(
                                text: 'Sign in ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ])),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is AuthInitial || state is AuthFailure) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                        title: 'Name',
                        nameController: _nameController,
                        validationMessage: 'please enter your name'),
                    const SizedBox(height: 16),
                    AuthTextField(
                        title: 'Email',
                        nameController: _emailController,
                        validationMessage: 'please enter your email'),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthPasswordField(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        isPasswordVisible: _isPasswordVisible,
                        passController: _passController),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: GestureDetector(
                        onTap: () {
                          log('sign in tap');
                          Navigator.pop(context);
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: [
                              TextSpan(
                                text: 'Sign in ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ])),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
