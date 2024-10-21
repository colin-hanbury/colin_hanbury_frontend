import 'package:equatable/equatable.dart';

enum RegistrationStatus {
  unregistered,
  registered,
  loading,
  error,
}

class RegistrationState extends Equatable {
  final RegistrationStatus status;
  final String error;

  RegistrationState({
    this.status = RegistrationStatus.unregistered,
    String? error,
  }) : error = error ?? '';

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? error,
  }) =>
      RegistrationState(
        status: status ?? this.status,
        error: error ?? this.error,
      );
}
