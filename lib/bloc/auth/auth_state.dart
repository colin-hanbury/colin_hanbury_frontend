import 'package:equatable/equatable.dart';

enum AuthStatus {
  unauthenticated,
  authenticated,
  loading,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String email;
  final String password;

  AuthState(
      {this.status = AuthStatus.unauthenticated,
      String? email,
      String? password})
      : email = email ?? '',
        password = password ?? '';

  @override
  List<Object?> get props => [status, email, password];

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? password,
  }) =>
      AuthState(
          status: status ?? this.status,
          email: email ?? this.email,
          password: password ?? this.password);
}
