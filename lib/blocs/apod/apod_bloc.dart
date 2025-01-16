import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  ApodBloc() : super(ApodInitial()) {
    on<ApodEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
