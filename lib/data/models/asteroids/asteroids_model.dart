import 'package:equatable/equatable.dart';

class Asteroid extends Equatable {
  final String id;
  final String name;
  final String designation;
  final double absoluteMagnitudeH;
  final EstimatedDiameter estimatedDiameter;
  final bool isPotentiallyHazardous;
  final List<CloseApproachData> closeApproachData;

  const Asteroid({
    required this.id,
    required this.name,
    required this.designation,
    required this.absoluteMagnitudeH,
    required this.estimatedDiameter,
    required this.isPotentiallyHazardous,
    required this.closeApproachData,
  });

  factory Asteroid.fromJson(Map<String, dynamic> json) {
    return Asteroid(
      id: json['id'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      absoluteMagnitudeH: (json['absolute_magnitude_h'] as num).toDouble(),
      estimatedDiameter: EstimatedDiameter.fromJson(json['estimated_diameter']),
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'] as bool,
      closeApproachData: (json['close_approach_data'] as List)
          .map((e) => CloseApproachData.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    designation,
    absoluteMagnitudeH,
    estimatedDiameter,
    isPotentiallyHazardous,
    closeApproachData,
  ];
}

class EstimatedDiameter extends Equatable {
  final DiameterRange kilometers;
  final DiameterRange meters;
  final DiameterRange miles;
  final DiameterRange feet;

  const EstimatedDiameter({
    required this.kilometers,
    required this.meters,
    required this.miles,
    required this.feet,
  });

  factory EstimatedDiameter.fromJson(Map<String, dynamic> json) {
    return EstimatedDiameter(
      kilometers: DiameterRange.fromJson(json['kilometers']),
      meters: DiameterRange.fromJson(json['meters']),
      miles: DiameterRange.fromJson(json['miles']),
      feet: DiameterRange.fromJson(json['feet']),
    );
  }

  @override
  List<Object?> get props => [kilometers, meters, miles, feet];
}

class DiameterRange extends Equatable {
  final double min;
  final double max;

  const DiameterRange({required this.min, required this.max});

  factory DiameterRange.fromJson(Map<String, dynamic> json) {
    return DiameterRange(
      min: (json['estimated_diameter_min'] as num).toDouble(),
      max: (json['estimated_diameter_max'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [min, max];
}

class CloseApproachData extends Equatable {
  final String date;
  final String dateFull;
  final RelativeVelocity relativeVelocity;
  final MissDistance missDistance;
  final String orbitingBody;

  const CloseApproachData({
    required this.date,
    required this.dateFull,
    required this.relativeVelocity,
    required this.missDistance,
    required this.orbitingBody,
  });

  factory CloseApproachData.fromJson(Map<String, dynamic> json) {
    return CloseApproachData(
      date: json['close_approach_date'] as String,
      dateFull: json['close_approach_date_full'] as String,
      relativeVelocity: RelativeVelocity.fromJson(json['relative_velocity']),
      missDistance: MissDistance.fromJson(json['miss_distance']),
      orbitingBody: json['orbiting_body'] as String,
    );
  }

  @override
  List<Object?> get props => [
    date,
    dateFull,
    relativeVelocity,
    missDistance,
    orbitingBody,
  ];
}

class RelativeVelocity extends Equatable {
  final double kilometersPerSecond;
  final double kilometersPerHour;
  final double milesPerHour;

  const RelativeVelocity({
    required this.kilometersPerSecond,
    required this.kilometersPerHour,
    required this.milesPerHour,
  });

  factory RelativeVelocity.fromJson(Map<String, dynamic> json) {
    return RelativeVelocity(
      kilometersPerSecond:
      double.parse(json['kilometers_per_second'] as String),
      kilometersPerHour: double.parse(json['kilometers_per_hour'] as String),
      milesPerHour: double.parse(json['miles_per_hour'] as String),
    );
  }

  @override
  List<Object?> get props => [
    kilometersPerSecond,
    kilometersPerHour,
    milesPerHour,
  ];
}

class MissDistance extends Equatable {
  final double astronomical;
  final double lunar;
  final double kilometers;
  final double miles;

  const MissDistance({
    required this.astronomical,
    required this.lunar,
    required this.kilometers,
    required this.miles,
  });

  factory MissDistance.fromJson(Map<String, dynamic> json) {
    return MissDistance(
      astronomical: double.parse(json['astronomical'] as String),
      lunar: double.parse(json['lunar'] as String),
      kilometers: double.parse(json['kilometers'] as String),
      miles: double.parse(json['miles'] as String),
    );
  }

  @override
  List<Object?> get props => [astronomical, lunar, kilometers, miles];
}