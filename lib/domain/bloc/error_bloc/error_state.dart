import 'package:equatable/equatable.dart';

class ErrorState extends Equatable {
  final String? errorMsg;

  const ErrorState({
    this.errorMsg,
  });

  ErrorState copyWith({
    String? errorMsg,
  }) =>
      ErrorState(
        errorMsg: errorMsg ?? this.errorMsg,
      );

  @override
  List<Object> get props => [
        errorMsg ?? '',
      ];
}
