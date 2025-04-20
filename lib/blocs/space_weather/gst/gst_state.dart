part of 'gst_bloc.dart';

abstract class GstState extends Equatable {
  const GstState();

  @override
  List<Object> get props => [];
}

class GstInitial extends GstState {}

class GstLoading extends GstState {}

class GstLoaded extends GstState {
  final List<GstModel> gstEvents;

  const GstLoaded(this.gstEvents);

  @override
  List<Object> get props => [gstEvents];
}

class GstError extends GstState {
  final String message;

  const GstError(this.message);

  @override
  List<Object> get props => [message];
}