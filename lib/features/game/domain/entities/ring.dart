import 'package:equatable/equatable.dart';

class Ring extends Equatable {
  final String id;
  final double xPosition;
  final double yPosition;
  final double gapSize;
  final double speed;
  final bool isPassed;

  const Ring({
    required this.id,
    required this.xPosition,
    required this.yPosition,
    required this.gapSize,
    required this.speed,
    this.isPassed = false,
  });

  Ring copyWith({
    String? id,
    double? xPosition,
    double? yPosition,
    double? gapSize,
    double? speed,
    bool? isPassed,
  }) {
    return Ring(
      id: id ?? this.id,
      xPosition: xPosition ?? this.xPosition,
      yPosition: yPosition ?? this.yPosition,
      gapSize: gapSize ?? this.gapSize,
      speed: speed ?? this.speed,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  @override
  List<Object?> get props => [id, xPosition, yPosition, gapSize, speed, isPassed];
}
