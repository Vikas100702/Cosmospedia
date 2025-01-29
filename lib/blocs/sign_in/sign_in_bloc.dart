import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SignInBloc() : super(SignInInitial()) {
    on<SignInWithEmailPassword>((event, emit) async {
      emit(SignInLoading());
      try {
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(SigInInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(e.message ?? 'Authentication failed'));
      }
    });
  }
}
