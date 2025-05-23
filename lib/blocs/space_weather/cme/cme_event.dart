part of 'cme_bloc.dart';

abstract class CMEEvent extends Equatable {
  const CMEEvent();

  @override
  List<Object> get props => [];
}

class LoadCMEData extends CMEEvent {
  final String startDate;
  final String endDate;
  final bool loadAnalysis;

  const LoadCMEData({
    required this.startDate,
    required this.endDate,
    this.loadAnalysis = true,
  });

  @override
  List<Object> get props => [startDate, endDate, loadAnalysis];
}

class LoadCMEAnalysisData extends CMEEvent {
  final String startDate;
  final String endDate;
  final bool mostAccurateOnly;
  final double? speed;
  final double? halfAngle;
  final String catalog;

  const LoadCMEAnalysisData({
    required this.startDate,
    required this.endDate,
    this.mostAccurateOnly = true,
    this.speed,
    this.halfAngle,
    this.catalog = 'ALL',
  });

  @override
  List<Object> get props => [
    startDate,
    endDate,
    mostAccurateOnly,
    speed ?? 0,
    halfAngle ?? 0,
    catalog,
  ];
}