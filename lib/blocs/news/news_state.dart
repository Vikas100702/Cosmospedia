part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

final class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final ApodModel apodNews;

  NewsLoaded(this.apodNews);
}
