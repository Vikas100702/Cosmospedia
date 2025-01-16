import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {}
