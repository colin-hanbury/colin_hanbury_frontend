import 'package:equatable/equatable.dart';

class IntroEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScrollEvent extends IntroEvent {
  final double offset;
  ScrollEvent({
    required this.offset,
  });
  @override
  List<Object?> get props => [
        offset,
      ];
}
