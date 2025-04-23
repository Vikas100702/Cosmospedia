part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class SignUpWithEmailPassword extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpWithEmailPassword(
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      );
}