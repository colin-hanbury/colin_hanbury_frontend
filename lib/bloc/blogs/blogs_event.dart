import 'package:equatable/equatable.dart';

class AssociatesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// class NewVisitor extends CandidatesEvent {
//   final String name;
//
//   NewVisitor({
//     required this.name,
//   });
//
//   @override
//   List<Object?> get props => [name];
// }

class LoadAssociates extends AssociatesEvent {}
