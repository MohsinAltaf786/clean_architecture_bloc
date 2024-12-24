import 'dart:developer';

import 'package:clean_architecture_practice/core/error/exception.dart';
import 'package:clean_architecture_practice/features/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource{
  Future<UserModel> signupWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });

  Future <UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel>getCurrentUser();

}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource{
  FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImp(this.firebaseAuth);
  @override
  Future<UserModel>loginWithEmailPassword({
    required String email,
    required String password,
})async{
    UserCredential userCredential;
    try{
     userCredential=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     if(userCredential.user!=null){
       final UserModel userModel= UserModel(email: userCredential.user!.email??'', id:  userCredential.user!.uid,name: 'unknown');
       return userModel;
     }
     else{ throw Exception('user is null');}
    }on ServerException catch(e){
      log('an error occured ${e.message}');
    }
    throw UnimplementedError();
  }


  @override
  Future<UserModel>signupWithEmailPassword({
    required String email,
    required String name,
    required String password,
  })async{
    UserCredential userCredential;
    try{
      userCredential=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,
      );
      if(userCredential.user!=null){
        final UserModel userModel= UserModel(email: userCredential.user!.email??'', id:  userCredential.user!.uid,name: 'unknown');
        return userModel;
      }
      else{
        throw Exception('user is null');}
    }on ServerException catch(e){
      log('an error occured ${e.message}');
    }
    throw UnimplementedError();
  }
  @override
  Future<UserModel>getCurrentUser() async{
try{
  if(firebaseAuth.currentUser!=null){
    UserModel userModel=UserModel(email:firebaseAuth.currentUser?.email??'', id:firebaseAuth.currentUser?.uid??'', name: firebaseAuth.currentUser?.displayName??'');
    return userModel;
  }
}on ServerException catch(e){
  log('an error occured ${e.message}');
} on FirebaseAuthException catch(e){
  log('an error occured ${e.message}');
}

 throw UnimplementedError();
  }


}