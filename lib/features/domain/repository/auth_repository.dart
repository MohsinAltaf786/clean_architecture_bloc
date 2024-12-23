import 'package:clean_architecture_practice/core/error/failure.dart';
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';
abstract interface class AuthRepository{

Future <Either<Failure,User>>signupWithEmailPassword({
  required String email,
  required String name,
  required String password,
});

Future <Either<Failure,User>>loginWithEmailPassword({
  required String email,
  required String password,
});



}