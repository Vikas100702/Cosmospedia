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
