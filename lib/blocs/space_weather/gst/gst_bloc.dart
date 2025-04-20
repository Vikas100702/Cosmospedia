
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/space_weather/gst_model.dart';
import '../../../data/repositories/space_weather/gst_repository.dart';

part 'gst_state.dart';
part 'gst_event.dart';

class GstBloc extends Bloc<GstEvent, GstState> {
  final GstRepository gstRepository;
  List<GstModel>? _cachedGstEvents;
  String? _cachedStartDate;
  String? _cachedEndDate;

  GstBloc({required this.gstRepository}) : super(GstInitial()) {
    on<FetchGstEvents>(_onFetchGstEvents);
  }

  Future<void> _onFetchGstEvents(
      FetchGstEvents event,
      Emitter<GstState> emit,
      ) async {
    // Return cached data if available and dates match
    if (_cachedGstEvents != null &&
        _cachedStartDate == event.startDate &&
        _cachedEndDate == event.endDate) {
      emit(GstLoaded(_cachedGstEvents!));
      return;
    }

    emit(GstLoading());
    try {
      final gstEvents = await gstRepository.getGstEvents(
        event.startDate,
        event.endDate,
      );
      _cachedGstEvents = gstEvents;
      _cachedStartDate = event.startDate;
      _cachedEndDate = event.endDate;
      emit(GstLoaded(gstEvents));
    } catch (e) {
      emit(GstError(e.toString()));
    }
  }

  void clearCache() {
    _cachedGstEvents = null;
    _cachedStartDate = null;
    _cachedEndDate = null;
  }
}