import 'package:equatable/equatable.dart';

class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends RegistrationEvent {
  final String forename;
  final String surname;
  final String email;
  final String password;
  RegisterEvent({
    required this.forename,
    required this.surname,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [
        forename,
        surname,
        email,
        password,
      ];
}
