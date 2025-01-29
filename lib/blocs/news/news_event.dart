/*
part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNewsData extends NewsEvent{
  */
/*final ApodModel apodNews;
  LoadNewsData(this.apodNews);*//*

}

class RefreshNewsData extends NewsEvent {}*/

import 'package:equatable/equatable.dart';
import '../../data/models/apod.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNewsDetails extends NewsEvent {
  final ApodModel apod;

  const LoadNewsDetails(this.apod);

  @override
  List<Object?> get props => [apod];
}
