part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<Photos> favorites;

  const FavoritesUpdated(this.favorites);

  @override
  List<Object> get props => [favorites];
}
