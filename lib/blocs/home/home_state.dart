import 'package:cosmospedia/data/models/apod.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ApodModel> apodImages;
  final List<ApodModel> newsItems;
  final String? error;
  final int currentTab;

  const HomeState({
    this.status = HomeStatus.initial,
    this.apodImages = const [],
    this.newsItems = const [],
    this.error,
    this.currentTab = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ApodModel>? apodImages,
    List<ApodModel>? newsItems,
    String? error,
    int? currentTab,
  }) {
    return HomeState(
      status: status ?? this.status,
      apodImages: apodImages ?? this.apodImages,
      newsItems: newsItems ?? this.newsItems,
      error: error ?? this.error,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [status, apodImages, newsItems, error, currentTab];
}
