import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashInProgress extends SplashState {}

class SplashComplete extends SplashState {
  final bool isAuthenticated;

  const SplashComplete(this.isAuthenticated);

  @override
  List<Object> get props => [isAuthenticated];
}