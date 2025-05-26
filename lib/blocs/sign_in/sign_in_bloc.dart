import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInBloc() : super(SignInInitial()) {
    on<SignInWithEmailPassword>(
      (event, emit) async {
        emit(SignInLoading());
        try {
          await _auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(SignInSuccess());
        } on FirebaseAuthException catch (e) {
          String errorMessage;
          switch (e.code) {
            case 'Invalid-email':
              errorMessage = 'The email address is badly formatted.';
              break;
            case 'user-disabled':
              errorMessage =
                  'The user corresponding to the given email has been disabled.';
              break;
            case 'user-not-found':
              errorMessage =
                  'No user found with this email. Please sign up first.';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            default:
              errorMessage = 'Authentication failed. Please try again.';
          }
          emit(SignInFailure(errorMessage));
        } catch (e) {
          emit(SignInFailure('An unexpected error occurred. Please try again.'));
        }
      },
    );
  }
}
