part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthSignUp extends AuthEvent{
  final String email;
  final String password;
  final String name;
  AuthSignUp(this.email, this.password, this.name);

}
final class AuthLogin extends AuthEvent{
  final String email;
  final String password;

  AuthLogin(this.email, this.password);
}
final class AuthCurrentUser extends AuthEvent{
  AuthCurrentUser();
}