part of 'rover_bloc.dart';

enum RoverStatus { initial, loading, success, failure }

class RoverState extends Equatable {
  final RoverStatus status;
  final List<RoverModel> roverPhotos;
  final String? error;
  final int? maxSol;

  const RoverState({
    this.status = RoverStatus.initial,
    this.roverPhotos = const [],
    this.error,
    this.maxSol,
  });

  RoverState copyWith({
    RoverStatus? status,
    List<RoverModel>? roverPhotos,
    String? error,
    int? maxSol,
  }) {
    return RoverState(
      status: status ?? this.status,
      roverPhotos: roverPhotos ?? this.roverPhotos,
      error: error ?? this.error,
      maxSol: maxSol ?? this.maxSol,
    );
  }

  @override
  List<Object?> get props => [status, roverPhotos, error, maxSol];
}
