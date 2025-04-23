part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;

  ProfileLoaded({required this.name, required this.email});
}

class ProfileUpdating extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);
}
