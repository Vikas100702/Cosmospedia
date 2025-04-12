import 'package:cosmospedia/data/models/apod.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }
enum CurrentScreen { home, marsRover, asteroids, map, settings }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ApodModel> apodImages;
  final List<ApodModel> newsItems;
  final String? error;
  final CurrentScreen currentScreen;

  const HomeState({
    this.status = HomeStatus.initial,
    this.apodImages = const [],
    this.newsItems = const [],
    this.error,
    this.currentScreen = CurrentScreen.home, // Default to Home screen
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ApodModel>? apodImages,
    List<ApodModel>? newsItems,
    String? error,
    CurrentScreen? currentScreen,
  }) {
    return HomeState(
      status: status ?? this.status,
      apodImages: apodImages ?? this.apodImages,
      newsItems: newsItems ?? this.newsItems,
      error: error ?? this.error,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }

  @override
  List<Object?> get props => [status, apodImages, newsItems, error, currentScreen];
}
