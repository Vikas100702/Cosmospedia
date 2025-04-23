import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateName>(_updateName);
    on<UpdatePassword>(_updatePassword);
  }

  Future<void> _loadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        emit(ProfileLoaded(
          name: user.displayName ?? 'Cosmos Explorer',
          email: user.email ?? 'user@cosmospedia.com',
        ));
      } else {
        emit(ProfileError('User not found.'));
      }
    } catch (error) {
      emit(ProfileError('Failed to load profile.\n${error.toString()}'));
    }
  }

  Future<void> _updateName(UpdateName event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) return;

    emit(ProfileUpdating());
    try {
      await _auth.currentUser?.updateDisplayName(event.newName);
      emit(ProfileLoaded(
        name: event.newName,
        email: (state as ProfileLoaded).email,
      ));
    } catch (error) {
      emit(ProfileError(error.toString()));
      await Future.delayed(const Duration(seconds: 1));
      emit(ProfileLoaded(
        name: (state as ProfileLoaded).name,
        email: (state as ProfileLoaded).email,
      ));
    }
  }

  Future<void> _updatePassword(
      UpdatePassword event, Emitter<ProfileState> emit) async {
    if (state is! ProfileLoaded) return;

    emit(ProfileUpdating());
    try {
      await _auth.currentUser?.updatePassword(event.newPassword);
      emit(ProfileLoaded(
        name: (state as ProfileLoaded).name,
        email: (state as ProfileLoaded).email,
      ));
    } catch (error) {
      emit(ProfileError(error.toString()));
      await Future.delayed(const Duration(seconds: 1));
      emit(ProfileLoaded(
        name: (state as ProfileLoaded).name,
        email: (state as ProfileLoaded).email,
      ));
    }
  }
}
