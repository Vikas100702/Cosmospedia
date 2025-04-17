import 'package:equatable/equatable.dart';

class CmeModel extends Equatable {
  final String activityID;
  final String catalog;
  final String startTime;
  final List<Instrument> instruments;
  final String? sourceLocation;
  final int? activeRegionNum;
  final String note;
  final String submissionTime;
  final int versionId;
  final String link;
  final List<CMEAnalysis> cmeAnalyses;
  final List<dynamic>? linkedEvents;

  const CmeModel({
    required this.activityID,
    required this.catalog,
    required this.startTime,
    required this.instruments,
    this.sourceLocation,
    this.activeRegionNum,
    required this.note,
    required this.submissionTime,
    required this.versionId,
    required this.link,
    required this.cmeAnalyses,
    required this.linkedEvents,
  });

  factory CmeModel.fromJson(Map<String, dynamic> json) {
    return CmeModel(
      activityID: json['activityID'] as String,
      catalog: json['catalog'] as String,
      startTime: json['startTime'] as String,
      instruments: (json['instruments'] as List)
          .map((e) => Instrument.fromJson(e))
          .toList(),
      sourceLocation: json['sourceLocation'] as String?,
      activeRegionNum: json['activeRegionNum'] as int?,
      note: json['note'] as String,
      submissionTime: json['submissionTime'] as String,
      versionId: json['versionId'] as int,
      link: json['link'] as String,
      cmeAnalyses: (json['cmeAnalyses'] as List)
          .map((e) => CMEAnalysis.fromJson(e))
          .toList(),
      linkedEvents: json['linkedEvents'] as List<dynamic>?,
    );
  }

  @override
  List<Object?> get props => [
        activityID,
        catalog,
        startTime,
        instruments,
        sourceLocation,
        activeRegionNum,
        note,
        submissionTime,
        versionId,
        link,
        cmeAnalyses,
        linkedEvents,
      ];
}

class Instrument extends Equatable {
  final String displayName;

  const Instrument({
    required this.displayName,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      displayName: json['displayName'] as String,
    );
  }

  @override
  List<Object?> get props => [displayName];
}

class CMEAnalysis extends Equatable {
  final bool isMostAccurate;
  final String time21_5;
  final double? latitude;
  final double? longitude;
  final double? halfAngle;
  final double? speed;
  final String type;
  final String? featureCode;
  final String? imageType;
  final String? measurementTechnique;
  final String? note;
  final int? levelOfData;
  final double? tilt;
  final double? minorHalfWidth;
  final double? speedMeasuredAtHeight;
  final String submissionTime;
  final String link;
  final List<Enlil>? enlilList;

  const CMEAnalysis({
    required this.isMostAccurate,
    required this.time21_5,
    this.latitude,
    this.longitude,
    this.halfAngle,
    this.speed,
    required this.type,
    this.featureCode,
    this.imageType,
    this.measurementTechnique,
    this.note,
    this.levelOfData,
    this.tilt,
    this.minorHalfWidth,
    this.speedMeasuredAtHeight,
    required this.submissionTime,
    required this.link,
    this.enlilList,
  });

