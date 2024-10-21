import 'package:equatable/equatable.dart';

enum AuthStatus {
  unauthenticated,
  authenticated,
  loading,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String error;

  AuthState({
    this.status = AuthStatus.unauthenticated,
    String? error,
  }) : error = error ?? '';

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  AuthState copyWith({
    AuthStatus? status,
    String? error,
  }) =>
      AuthState(
        status: status ?? this.status,
        error: error ?? this.error,
      );
}
