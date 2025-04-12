part of 'asteroids_bloc.dart';

abstract class AsteroidsState extends Equatable {
  const AsteroidsState();

  @override
  List<Object> get props => [];
}

final class AsteroidsInitial extends AsteroidsState {}

final class AsteroidsLoading extends AsteroidsState {}

final class AsteroidsLoaded extends AsteroidsState {
  final List<Asteroid> asteroids;

  const AsteroidsLoaded({required this.asteroids});

  @override
  List<Object> get props => [asteroids];
}

final class AsteroidsError extends AsteroidsState {
  final String error;

  const AsteroidsError({required this.error});

  @override
  List<Object> get props => [error];
}

final class AsteroidSelected extends AsteroidsState {
  final Asteroid asteroid;

  const AsteroidSelected({required this.asteroid});

  @override
  List<Object> get props => [asteroid];
}

