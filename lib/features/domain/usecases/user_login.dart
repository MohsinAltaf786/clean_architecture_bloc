import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/core/usecase/usecase.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User,UserLoginParms>{
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure,User>>call(UserLoginParms parms)async{
    return await authRepository.loginWithEmailPassword(email:parms.email, password:parms.password);
  }

}
class UserLoginParms{
  final String email;
  final String password;

  UserLoginParms(this.email, this.password,);

}