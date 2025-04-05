import 'package:equatable/equatable.dart';

class RoverManifestModel extends Equatable {
  final String name;
  final String landingDate;
  final String launchDate;
  final String status;
  final int maxSol;
  final String maxDate;
  final int totalPhotos;
  final List<PhotoManifest> photos;

  const RoverManifestModel({
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.photos,
  });

  factory RoverManifestModel.fromJson(Map<String, dynamic> json) {
    return RoverManifestModel(
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: json['status'],
      maxSol: json['max_sol'],
      maxDate: json['max_date'],
      totalPhotos: json['total_photos'],
      photos: (json['photos'] as List<dynamic>)
          .map((photo) => PhotoManifest.fromJson(photo))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    name,
    landingDate,
    launchDate,
    status,
    maxSol,
    maxDate,
    totalPhotos,
    photos,
  ];
}

class PhotoManifest extends Equatable {
  final int sol;
  final String earthDate;
  final int totalPhotos;
  final List<String> cameras;

  const PhotoManifest({
    required this.sol,
    required this.earthDate,
    required this.totalPhotos,
    required this.cameras,
  });

  factory PhotoManifest.fromJson(Map<String, dynamic> json) {
    return PhotoManifest(
      sol: json['sol'],
      earthDate: json['earth_date'],
      totalPhotos: json['total_photos'],
      cameras: List<String>.from(json['cameras']),
    );
  }

  @override
  List<Object?> get props => [sol, earthDate, totalPhotos, cameras];
}