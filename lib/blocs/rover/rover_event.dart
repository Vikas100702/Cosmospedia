part of 'rover_bloc.dart';

abstract class RoverEvent extends Equatable{
  const RoverEvent();

  @override
  List<Object> get props => [];
}

class LoadRoverData extends RoverEvent {
  final String roverName;
  final int sol;

  const LoadRoverData({required this.roverName, this.sol = 1000});

  @override
  List<Object> get props => [roverName, sol];
}

class RefreshRoverData extends RoverEvent {}

