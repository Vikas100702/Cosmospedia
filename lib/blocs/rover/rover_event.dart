part of 'rover_bloc.dart';

abstract class RoverEvent extends Equatable {
  const RoverEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoverData extends RoverEvent {
  final String roverName;
  final int? sol;
  final String? earthDate;

  const LoadRoverData({
    required this.roverName,
    this.sol,
    this.earthDate,
  });

  @override
  List<Object?> get props => [roverName, sol, earthDate,];
}

class RefreshRoverData extends RoverEvent {}
