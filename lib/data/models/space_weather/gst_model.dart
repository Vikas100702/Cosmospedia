class GstModel {
  final String gstID;
  final DateTime startTime;
  final List<KpIndex> allKpIndex;
  final String link;
  final List<LinkedEvent>? linkedEvents;
  final DateTime submissionTime;
  final int versionId;

  GstModel({
    required this.gstID,
    required this.startTime,
    required this.allKpIndex,
    required this.link,
    this.linkedEvents,
    required this.submissionTime,
    required this.versionId,
  });

  factory GstModel.fromJson(Map<String, dynamic> json) {
    return GstModel(
      gstID: json['gstID'],
      startTime: DateTime.parse(json['startTime']),
      allKpIndex: List<KpIndex>.from(
          json['allKpIndex'].map((x) => KpIndex.fromJson(x))),
      link: json['link'],
      linkedEvents: json['linkedEvents'] != null
          ? List<LinkedEvent>.from(
          json['linkedEvents'].map((x) => LinkedEvent.fromJson(x)))
          : null,
      submissionTime: DateTime.parse(json['submissionTime']),
      versionId: json['versionId'],
    );
  }
}

class KpIndex {
  final DateTime observedTime;
  final double kpIndex;
  final String source;

  KpIndex({
    required this.observedTime,
    required this.kpIndex,
    required this.source,
  });

  factory KpIndex.fromJson(Map<String, dynamic> json) {
    return KpIndex(
      observedTime: DateTime.parse(json['observedTime']),
      kpIndex: json['kpIndex'].toDouble(),
      source: json['source'],
    );
  }
}

class LinkedEvent {
  final String activityID;

  LinkedEvent({
    required this.activityID,
  });

  factory LinkedEvent.fromJson(Map<String, dynamic> json) {
    return LinkedEvent(
      activityID: json['activityID'],
    );
  }
}