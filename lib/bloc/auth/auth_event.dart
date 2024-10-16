import 'package:colin_hanbury_frontend/models/user.dart';
import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthEvent {
  final User user;

  LogoutEvent({
    required this.user,
  });
  @override
  List<Object?> get props => [user];
}
