part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInWithEmailPassword extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailPassword(this.email, this.password);
}
