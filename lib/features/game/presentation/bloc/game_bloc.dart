import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/game_stats_service.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/ring.dart';
import '../../domain/usecases/collision_detector.dart';
import '../../domain/usecases/ring_generator.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final CollisionDetector _collisionDetector;
  final RingGenerator _ringGenerator;
  final GameStatsService _statsService;
  
  Timer? _gameLoopTimer;
  DateTime? _lastTickTime;
  DateTime? _gameStartTime;
  double _screenWidth = 0;
  double _screenHeight = 0;
  bool _statsSaved = false;

  GameBloc({
    CollisionDetector? collisionDetector,
    RingGenerator? ringGenerator,
    GameStatsService? statsService,
  })  : _collisionDetector = collisionDetector ?? CollisionDetector(),
        _ringGenerator = ringGenerator ?? RingGenerator(),
        _statsService = statsService ?? GameStatsService(),
        super(GameState.initial()) {
    on<GameStarted>(_onGameStarted);
    on<GameTick>(_onGameTick);
    on<PlayerTapped>(_onPlayerTapped);
    on<PlayerReleased>(_onPlayerReleased);
    on<GamePaused>(_onGamePaused);
    on<GameResumed>(_onGameResumed);
    on<GameRestarted>(_onGameRestarted);
  }

  void setScreenDimensions(double width, double height) {
    _screenWidth = width;
    _screenHeight = height;
  }

  void _onGameStarted(GameStarted event, Emitter<GameState> emit) async {
    _ringGenerator.reset();
    _lastTickTime = DateTime.now();
    _gameStartTime = DateTime.now();
    _statsSaved = false;

    final stats = await _statsService.getStats();
    final highScore = stats['highScore'] as int;

    final initialRings = <Ring>[
      _ringGenerator.generateRing(currentGameSpeed: 1.0),
    ];

    emit(state.copyWith(
      gameState: state.gameState.copyWith(
        status: GameStatus.playing,
        score: 0,
        highScore: highScore,
        rings: initialRings,
        player: const Player(yPosition: 0.5, velocity: 0.0),
        gameSpeed: 1.0,
      ),
      isPlayerTapping: false,
    ));

    _startGameLoop();
  }

  void _onGameTick(GameTick event, Emitter<GameState> emit) async {
    if (state.status != GameStatus.playing) return;

    final double gravity = 0.0005;
    final double tapForce = -0.0012;
    final double maxVelocity = 0.012;
    final double velocityDamping = 0.99;

    double newVelocity = state.player.velocity;
    if (state.isPlayerTapping) {
      newVelocity += tapForce;
    } else {
      newVelocity += gravity;
    }
    newVelocity = newVelocity.clamp(-maxVelocity, maxVelocity);
    newVelocity *= velocityDamping;

    double newYPosition = state.player.yPosition + newVelocity;
    newYPosition = newYPosition.clamp(0.0, 1.0);

    // Calculate angle based on velocity
    // velocity is around -0.012 to 0.012
    // We want angle in radians, e.g., -0.5 to 0.5
    final double newAngle = (newVelocity * 40).clamp(-0.6, 0.6);

    final updatedPlayer = state.player.copyWith(
      yPosition: newYPosition,
      velocity: newVelocity,
      angle: newAngle,
    );

    final updatedRings = <Ring>[];
    int newScore = state.score;
    bool collision = false;

    for (final ring in state.rings) {
      final newXPosition = ring.xPosition - ring.speed;

      if (newXPosition < -0.3) {
        continue;
      }

      final updatedRing = ring.copyWith(xPosition: newXPosition);

      if (_collisionDetector.checkCollision(
        player: updatedPlayer,
        ring: updatedRing,
        screenWidth: _screenWidth,
        screenHeight: _screenHeight,
      )) {
        collision = true;
        break;
      }

      if (_collisionDetector.checkIfPassed(
        ring: updatedRing,
        screenWidth: _screenWidth,
      )) {
        newScore++;
        updatedRings.add(updatedRing.copyWith(isPassed: true));
      } else {
        updatedRings.add(updatedRing);
      }
    }

    if (_collisionDetector.checkOutOfBounds(
      player: updatedPlayer,
      screenHeight: _screenHeight,
    )) {
      collision = true;
    }

    if (collision) {
      _stopGameLoop();
      
      if (!_statsSaved && _gameStartTime != null) {
        final playTimeSeconds = DateTime.now().difference(_gameStartTime!).inSeconds;
        await _statsService.saveGameResult(
          score: newScore,
          ringsPassed: newScore,
          playTimeSeconds: playTimeSeconds,
        );
        _statsSaved = true;
      }
      
      final newHighScore = newScore > state.highScore ? newScore : state.highScore;
      emit(state.copyWith(
        gameState: state.gameState.copyWith(
          status: GameStatus.gameOver,
          score: newScore,
          highScore: newHighScore,
          player: updatedPlayer,
          rings: updatedRings,
        ),
      ));
      return;
    }

    if (updatedRings.isEmpty || (updatedRings.last.xPosition < 0.3 && updatedRings.length < 4)) {
      final double? lastRingY = updatedRings.isNotEmpty ? updatedRings.last.yPosition : null;
      final double currentGameSpeed = 1.0 + (newScore / 10) * 0.3;
      final newRing = _ringGenerator.generateRing(
        currentGameSpeed: currentGameSpeed,
        previousRingY: lastRingY,
      );
      updatedRings.add(newRing);
    }

    final double currentGameSpeed = 1.0 + (newScore / 10) * 0.3;

    emit(state.copyWith(
      gameState: state.gameState.copyWith(
        player: updatedPlayer,
        rings: updatedRings,
        score: newScore,
        gameSpeed: currentGameSpeed,
      ),
    ));
  }

  void _onPlayerTapped(PlayerTapped event, Emitter<GameState> emit) {
    if (state.status == GameStatus.playing) {
      emit(state.copyWith(isPlayerTapping: true));
    }
  }

  void _onPlayerReleased(PlayerReleased event, Emitter<GameState> emit) {
    if (state.status == GameStatus.playing) {
      emit(state.copyWith(isPlayerTapping: false));
    }
  }

  void _onGamePaused(GamePaused event, Emitter<GameState> emit) {
    if (state.status == GameStatus.playing) {
      _stopGameLoop();
      emit(state.copyWith(
        gameState: state.gameState.copyWith(status: GameStatus.paused),
      ));
    }
  }

  void _onGameResumed(GameResumed event, Emitter<GameState> emit) {
    if (state.status == GameStatus.paused) {
      emit(state.copyWith(
        gameState: state.gameState.copyWith(status: GameStatus.playing),
      ));
      _lastTickTime = DateTime.now();
      _startGameLoop();
    }
  }

  void _onGameRestarted(GameRestarted event, Emitter<GameState> emit) {
    _stopGameLoop();
    add(const GameStarted());
  }

  void _startGameLoop() {
    _gameLoopTimer?.cancel();
    _lastTickTime = DateTime.now();
    
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final now = DateTime.now();
      final deltaTime = now.difference(_lastTickTime!).inMilliseconds / 16.0;
      _lastTickTime = now;
      
      add(GameTick(deltaTime));
    });
  }

  void _stopGameLoop() {
    _gameLoopTimer?.cancel();
    _gameLoopTimer = null;
  }

  @override
  Future<void> close() {
    _stopGameLoop();
    return super.close();
  }
}
