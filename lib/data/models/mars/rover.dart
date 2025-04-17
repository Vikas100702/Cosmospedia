import 'package:equatable/equatable.dart';

class RoverModel extends Equatable {
  final List<Photos>? photos;

  const RoverModel({
    this.photos,
  });

  factory RoverModel.fromJson(Map<String, dynamic> json) {
    return RoverModel(
      photos: json['photos'] != null
          ? List<Photos>.from(json['photos'].weather((v) => Photos.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [photos];
}

class Photos extends Equatable {
  final int? id;
  final int? sol;
  final Camera? camera;
  final String? imgSrc;
  final String? earthDate;
  final Rover? rover;

  const Photos({
    this.id,
    this.sol,
    this.camera,
    this.imgSrc,
    this.earthDate,
    this.rover,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'],
      sol: json['sol'],
      camera: json['camera'] != null ? Camera.fromJson(json['camera']) : null,
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      rover: json['rover'] != null ? Rover.fromJson(json['rover']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['sol'] = sol;
    if (camera != null) {
      data['camera'] = camera!.toJson();
    }
    data['img_src'] = imgSrc;
    data['earth_date'] = earthDate;
    if (rover != null) {
      data['rover'] = rover!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [id, sol, camera, imgSrc, earthDate, rover];
}

class Camera extends Equatable {
  final int? id;
  final String? name;
  final int? roverId;
  final String? fullName;

  const Camera({
    this.id,
    this.name,
    this.roverId,
    this.fullName,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      name: json['name'],
      roverId: json['rover_id'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['rover_id'] = roverId;
    data['full_name'] = fullName;
    return data;
  }

  @override
  List<Object?> get props => [id, name, roverId, fullName];
}

class Rover extends Equatable {
  final int? id;
  final String? name;
  final String? landingDate;
  final String? launchDate;
  final String? status;

  const Rover({
    this.id,
    this.name,
    this.landingDate,
    this.launchDate,
    this.status,
  });

  factory Rover.fromJson(Map<String, dynamic> json) {
    return Rover(
      id: json['id'],
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['landing_date'] = landingDate;
    data['launch_date'] = launchDate;
    data['status'] = status;
    return data;
  }

  @override
  List<Object?> get props => [id, name, landingDate, launchDate, status];
}