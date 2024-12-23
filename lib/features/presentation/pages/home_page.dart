import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: MediaQuery.of(context).size.height,
          child: Center(child:const Text('Welcome Home Page'),)),
    );
  }
}
