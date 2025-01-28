import 'package:cosmospedia/data/models/apod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()){
    on<LoadNewsEvent>(_onLoadNewsEvent);
  }

  void _onLoadNewsEvent(LoadNewsEvent event, Emitter<NewsState> emit) {
    emit(NewsLoaded(event.apodNews));
  }

  /*Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is LoadNewsEvent) {
      yield NewsLoaded(event.apodNews);
    }
  }*/
}
