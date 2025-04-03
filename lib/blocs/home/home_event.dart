import 'package:cosmospedia/blocs/home/home_state.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {}

class SwitchScreen extends HomeEvent {
  final CurrentScreen screen;
  SwitchScreen(this.screen);

  @override
  List<Object> get props => [screen];

}
