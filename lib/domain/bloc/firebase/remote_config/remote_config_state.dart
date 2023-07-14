part of 'remote_config_bloc.dart';

enum RemoteConfigStatus { initial, success, failure }

class RemoteConfigState extends Equatable {
  final RemoteConfigStatus status;
  final int? highPriorityColor;

  const RemoteConfigState({
    this.status = RemoteConfigStatus.initial,
    this.highPriorityColor,
  });

  RemoteConfigState copyWith({
    RemoteConfigStatus? status,
    int? highPriorityColor,
  }) =>
      RemoteConfigState(
        status: status ?? this.status,
        highPriorityColor: highPriorityColor ?? this.highPriorityColor,
      );

  @override
  List<Object> get props => [
        status,
        highPriorityColor ?? '',
      ];
}
