part of 'gst_bloc.dart';

abstract class GstEvent extends Equatable {
  const GstEvent();

  @override
  List<Object> get props => [];
}

class FetchGstEvents extends GstEvent {
  final String startDate;
  final String endDate;

  const FetchGstEvents({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}