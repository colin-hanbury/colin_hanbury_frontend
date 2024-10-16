import 'package:colin_hanbury_frontend/bloc/intro/intro_event.dart';
import 'package:colin_hanbury_frontend/bloc/intro/intro_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroState()) {
    on<ScrollEvent>(hasScrolled as EventHandler<ScrollEvent, IntroState>);
  }

  void hasScrolled(ScrollEvent event, Emitter<IntroState> emitter) {
    emitter(state.copyWith(amountScrolled: event.offset));
  }
}
