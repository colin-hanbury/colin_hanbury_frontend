import 'package:colin_hanbury_frontend/bloc/registration/registration_event.dart';
import 'package:colin_hanbury_frontend/bloc/registration/registration_state.dart';
import 'package:colin_hanbury_frontend/repositories/registration_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required this.registrationRepo})
      : super(RegistrationState()) {
    on<RegisterEvent>(
        register as EventHandler<RegisterEvent, RegistrationState>);
  }

  final RegistrationRepo registrationRepo;

  Future<void> register(
      RegisterEvent event, Emitter<RegistrationState> emitter) async {
    emitter(state.copyWith(status: RegistrationStatus.loading));
    try {
      await registrationRepo.register(
        event.forename,
        event.surname,
        event.email,
        event.password,
      );
      emitter(state.copyWith(status: RegistrationStatus.unregistered));
    } catch (e) {
      emitter(state.copyWith(status: RegistrationStatus.error));
    }
  }
}
