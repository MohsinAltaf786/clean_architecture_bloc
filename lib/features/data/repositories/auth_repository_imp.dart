import 'package:clean_architecture_practice/core/error/exception.dart';
import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/features/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fpdart/fpdart.dart';
class AuthRepositoryImp implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);

  @override
  Future <Either<Failure,User>>signupWithEmailPassword ({
    required String email,
    required String name,
    required String password,
  })async{
    return  _getUser(()async=> await authRemoteDataSource.signupWithEmailPassword(email: email, name: name, password: password));
  }
  @override

  Future <Either<Failure,User>>loginWithEmailPassword({
    required String email,
    required String password,
  })async{  return  _getUser(()async=> await authRemoteDataSource.loginWithEmailPassword(email: email, password: password));}

  @override
  Future <Either<Failure,User>>getCurrentUser()async{  return  _getUser(()async=> await authRemoteDataSource.getCurrentUser());}

  Future <Either<Failure,User>>_getUser(Future<User>Function()fn)async{
    try{
      final user=await fn();
      return right(user);
    }on auth.FirebaseAuthException catch (e){
      return left(Failure(e.toString()));
    }  on ServerException catch (e){
      return left(Failure(e.message));
    }catch (e){return left(Failure(e.toString()));}
  }

}