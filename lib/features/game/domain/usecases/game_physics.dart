class GamePhysics {
  static const double gravity = 0.0015;
  static const double tapForce = -0.0025;
  static const double maxVelocity = 0.02;
  static const double velocityDamping = 0.98;
  
  static const double playerStartY = 0.5;
  static const double playerSize = 0.08;
  
  static const double ringBaseGapSize = 0.25;
  static const double ringMinGapSize = 0.18;
  static const double ringBaseSpeed = 0.008;
  static const double ringSpeedVariation = 0.003;
  
  static const double ringSpawnX = 1.2;
  static const double ringMinY = 0.2;
  static const double ringMaxY = 0.8;
  static const double ringMaxYDelta = 0.25;
  
  static const int gameLoopMs = 16;
  static const int scoreForSpeedIncrease = 10;
  static const double speedIncreaseMultiplier = 0.3;
}
