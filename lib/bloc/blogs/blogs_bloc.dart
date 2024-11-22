import 'dart:developer';

import 'package:colin_hanbury_frontend/bloc/associates/associates_event.dart';
import 'package:colin_hanbury_frontend/bloc/associates/associates_state.dart';
import 'package:colin_hanbury_frontend/repositories/associates_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssociatesBLoC extends Bloc<AssociatesEvent, AssociatesState> {
  AssociatesBLoC({required this.visitorRepo}) : super(AssociatesState()) {
    // on<NewVisitor>(addNewVisitor as EventHandler<NewVisitor, CandidatesState>);
    on<LoadAssociates>(loadAssociates);
  }

  final AssociatesRepo visitorRepo;

  // void addNewVisitor(NewVisitor event, Emitter<CandidatsState> emitter) async {
  //   visitorRepo.addNewVisitor(event.name);
  // }

  void loadAssociates(
      LoadAssociates event, Emitter<AssociatesState> emitter) async {
    emitter(state.copyWith(status: AssociatesStatus.loading));
    try {
      final associates = await visitorRepo.getVisitors();
      log(associates.toString());
      emitter(state.copyWith(
          associates: associates, status: AssociatesStatus.successful));
    } catch (e) {
      emitter(state.copyWith(status: AssociatesStatus.error));
    }
  }
}
