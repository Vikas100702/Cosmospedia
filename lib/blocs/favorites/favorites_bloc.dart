

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/mars/rover.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavouritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavouritesInitial()) {
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ToggleLike>(_onToggleLike);
  }

  void _onAddFavorite(AddFavorite event, Emitter<FavoritesState> emit) {
    // Implement add to favorites
  }

  void _onRemoveFavorite(RemoveFavorite event, Emitter<FavoritesState> emit) {
    // Implement remove from favorites
  }

  void _onToggleLike(ToggleLike event, Emitter<FavoritesState> emit) {
    // Implement like/dislike toggle
  }
}
