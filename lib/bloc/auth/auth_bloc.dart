import 'package:colin_hanbury_frontend/bloc/auth/auth_event.dart';
import 'package:colin_hanbury_frontend/bloc/auth/auth_state.dart';
import 'package:colin_hanbury_frontend/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepo}) : super(AuthState()) {
    on<LoginEvent>(login as EventHandler<LoginEvent, AuthState>);
    on<LogoutEvent>(logout);
  }

  final AuthRepo authRepo;

  Future<void> login(LoginEvent event, Emitter<AuthState> emitter) async {
    emitter(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.login(event.email, event.password);
      emitter(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emitter(state.copyWith(status: AuthStatus.error));
    }
  }

  Future<void> logout(LogoutEvent event, Emitter<AuthState> emitter) async {
    emitter(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.logout(event.user);
      emitter(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emitter(state.copyWith(status: AuthStatus.error));
    }
  }
}
