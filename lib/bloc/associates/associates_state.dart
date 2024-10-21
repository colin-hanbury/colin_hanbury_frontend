import 'package:colin_hanbury_frontend/models/visitor.dart';
import 'package:equatable/equatable.dart';

enum AssociatesStatus {
  initial,
  successful,
  loading,
  error,
}

class AssociatesState extends Equatable {
  final List<Associate> associates;
  final AssociatesStatus status;

  AssociatesState({
    this.status = AssociatesStatus.initial,
    List<Associate>? associates,
  }) : associates = associates ?? const [];

  @override
  List<Object?> get props => [status, associates];

  AssociatesState copyWith({
    List<Associate>? associates,
    AssociatesStatus? status,
  }) =>
      AssociatesState(
          associates: associates ?? this.associates,
          status: status ?? this.status);
}
