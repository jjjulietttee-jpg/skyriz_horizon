import '../entities/player.dart';
import '../entities/ring.dart';

class CollisionDetector {
  bool checkCollision({
    required Player player,
    required Ring ring,
    required double screenWidth,
    required double screenHeight,
  }) {
    final double playerSize = screenHeight * player.size;
    final double playerCenterY = screenHeight * player.yPosition;
    final double playerTop = playerCenterY - playerSize / 2;
    final double playerBottom = playerCenterY + playerSize / 2;

    final double ringX = screenWidth * ring.xPosition;
    final double ringCenterY = screenHeight * ring.yPosition;
    final double ringGapSize = screenHeight * ring.gapSize;
    final double ringTop = ringCenterY - ringGapSize / 2;
    final double ringBottom = ringCenterY + ringGapSize / 2;

    final double ringWidth = screenWidth * 0.15;
    final double playerCenterX = screenWidth * 0.2;

    final bool isInRingXRange = 
        playerCenterX + playerSize / 2 > ringX - ringWidth / 2 &&
        playerCenterX - playerSize / 2 < ringX + ringWidth / 2;

    if (isInRingXRange) {
      final bool isOutsideGap = playerTop < ringTop || playerBottom > ringBottom;
      return isOutsideGap;
    }

    return false;
  }

  bool checkIfPassed({
    required Ring ring,
    required double screenWidth,
  }) {
    final double ringX = screenWidth * ring.xPosition;
    final double playerX = screenWidth * 0.2;
    return ringX < playerX && !ring.isPassed;
  }

  bool checkOutOfBounds({
    required Player player,
    required double screenHeight,
  }) {
    final double playerSize = screenHeight * player.size;
    final double playerCenterY = screenHeight * player.yPosition;
    final double playerTop = playerCenterY - playerSize / 2;
    final double playerBottom = playerCenterY + playerSize / 2;

    return playerTop <= 0 || playerBottom >= screenHeight;
  }
}
