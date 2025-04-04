part of 'rover_manifest_bloc.dart';

abstract class RoverManifestEvent extends Equatable {
  const RoverManifestEvent();

  @override
  List<Object> get props => [];
}

class LoadRoverManifest extends RoverManifestEvent {
  final String roverName;

  const LoadRoverManifest({required this.roverName});

  @override
  List<Object> get props => [roverName];
}
