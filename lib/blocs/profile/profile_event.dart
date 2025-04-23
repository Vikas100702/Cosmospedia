part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateName extends ProfileEvent {
  final String newName;

  UpdateName(this.newName);
}

class UpdatePassword extends ProfileEvent {
  final String newPassword;

  UpdatePassword(this.newPassword);
}
