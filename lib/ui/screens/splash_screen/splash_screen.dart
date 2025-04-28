import 'package:cosmospedia/blocs/splash/splash_bloc.dart';
import 'package:cosmospedia/blocs/splash/splash_state.dart';
import 'package:cosmospedia/ui/screens/home_screen/home_screen.dart';
import 'package:cosmospedia/ui/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/splash/splash_event.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      SplashBloc()
        ..add(StartSplash()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashComplete) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                state.isAuthenticated
                    ? const HomeScreen()
                    : const SignInScreen(),
              ),
            );
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6A11CB),
                  Color(0xFF2575FC),
                ],
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/splashScreen.gif',
                fit: BoxFit.fill,
                // height: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
