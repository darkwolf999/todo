import 'package:equatable/equatable.dart';

abstract class ErrorEvent extends Equatable {
  const ErrorEvent();

  @override
  List<Object> get props => [];
}

class OnErrorEvent extends ErrorEvent {
  final String? statusCode;
  final String? message;

  const OnErrorEvent({
    this.statusCode,
    this.message,
  });

  @override
  List<Object> get props => [
        statusCode ?? 0,
        message ?? 0,
      ];
}
