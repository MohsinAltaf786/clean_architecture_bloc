
import 'package:clean_architecture_practice/features/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_practice/features/data/repositories/auth_repository_imp.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:clean_architecture_practice/features/domain/usecases/user_login.dart';
import 'package:clean_architecture_practice/features/domain/usecases/user_signup.dart';
import 'package:clean_architecture_practice/features/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
///for dependency Injection
final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  _initAut();
 await  Firebase.initializeApp();
  serviceLocater.registerLazySingleton(()=>FirebaseAuth.instance);
}
void _initAut(){
  /// for dependency injection
serviceLocater.registerFactory<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImp(serviceLocater()));
serviceLocater.registerFactory<AuthRepository>(()=>AuthRepositoryImp(serviceLocater()));
serviceLocater.registerFactory(()=>UserSignup(serviceLocater()));
serviceLocater.registerFactory(()=>UserLogin(serviceLocater()));
serviceLocater.registerLazySingleton(()=>AuthBloc(userSignup: serviceLocater(), userLogin: serviceLocater()));
}