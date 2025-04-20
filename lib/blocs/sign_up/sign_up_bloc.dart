import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpWithEmailPassword>(
      (event, emit) async {
        emit(SignUpLoading());
        try {
          if (event.password != event.confirmPassword) {
            emit(SignUpFailure('Passwords do not match'));
            return;
          }
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          // Optionally send email verification
          await FirebaseAuth.instance.currentUser?.sendEmailVerification();

          emit(SignUpSuccess());
        } on FirebaseAuthException catch (e) {
          String errorMessage;
          switch (e.code) {
            case 'email-already-in-use':
              errorMessage =
                  'An account already exists for this email. Please sign in instead.';
              break;
            case 'invalid-email':
              errorMessage = 'The email address is badly formatted.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Email/password accounts are not enabled.';
              break;
            case 'weak-password':
              errorMessage =
                  'The password is too weak. Please choose a stronger password.';
              break;
            default:
              errorMessage = 'Registration failed. Please try again.';
          }
          emit(SignUpFailure(errorMessage));
        } catch (e) {
          emit(
              SignUpFailure('An unexpected error occurred. Please try again.'));
        }
      },
    );
  }
}
