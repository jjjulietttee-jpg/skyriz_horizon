import 'package:equatable/equatable.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/ring.dart';

class GameState extends Equatable {
  final GameStateEntity gameState;
  final bool isPlayerTapping;

  const GameState({
    required this.gameState,
    this.isPlayerTapping = false,
  });

  factory GameState.initial() {
    return GameState(
      gameState: GameStateEntity(
        player: const Player(
          yPosition: 0.5,
          velocity: 0.0,
        ),
        rings: const [],
        score: 0,
        highScore: 0,
        status: GameStatus.initial,
        gameSpeed: 1.0,
      ),
      isPlayerTapping: false,
    );
  }

  GameState copyWith({
    GameStateEntity? gameState,
    bool? isPlayerTapping,
  }) {
    return GameState(
      gameState: gameState ?? this.gameState,
      isPlayerTapping: isPlayerTapping ?? this.isPlayerTapping,
    );
  }

  Player get player => gameState.player;
  List<Ring> get rings => gameState.rings;
  int get score => gameState.score;
  int get highScore => gameState.highScore;
  GameStatus get status => gameState.status;
  double get gameSpeed => gameState.gameSpeed;

  @override
  List<Object?> get props => [gameState, isPlayerTapping];
}
