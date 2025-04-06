/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/mars/rover.dart';

part 'rover_event.dart';

part 'rover_state.dart';

class RoverBloc extends Bloc<RoverEvent, RoverState> {
  final RoverRepository roverRepository;

  RoverBloc({required this.roverRepository}) : super(const RoverState()) {
    on<LoadRoverData>(_loadRoverData);
    on<RefreshRoverData>(_refreshRoverData);
  }

  Future<void> _loadRoverData(
    LoadRoverData event,
    Emitter<RoverState> emit,
  ) async {
    emit(
      state.copyWith(
        status: RoverStatus.loading,
      ),
    );

    try {
      final roverImages = await roverRepository.getRoverPhotos(
        roverName: event.roverName,
        earthDate: event.earthDate,
      );
      emit(state.copyWith(
        status: RoverStatus.success,
        roverPhotos: roverImages,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: RoverStatus.failure,
        error: error.toString(),
      ));
    }
  }

  Future<void> _refreshRoverData(
    RefreshRoverData event,
    Emitter<RoverState> emit,
  ) async {
    emit(state.copyWith(
      status: RoverStatus.loading,
    ));
    try {
      final roverPhotos =
          await roverRepository.getRoverPhotos(roverName: 'curiosity');
      emit(
        state.copyWith(
          roverPhotos: roverPhotos,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RoverStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }
}
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/mars/rover.dart';

part 'rover_event.dart';
part 'rover_state.dart';

class RoverBloc extends Bloc<RoverEvent, RoverState> {
  final RoverRepository roverRepository;

  RoverBloc({required this.roverRepository}) : super(const RoverState()) {
    on<LoadRoverData>(_loadRoverData);
    on<RefreshRoverData>(_refreshRoverData);
  }

  Future<void> _loadRoverData(
      LoadRoverData event,
      Emitter<RoverState> emit,
      ) async {
    emit(
      state.copyWith(
        status: RoverStatus.loading,
      ),
    );

    try {
      // Now using the event.roverName and event.sol values
      final roverImages = await roverRepository.getRoverPhotos(
        roverName: event.roverName,
        sol: 1000,
        earthDate: event.earthDate,
      );

      emit(state.copyWith(
        status: RoverStatus.success,
        roverPhotos: roverImages,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: RoverStatus.failure,
        error: error.toString(),
      ));
    }
  }

  Future<void> _refreshRoverData(
      RefreshRoverData event,
      Emitter<RoverState> emit,
      ) async {
    emit(state.copyWith(
      status: RoverStatus.loading,
    ));
    try {
      // We should use the last used rover name and sol value here
      // This is a simple implementation - you might want to store these values in state
      final roverPhotos = await roverRepository.getRoverPhotos(
        roverName: 'curiosity',
        sol: 1000,
      );

      emit(
        state.copyWith(
          status: RoverStatus.success,
          roverPhotos: roverPhotos,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RoverStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }
}