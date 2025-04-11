part of 'favorites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavouritesEvent {
  final Photos photo;

  const AddFavorite(this.photo);

  @override
  List<Object> get props => [photo];
}

class RemoveFavorite extends FavouritesEvent {
  final Photos photo;

  const RemoveFavorite(this.photo);

  @override
  List<Object> get props => [photo];
}

class ToggleLike extends FavouritesEvent {
  final Photos photo;
  final bool isLiked;

  const ToggleLike(this.photo, this.isLiked);

  @override
  List<Object> get props => [photo, isLiked];
}


