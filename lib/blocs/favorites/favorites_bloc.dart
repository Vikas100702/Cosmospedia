

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/mars/rover.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavouritesEvent, FavoritesState> {
  final List<Photos> _favorites = [];

  FavoritesBloc() : super(FavouritesInitial()) {
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ToggleLike>(_onToggleLike);
  }

  void _onAddFavorite(AddFavorite event, Emitter<FavoritesState> emit) {
    if (!_favorites.any((photo) => photo.id == event.photo.id)) {
      _favorites.add(event.photo);
      emit(FavoritesUpdated(List.from(_favorites)));
    }
  }

  void _onRemoveFavorite(RemoveFavorite event, Emitter<FavoritesState> emit) {
    _favorites.removeWhere((photo) => photo.id == event.photo.id);
    emit(FavoritesUpdated((List.from(_favorites))));
  }

  void _onToggleLike(ToggleLike event, Emitter<FavoritesState> emit) {
    // You can implement like/dislike logic here if needed
    // For now, we'll just treat it as a favorite action
    if (event.isLiked) {
      _onAddFavorite(AddFavorite(event.photo), emit);
    } else {
      // For dislike, you might want to track this separately
    }
  }
}
