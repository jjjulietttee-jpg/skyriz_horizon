import 'dart:math';
import '../entities/ring.dart';

class RingGenerator {
  final Random _random = Random();
  int _ringIdCounter = 0;

  Ring generateRing({
    required double currentGameSpeed,
    double? previousRingY,
  }) {
    final double minY = 0.25;
    final double maxY = 0.75;
    
    double yPosition;
    if (previousRingY != null) {
      final double maxDelta = 0.25;
      final double delta = (_random.nextDouble() * 2 - 1) * maxDelta;
      yPosition = (previousRingY + delta).clamp(minY, maxY);
    } else {
      yPosition = minY + _random.nextDouble() * (maxY - minY);
    }

    final double baseGapSize = 0.30;
    final double minGapSize = 0.22;
    final double gapReduction = (currentGameSpeed - 1.0) * 0.02;
    final double gapSize = (baseGapSize - gapReduction).clamp(minGapSize, baseGapSize);

    final double baseSpeed = 0.008;
    final double speedVariation = _random.nextDouble() * 0.003;
    final double speed = (baseSpeed + speedVariation) * currentGameSpeed;

    _ringIdCounter++;
    return Ring(
      id: 'ring_$_ringIdCounter',
      xPosition: 1.2,
      yPosition: yPosition,
      gapSize: gapSize,
      speed: speed,
      isPassed: false,
    );
  }

  void reset() {
    _ringIdCounter = 0;
  }
}
