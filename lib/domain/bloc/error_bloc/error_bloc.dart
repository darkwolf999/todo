import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/domain/bloc/error_bloc/error_event.dart';
import 'package:todo/domain/bloc/error_bloc/error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<OnErrorEvent>(_onError);
  }

  void _onError(OnErrorEvent event, Emitter<ErrorState> emit) {
    emit(state.copyWith(errorMsg: event.message));
  }
}
