import 'package:cosmospedia/data/models/apod.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }
// enum CurrentScreen { home, marsRover, asteroids, weather, settings }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ApodModel> apodImages;
  final List<ApodModel> newsItems;
  final String? error;
  final int currentTabIndex;

  const HomeState({
    this.status = HomeStatus.initial,
    this.apodImages = const [],
    this.newsItems = const [],
    this.error,
    this.currentTabIndex = 0, // Default to Home screen
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ApodModel>? apodImages,
    List<ApodModel>? newsItems,
    String? error,
    int? currentTabIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      apodImages: apodImages ?? this.apodImages,
      newsItems: newsItems ?? this.newsItems,
      error: error ?? this.error,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [status, apodImages, newsItems, error, currentTabIndex];
}
