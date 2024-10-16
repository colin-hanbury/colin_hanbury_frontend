import 'package:equatable/equatable.dart';

class IntroState extends Equatable {
  final double amountScrolled;
  final double dy;

  IntroState({
    double? amountScrolled,
    double? dy,
  })  : amountScrolled = amountScrolled ?? 0.0,
        dy = dy ?? 0.0;

  @override
  List<Object?> get props => [
        amountScrolled,
      ];

  IntroState copyWith({
    double? amountScrolled,
  }) =>
      IntroState(
        amountScrolled: amountScrolled ?? this.amountScrolled,
        dy: (amountScrolled ?? this.amountScrolled - this.amountScrolled),
      );
}
