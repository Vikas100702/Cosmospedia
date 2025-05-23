import 'package:equatable/equatable.dart';
import '../../data/models/apod.dart';

enum NewsStatus { initial, loading, success, failure }

class NewsState extends Equatable {
  final NewsStatus status;
  final ApodModel? apod;
  final String? error;

  const NewsState({
    this.status = NewsStatus.initial,
    this.apod,
    this.error,
  });

  NewsState copyWith({
    NewsStatus? status,
    ApodModel? apod,
    String? error,
  }) {
    return NewsState(
      status: status ?? this.status,
      apod: apod ?? this.apod,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, apod, error];
}
