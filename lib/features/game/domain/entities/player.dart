import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final double yPosition;
  final double velocity;
  final double size;
  final double angle;

  const Player({
    required this.yPosition,
    required this.velocity,
    this.size = 0.08,
    this.angle = 0.0,
  });

  Player copyWith({
    double? yPosition,
    double? velocity,
    double? size,
    double? angle,
  }) {
    return Player(
      yPosition: yPosition ?? this.yPosition,
      velocity: velocity ?? this.velocity,
      size: size ?? this.size,
      angle: angle ?? this.angle,
    );
  }

  @override
  List<Object?> get props => [yPosition, velocity, size, angle];
}
