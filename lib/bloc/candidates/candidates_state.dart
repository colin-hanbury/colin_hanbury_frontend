import 'package:colin_hanbury_frontend/models/visitor.dart';
import 'package:equatable/equatable.dart';

enum CandidatesStatus {
  initial,
  successful,
  loading,
  error,
}

class CandidatsState extends Equatable {
  final List<Visitor> visitors;
  final CandidatesStatus status;

  CandidatsState({
    this.status = CandidatesStatus.initial,
    List<Visitor>? visitors,
  }) : visitors = visitors ?? const [];

  @override
  List<Object?> get props => [status, visitors];

  CandidatsState copyWith({
    List<Visitor>? visitors,
    CandidatesStatus? status,
  }) =>
      CandidatsState(
          visitors: visitors ?? this.visitors, status: status ?? this.status);
}
