import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/core/usecase/usecase.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User,UserSignupParms>{
  final AuthRepository authRepository;
  UserSignup(this.authRepository);
  @override
Future<Either<Failure,User>>call(UserSignupParms parms)async{
   return await authRepository.signupWithEmailPassword(email:parms.email, name:parms.name, password:parms.password);
  }

}
class UserSignupParms{
  final String email;
  final String password;
  final String name;
  UserSignupParms(this.email, this.password, this.name);

}