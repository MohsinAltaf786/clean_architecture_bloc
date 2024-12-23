
import 'package:clean_architecture_practice/features/domain/entities/user.dart';
import 'package:clean_architecture_practice/features/domain/usecases/user_login.dart';
import 'package:clean_architecture_practice/features/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  AuthBloc({required UserSignup userSignup, required UserLogin userLogin}):_userSignup=userSignup, _userLogin = userLogin,  super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async{
      emit(AuthLoading());
      // TODO: implement event handler
  final response=await _userSignup(UserSignupParms(event.email, event.password, event.name));
  response.fold((failure){
emit(AuthFailure(failure.message));
  },(onSuccess){
emit(AuthSuccess(onSuccess));

  });
    });


    on<AuthLogin>((event, emit) async{
      emit(AuthLoading());
      // TODO: implement event handler
      final response=await _userLogin(UserLoginParms(event.email,event.password));
      response.fold((failure){
        emit(AuthFailure(failure.message));
      },(onSuccess){
        emit(AuthSuccess(onSuccess));

      });
    });

    
  }
}
