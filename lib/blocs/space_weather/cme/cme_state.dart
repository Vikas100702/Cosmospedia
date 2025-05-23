part of 'cme_bloc.dart';

enum CMEStatus { initial, loading, success, failure }

class CMEState extends Equatable {
  final CMEStatus status;
  final List<CmeModel> cmeList;
  final List<CMEAnalysisModel> cmeAnalysisList;
  final String? error;

  const CMEState({
    this.status = CMEStatus.initial,
    this.cmeList = const [],
    this.cmeAnalysisList = const [],
    this.error,
  });

  CMEState copyWith({
    CMEStatus? status,
    List<CmeModel>? cmeList,
    List<CMEAnalysisModel>? cmeAnalysisList,
    String? error,
  }) {
    return CMEState(
      status: status ?? this.status,
      cmeList: cmeList ?? this.cmeList,
      cmeAnalysisList: cmeAnalysisList ?? this.cmeAnalysisList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, cmeList, cmeAnalysisList, error];
}