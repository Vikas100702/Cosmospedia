part of 'rover_manifest_bloc.dart';

enum RoverManifestStatus { initial, loading, success, failure }

class RoverManifestState extends Equatable {
  final RoverManifestStatus status;
  final RoverManifestModel? roverManifestModel;
  final String? error;
  final String roverName;

  const RoverManifestState({
    this.status = RoverManifestStatus.initial,
    this.roverManifestModel,
    this.error,
    this.roverName = '',
  });

  RoverManifestState copyWith({
    RoverManifestStatus? status,
    RoverManifestModel? roverManifestModel,
    String? error,
    String? roverName,
  }) {
    return RoverManifestState(
      status: status ?? this.status,
      roverManifestModel: roverManifestModel ?? this.roverManifestModel,
      error: error ?? this.error,
      roverName: roverName ?? this.roverName,
    );
  }

  @override
  List<Object?> get props => [status, roverManifestModel, error, roverName];
}
