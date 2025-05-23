import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/apod_repositories.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApodRepository apodRepository;

  NewsBloc({required this.apodRepository}) : super(const NewsState()) {
    on<LoadNewsDetails>(_onLoadNewsDetails);
  }

  void _onLoadNewsDetails(
      LoadNewsDetails event,
      Emitter<NewsState> emit,
      ) async {
    try {
      emit(state.copyWith(status: NewsStatus.loading));
      // Here you can use apodRepository if you need to fetch additional data
      emit(state.copyWith(
        status: NewsStatus.success,
        apod: event.apod,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
