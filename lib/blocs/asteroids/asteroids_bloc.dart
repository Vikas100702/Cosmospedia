import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/asteroids/asteroids_model.dart';
import '../../data/repositories/asteroids/asteroids_repository.dart';

part 'asteroids_event.dart';
part 'asteroids_state.dart';

class AsteroidsBloc extends Bloc<AsteroidsEvent, AsteroidsState> {
  final AsteroidsRepository asteroidsRepository;
  List<Asteroid>? cachedAsteroids; // Add cache for asteroids
  AsteroidsBloc({required this.asteroidsRepository}) : super(AsteroidsInitial()) {
    on<LoadAsteroids>(_onLoadAsteroids);
    on<SelectAsteroid>((event, emit) {
      emit(AsteroidSelected(asteroid: event.asteroid));
    });
  }

  Future<void> _onLoadAsteroids(LoadAsteroids event, Emitter<AsteroidsState> emit) async {

    // Return cached data if available
    if (cachedAsteroids != null) {
      emit(AsteroidsLoaded(asteroids: cachedAsteroids!));
      return;
    }

    emit(AsteroidsLoading());

    try {
      final asteroids = await asteroidsRepository.getAsteroids();
      cachedAsteroids = asteroids; // Cache the asteroids
      emit(AsteroidsLoaded(asteroids: asteroids));
    } catch (error) {
      emit(AsteroidsError(error: error.toString()));
    }
  }
}
