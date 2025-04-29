import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
  }

  Future<void> _onStartSplash(
      StartSplash event,
      Emitter<SplashState> emit,
      ) async {
    emit(SplashInProgress());

// Add a delay to show the splash screen
    await Future.delayed(const Duration(seconds: 3));

// Check authentication status
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    emit(SplashComplete(isAuthenticated));
  }
}