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
  final List<CMEAnalysis>? cmeAnalyses; // Made nullable
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
    this.cmeAnalyses, // Now nullable
    this.linkedEvents,
  });

  factory CmeModel.fromJson(Map<String, dynamic> json) {
    return CmeModel(
      activityID: json['activityID'] as String,
      catalog: json['catalog'] as String,
      startTime: json['startTime'] as String,
      instruments: (json['instruments'] as List<dynamic>)
          .map((e) => Instrument.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceLocation: json['sourceLocation'] as String?,
      activeRegionNum: json['activeRegionNum'] as int?,
      note: json['note'] as String,
      submissionTime: json['submissionTime'] as String,
      versionId: json['versionId'] as int,
      link: json['link'] as String,
      cmeAnalyses: json['cmeAnalyses'] != null
          ? (json['cmeAnalyses'] as List<dynamic>)
              .map((e) => CMEAnalysis.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
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
    try {
      return CMEAnalysis(
        isMostAccurate: json['isMostAccurate'] is bool
            ? json['isMostAccurate'] as bool
            : json['isMostAccurate']?.toString().toLowerCase() == 'true',
        time21_5: _parseString(json['time21_5']),
        latitude: _parseDouble(json['latitude']),
        longitude: _parseDouble(json['longitude']),
        halfAngle: _parseDouble(json['halfAngle']),
        speed: _parseDouble(json['speed']),
        type: _parseString(json['type']),
        featureCode: _parseString(json['featureCode']),
        imageType: _parseString(json['imageType']),
        measurementTechnique: _parseString(json['measurementTechnique']),
        note: _parseString(json['note']),
        levelOfData: _parseInt(json['levelOfData']),
        tilt: _parseDouble(json['tilt']),
        minorHalfWidth: _parseDouble(json['minorHalfWidth']),
        speedMeasuredAtHeight: _parseDouble(json['speedMeasuredAtHeight']),
        submissionTime: _parseString(json['submissionTime']),
        link: _parseString(json['link']),
        enlilList: json['enlilList'] is List
            ? (json['enlilList'] as List).map((e) => Enlil.fromJson(e)).toList()
            : null,
      );
    } catch (e, stack) {
      print('Error parsing CMEAnalysis: $e\n$stack');
      print('Problematic JSON: $json');
      rethrow;
    }
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
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
  final double? au;
  final String? estimatedShockArrivalTime;
  final String? estimatedDuration;
  final double? rmin_re;
  final double? kp_18;
  final double? kp_90;
  final double? kp_135;
  final double? kp_180;
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
    try {
      return Enlil(
        modelCompletionTime: _parseString(json['modelCompletionTime']),
        au: _parseDouble(json['au']),
        estimatedShockArrivalTime: _parseString(json['estimatedShockArrivalTime']),
        estimatedDuration: _parseString(json['estimatedDuration']),
        rmin_re: _parseDouble(json['rmin_re']),
        kp_18: _parseDouble(json['kp_18']),
        kp_90: _parseDouble(json['kp_90']),
        kp_135: _parseDouble(json['kp_135']),
        kp_180: _parseDouble(json['kp_180']),
        isEarthGB: json['isEarthGB'] is bool
            ? json['isEarthGB'] as bool
            : json['isEarthGB']?.toString().toLowerCase() == 'true',
        link: _parseString(json['link']),
        impactList: json['impactList'] is List
            ? (json['impactList'] as List).map((e) => Impact.fromJson(e)).toList()
            : [],
        cmeIDs: json['cmeIDs'] is List
            ? (json['cmeIDs'] as List).map((e) => e.toString()).toList()
            : [],
      );
    } catch (e, stack) {
      print('Error parsing Enlil: $e\n$stack');
      print('Problematic JSON: $json');
      rethrow;
    }
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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
  final double? latitude; // Made nullable
  final double? longitude; // Made nullable
  final double? halfAngle; // Made nullable
  final double? speed; // Made nullable
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
    this.latitude,
    this.longitude,
    this.halfAngle,
    this.speed,
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
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      halfAngle: json['halfAngle'] != null
          ? (json['halfAngle'] as num).toDouble()
          : null,
      speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
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
      tilt: json['tilt'] != null ? (json['tilt'] as num).toDouble() : null,
      minorHalfWidth: json['minorHalfWidth'] != null
          ? (json['minorHalfWidth'] as num).toDouble()
          : null,
      speedMeasuredAtHeight: json['speedMeasuredAtHeight'] != null
          ? (json['speedMeasuredAtHeight'] as num).toDouble()
          : null,
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
