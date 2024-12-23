import 'dart:developer';

import 'package:clean_architecture_practice/core/common/widgets/loader.dart';
import 'package:clean_architecture_practice/features/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_practice/features/presentation/pages/signup_page.dart';
import 'package:clean_architecture_practice/features/presentation/widgets/auth_text_fields/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<AuthBloc>().add(AuthLogin(_emailController.text.trim(),
          _passController.text.trim(),));
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
        child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
   if(state is AuthSuccess){
     log('========> successfully loged');
   }
  },
  builder: (context, state) {
    if(state is AuthSuccess || state is AuthLoading){
      return Form(
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
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),const SizedBox(width: 5,),
                        state is AuthLoading? SizedBox(
                            height:7,
                            width: 7,
                            child: const Loader()):const SizedBox()
                      ],),
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
      );
    }
    else if(state is AuthInitial|| state is AuthFailure){
      return  Form(
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
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),const SizedBox(width: 5,),
                        state is AuthLoading? SizedBox(
                            height:7,
                            width: 7,
                            child: const Loader()):const SizedBox()
                      ],),
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
      );
    }
    else {return SizedBox();}
  },
),
      ),
    );
  }
}
