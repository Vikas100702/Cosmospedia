import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/space_weather/cme_model.dart';
import '../../../data/repositories/space_weather/cme_repository.dart';

part 'cme_event.dart';
part 'cme_state.dart';

class CMEBloc extends Bloc<CMEEvent, CMEState> {
  final CMERepository cmeRepository;

  CMEBloc({required this.cmeRepository}) : super(const CMEState()) {
    on<LoadCMEData>(_loadCMEData);
    on<LoadCMEAnalysisData>(_loadCMEAnalysisData);
  }

  Future<void> _loadCMEData(
      LoadCMEData event,
      Emitter<CMEState> emit,
      ) async {
    emit(state.copyWith(status: CMEStatus.loading));
    try {
      final cmeList = await cmeRepository.getCMEs(
        startDate: event.startDate,
        endDate: event.endDate,
      );

      List<CMEAnalysisModel> cmeAnalysisList = [];
      if (event.loadAnalysis) {
        try {
          cmeAnalysisList = await cmeRepository.getCMEAnalyses(
            startDate: event.startDate,
            endDate: event.endDate,
          );
        } catch (e) {
          debugPrint('Error loading CME analysis: $e');
          // Continue with empty analysis list
        }
      }

      emit(state.copyWith(
        status: CMEStatus.success,
        cmeList: cmeList,
        cmeAnalysisList: cmeAnalysisList,
      ));
    } catch (error, stackTrace) {
      debugPrint('Error in _loadCMEData: $error\n$stackTrace');
      emit(state.copyWith(
        status: CMEStatus.failure,
        error: error.toString(),
      ));
    }
  }

  Future<void> _loadCMEAnalysisData(
      LoadCMEAnalysisData event,
      Emitter<CMEState> emit,
      ) async {
    emit(state.copyWith(status: CMEStatus.loading));
    try {
      final cmeAnalysisList = await cmeRepository.getCMEAnalyses(
        startDate: event.startDate,
        endDate: event.endDate,
        mostAccurateOnly: event.mostAccurateOnly,
        speed: event.speed,
        halfAngle: event.halfAngle,
        catalog: event.catalog,
      );
      emit(state.copyWith(
        status: CMEStatus.success,
        cmeAnalysisList: cmeAnalysisList,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: CMEStatus.failure,
        error: error.toString(),
      ));
    }
  }
}