import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/apod_repositories.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApodRepository apodRepository;

  HomeBloc({required this.apodRepository}) : super(const HomeState()) {
    on<LoadHomeData>(_loadHomeData);
    on<RefreshHomeData>(_refreshHomeData);
    on<SwitchTab>(_switchTab);
  }

  Future<void> _loadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.loading,
    ));
    try {
      final apodImages = await apodRepository.getRecentApods(5); //For slider
      final newsItems = await apodRepository.getRecentApods(5); //For Cards.
      emit(state.copyWith(
        status: HomeStatus.success,
        apodImages: apodImages,
        newsItems: newsItems,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: error.toString(),
      ));
    }
  }

  Future<void> _refreshHomeData(
      RefreshHomeData event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(
      status: HomeStatus.loading,
    ));
    try {
      final apodImages = await apodRepository.getRecentApods(5); //For slider
      final newsItems = await apodRepository.getRecentApods(5); //For Cards.
      emit(state.copyWith(
        apodImages: apodImages,
        newsItems: newsItems,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: error.toString(),
      ));
    }
  }

  void _switchTab(SwitchTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentTab: event.index));
  }
}
