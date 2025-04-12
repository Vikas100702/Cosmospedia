part of 'asteroids_bloc.dart';

abstract class AsteroidsEvent extends Equatable {
  const AsteroidsEvent();

  @override
  List<Object> get props => [];
}

class LoadAsteroids extends AsteroidsEvent {}

class SelectAsteroid extends AsteroidsEvent {
  final Asteroid asteroid;

  const SelectAsteroid(this.asteroid);

  @override
  List<Object> get props => [asteroid];
}
