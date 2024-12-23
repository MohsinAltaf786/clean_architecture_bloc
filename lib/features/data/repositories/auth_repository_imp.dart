import 'package:clean_architecture_practice/core/error/exception.dart';
import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/features/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
class AuthRepositoryImp implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);

  Future <Either<Failure,User>>signupWithEmailPassword ({
    required String email,
    required String name,
    required String password,
  })async{
    try{
      final user=await authRemoteDataSource.signupWithEmailPassword(email: email, name: name, password: password);
      return right(user);
    }on ServerException catch (e){
      return left(Failure(e.message));
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  Future <Either<Failure,User>>loginWithEmailPassword({
    required String email,
    required String password,
  })async{
    try{
      final user=await authRemoteDataSource.loginWithEmailPassword(email: email, password: password);
      return right(user);
    }on ServerException catch (e){
      return left(Failure(e.message));
    }
  }

}