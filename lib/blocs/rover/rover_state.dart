part of 'rover_bloc.dart';

enum RoverStatus { initial, loading, success, failure }

class RoverState extends Equatable {
  final RoverStatus status;
  final List<RoverModel> roverPhotos;
  final String? error;

  const RoverState({
    this.status = RoverStatus.initial,
    this.roverPhotos = const [],
    this.error,
  });

  RoverState copyWith({
    RoverStatus? status,
    List<RoverModel>? roverPhotos,
    String? error,
  }) {
    return RoverState(
      status: status ?? this.status,
      roverPhotos: roverPhotos ?? this.roverPhotos,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, roverPhotos, error];
}
