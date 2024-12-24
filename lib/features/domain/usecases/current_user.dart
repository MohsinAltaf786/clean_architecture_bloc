import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/core/usecase/usecase.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements GetUserUseCase<User>{
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure,User>>call()async{
    return await authRepository.getCurrentUser();
  }

}