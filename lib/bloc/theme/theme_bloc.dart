import 'package:colin_hanbury_frontend/bloc/theme/theme_event.dart';
import 'package:colin_hanbury_frontend/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ThemeChanged>(changeTheme as EventHandler<ThemeChanged, ThemeState>);
  }

  void changeTheme(ThemeChanged event, Emitter<ThemeState> emitter) {
    try {
      emitter(state.copyWith(status: ThemeStatus.successful, mode: event.mode));
    } catch (e) {
      emitter(state.copyWith(status: ThemeStatus.error));
    }
  }
}
