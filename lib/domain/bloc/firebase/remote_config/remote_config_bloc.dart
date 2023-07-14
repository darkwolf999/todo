import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo/data/repositories/firebase/remote_config_repository_impl.dart';
import 'package:todo/my_logger.dart';

part 'remote_config_event.dart';

part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final RemoteConfigRepositoryImpl _remoteConfigRepositoryImpl;

  RemoteConfigBloc(this._remoteConfigRepositoryImpl)
      : super(const RemoteConfigState()) {
    on<InitConfigEvent>(_onInitConfig);
  }

  Future<void> _onInitConfig(
    InitConfigEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    await _remoteConfigRepositoryImpl.init();
    emit(
      state.copyWith(
        status: RemoteConfigStatus.success,
        highPriorityColor: _remoteConfigRepositoryImpl.highPriorityColor,
      ),
    );

    MyLogger.log(
      'remote config high prioirty color is ${state.highPriorityColor}',
    );
  }
}
