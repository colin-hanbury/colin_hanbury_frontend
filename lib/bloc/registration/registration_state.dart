import 'package:equatable/equatable.dart';

enum RegistrationStatus {
  unregistered,
  registered,
  loading,
  error,
}

class RegistrationState extends Equatable {
  final RegistrationStatus status;
  final String email;
  final String password;

  RegistrationState(
      {this.status = RegistrationStatus.unregistered,
      String? email,
      String? password})
      : email = email ?? '',
        password = password ?? '';

  @override
  List<Object?> get props => [status, email, password];

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? email,
    String? password,
  }) =>
      RegistrationState(
          status: status ?? this.status,
          email: email ?? this.email,
          password: password ?? this.password);
}
