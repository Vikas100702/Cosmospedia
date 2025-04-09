part of 'rover_bloc.dart';

abstract class RoverEvent extends Equatable {
  const RoverEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoverData extends RoverEvent {
  final String roverName;
  final String? cameraName;
  final String? earthDate;
  final int? sol;

  const LoadRoverData({
    required this.roverName,
    this.cameraName,
    this.earthDate,
    this.sol,
  });

  @override
  List<Object?> get props => [roverName, cameraName, earthDate, sol];
}

class RefreshRoverData extends RoverEvent {}
