/*
import 'package:cosmospedia/data/models/apod.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/apod_repositories.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApodRepository apodRepository;

  NewsBloc({required this.apodRepository}) : super(const NewsState()) {
    on<LoadNewsData>(_loadNewsData);
    on<RefreshNewsData>(_refreshNewsData);
  }

  Future<void> _loadNewsData(
      LoadNewsData event, Emitter<NewsState> emit) async {
    emit(
      state.copyWith(
        status: NewsStatus.loading,
      ),
    );
    try {
      final newsDetail = await apodRepository.getRecentApods(1);
      emit(
        state.copyWith(
          status: NewsStatus.success,
          newsItems: newsDetail,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: NewsStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _refreshNewsData(
      RefreshNewsData event, Emitter<NewsState> emit) async {
    emit(state.copyWith(
      status: NewsStatus.loading,
    ));
    try {
      final newsItems = await apodRepository.getRecentApods(1);
      emit(
        state.copyWith(
          status: NewsStatus.success,
          newsItems: newsItems,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: NewsStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }
}
*/

/*import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/apod.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<LoadNewsDetails>(_onLoadNewsDetails);
  }

  void _onLoadNewsDetails(
      LoadNewsDetails event,
      Emitter<NewsState> emit,
      ) async {
    try {
      emit(state.copyWith(status: NewsStatus.loading));
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
}*/


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
