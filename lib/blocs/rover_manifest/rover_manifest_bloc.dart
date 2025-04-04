import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/mars/rover_manifest.dart';
import '../../data/repositories/mars/rover_manifest_repository.dart';

part 'rover_manifest_event.dart';

part 'rover_manifest_state.dart';

class RoverManifestBloc extends Bloc<RoverManifestEvent, RoverManifestState> {
  final RoverManifestRepository roverManifestRepository;

  RoverManifestBloc({required this.roverManifestRepository})
      : super(const RoverManifestState(roverName: '')) {
    on<LoadRoverManifest>(_onLoadRoverManifest);
  }

  Future<void> _onLoadRoverManifest(LoadRoverManifest event,
      Emitter<RoverManifestState> emit) async {
    emit(state.copyWith(
      status: RoverManifestStatus.loading, roverName: event.roverName,),);

    try {
      final roverManifest = await roverManifestRepository.getRoverManifest(
          event.roverName);
      emit(state.copyWith(
        status: RoverManifestStatus.success,
        roverManifestModel: roverManifest,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: RoverManifestStatus.failure,
        error: error.toString(),
      ));
    }
  }
}
