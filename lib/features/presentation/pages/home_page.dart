import 'package:clean_architecture_practice/features/data/model/user_model.dart';
import 'package:clean_architecture_practice/features/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatelessWidget {
    HomePage({super.key});

   UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthCurrentUser());
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
   if(state is AuthSuccess){
     return Container(height: MediaQuery.of(context).size.height,
         child: Center(child:Text(state.user.email),));
   }
   return SizedBox();
  },
),
    );
  }
}
