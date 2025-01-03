import 'package:clean_architecture_practice/features/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_practice/features/data/repositories/auth_repository_imp.dart';
import 'package:clean_architecture_practice/features/domain/usecases/user_signup.dart';
import 'package:clean_architecture_practice/features/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_practice/features/presentation/pages/login_page.dart';
import 'package:clean_architecture_practice/init_dependency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers:[
    BlocProvider(create: (_)=>serviceLocater<AuthBloc>())
  ],
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const LoginPage(),
    );
  }
}


