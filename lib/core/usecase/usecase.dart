import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType,Parms>{
  Future<Either<Failure,SuccessType>> call(Parms parms);
}
abstract interface class GetUserUseCase<SuccessType>{
  Future<Either<Failure,SuccessType>> call();
}