part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SigInInSuccess extends SignInState {}

class SignInFailure extends SignInState{
  final String error;

  SignInFailure(this.error);
}
