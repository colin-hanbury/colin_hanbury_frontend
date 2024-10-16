import 'dart:developer';

import 'package:colin_hanbury_frontend/bloc/candidates/candidates_event.dart';
import 'package:colin_hanbury_frontend/bloc/candidates/candidates_state.dart';
import 'package:colin_hanbury_frontend/repositories/visitor_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandidatesBLoC extends Bloc<CandidatesEvent, CandidatsState> {
  CandidatesBLoC({required this.visitorRepo}) : super(CandidatsState()) {
    // on<NewVisitor>(addNewVisitor as EventHandler<NewVisitor, CandidatsState>);
    on<LoadCandidates>(loadVisitors);
  }

  final VisitorRepo visitorRepo;

  // void addNewVisitor(NewVisitor event, Emitter<CandidatsState> emitter) async {
  //   visitorRepo.addNewVisitor(event.name);
  // }

  void loadVisitors(
      LoadCandidates event, Emitter<CandidatsState> emitter) async {
    emitter(state.copyWith(status: CandidatesStatus.loading));
    try {
      final visitors = await visitorRepo.getVisitors();
      log(visitors.toString());
      emitter(state.copyWith(
          visitors: visitors, status: CandidatesStatus.successful));
    } catch (e) {
      emitter(state.copyWith(status: CandidatesStatus.error));
    }
  }
}
