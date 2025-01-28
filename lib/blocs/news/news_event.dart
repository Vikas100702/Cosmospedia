part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent{
  final ApodModel apodNews;

  LoadNewsEvent(this.apodNews);
}