  factory CMEAnalysis.fromJson(Map<String, dynamic> json) {
    return CMEAnalysis(
      isMostAccurate: json['isMostAccurate'] as bool,
      time21_5: json['time21_5'] as String,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      halfAngle: json['halfAngle'] != null ? (json['halfAngle'] as num).toDouble() : null,
      speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
      type: json['type'] as String,
      featureCode: json['featureCode'] as String?,
      imageType: json['imageType'] as String?,
      measurementTechnique: json['measurementTechnique'] as String?,
      note: json['note'] as String?,
      levelOfData: json['levelOfData'] as int?,
      tilt: json['tilt'] != null ? (json['tilt'] as num).toDouble() : null,
      minorHalfWidth: json['minorHalfWidth'] != null ? (json['minorHalfWidth'] as num).toDouble() : null,
      speedMeasuredAtHeight: json['speedMeasuredAtHeight'] != null ? (json['speedMeasuredAtHeight'] as num).toDouble() : null,
      submissionTime: json['submissionTime'] as String,
      link: json['link'] as String,
      enlilList: json['enlilList'] != null
          ? (json['enlilList'] as List).map((e) => Enlil.fromJson(e)).toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [
    isMostAccurate,
    time21_5,
    latitude,
    longitude,
    halfAngle,
    speed,
    type,
    featureCode,
    imageType,
    measurementTechnique,
    note,
    levelOfData,
    tilt,
    minorHalfWidth,
    speedMeasuredAtHeight,
    submissionTime,
    link,
    enlilList,
  ];
}

class Enlil extends Equatable {
  final String modelCompletionTime;
  final double? au;  // Made nullable
  final String? estimatedShockArrivalTime;
  final String? estimatedDuration;
  final double? rmin_re;  // Made nullable
  final double? kp_18;    // Made nullable
  final double? kp_90;    // Made nullable
  final double? kp_135;   // Made nullable
  final double? kp_180;   // Made nullable
  final bool isEarthGB;
  final String link;
  final List<Impact> impactList;
  final List<String> cmeIDs;

  const Enlil({
    required this.modelCompletionTime,
    this.au,
    this.estimatedShockArrivalTime,
    this.estimatedDuration,
    this.rmin_re,
    this.kp_18,
    this.kp_90,
    this.kp_135,
    this.kp_180,
    required this.isEarthGB,
    required this.link,
    required this.impactList,
    required this.cmeIDs,
  });

  factory Enlil.fromJson(Map<String, dynamic> json) {
    return Enlil(
      modelCompletionTime: json['modelCompletionTime'] as String,
      au: json['au'] != null ? (json['au'] as num).toDouble() : null,
      estimatedShockArrivalTime: json['estimatedShockArrivalTime'] as String?,
      estimatedDuration: json['estimatedDuration'] as String?,
      rmin_re: json['rmin_re'] != null ? (json['rmin_re'] as num).toDouble() : null,
      kp_18: json['kp_18'] != null ? (json['kp_18'] as num).toDouble() : null,
      kp_90: json['kp_90'] != null ? (json['kp_90'] as num).toDouble() : null,
      kp_135: json['kp_135'] != null ? (json['kp_135'] as num).toDouble() : null,
      kp_180: json['kp_180'] != null ? (json['kp_180'] as num).toDouble() : null,
      isEarthGB: json['isEarthGB'] as bool,
      link: json['link'] as String,
      impactList: (json['impactList'] as List).map((e) => Impact.fromJson(e)).toList(),
      cmeIDs: (json['cmeIDs'] as List).map((e) => e as String).toList(),
    );
  }

  @override
  List<Object?> get props => [
    modelCompletionTime,
    au,
    estimatedShockArrivalTime,
    estimatedDuration,
    rmin_re,
    kp_18,
    kp_90,
    kp_135,
    kp_180,
    isEarthGB,
    link,
    impactList,
    cmeIDs,
  ];
}

class Impact extends Equatable {
  final bool isGlancingBlow;
  final String location;
  final String arrivalTime;

  const Impact({
    required this.isGlancingBlow,
    required this.location,
    required this.arrivalTime,
  });

  factory Impact.fromJson(Map<String, dynamic> json) {
    return Impact(
      isGlancingBlow: json['isGlancingBlow'] as bool,
      location: json['location'] as String,
      arrivalTime: json['arrivalTime'] as String,
    );
  }

  @override
  List<Object?> get props => [isGlancingBlow, location, arrivalTime];
}

class CMEAnalysisModel extends Equatable {
  final String time21_5;
  final double latitude;
  final double longitude;
  final double halfAngle;
  final double speed;
  final String type;
  final bool isMostAccurate;
  final String? associatedCMEID;
  final String? note;
  final String? associatedCMEstartTime;
  final String catalog;
  final String? featureCode;
  final String dataLevel;
  final String? measurementTechnique;
  final String? imageType;
  final double? tilt;
  final double? minorHalfWidth;
  final double? speedMeasuredAtHeight;
  final String submissionTime;
  final int versionId;
  final String link;

  const CMEAnalysisModel({
    required this.time21_5,
    required this.latitude,
    required this.longitude,
    required this.halfAngle,
    required this.speed,
    required this.type,
    required this.isMostAccurate,
    this.associatedCMEID,
    this.note,
    this.associatedCMEstartTime,
    required this.catalog,
    this.featureCode,
    required this.dataLevel,
    this.measurementTechnique,
    this.imageType,
    this.tilt,
    this.minorHalfWidth,
    this.speedMeasuredAtHeight,
    required this.submissionTime,
    required this.versionId,
    required this.link,
  });

  factory CMEAnalysisModel.fromJson(Map<String, dynamic> json) {
    return CMEAnalysisModel(
      time21_5: json['time21_5'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      halfAngle: (json['halfAngle'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      type: json['type'] as String,
      isMostAccurate: json['isMostAccurate'] as bool,
      associatedCMEID: json['associatedCMEID'] as String?,
      note: json['note'] as String?,
      associatedCMEstartTime: json['associatedCMEstartTime'] as String?,
      catalog: json['catalog'] as String,
      featureCode: json['featureCode'] as String?,
      dataLevel: json['dataLevel'] as String,
      measurementTechnique: json['measurementTechnique'] as String?,
      imageType: json['imageType'] as String?,
      tilt: json['tilt'] as double?,
      minorHalfWidth: json['minorHalfWidth'] as double?,
      speedMeasuredAtHeight: json['speedMeasuredAtHeight'] as double?,
      submissionTime: json['submissionTime'] as String,
      versionId: json['versionId'] as int,
      link: json['link'] as String,
    );
  }

  @override
  List<Object?> get props => [
    time21_5,
    latitude,
    longitude,
    halfAngle,
    speed,
    type,
    isMostAccurate,
    associatedCMEID,
    note,
    associatedCMEstartTime,
    catalog,
    featureCode,
    dataLevel,
    measurementTechnique,
    imageType,
    tilt,
    minorHalfWidth,
    speedMeasuredAtHeight,
    submissionTime,
    versionId,
    link,
  ];
}
