import 'package:equatable/equatable.dart';
import 'player.dart';
import 'ring.dart';

enum GameStatus { initial, playing, paused, gameOver }

class GameStateEntity extends Equatable {
  final Player player;
  final List<Ring> rings;
  final int score;
  final int highScore;
  final GameStatus status;
  final double gameSpeed;

  const GameStateEntity({
    required this.player,
    required this.rings,
    required this.score,
    required this.highScore,
    required this.status,
    this.gameSpeed = 1.0,
  });

  GameStateEntity copyWith({
    Player? player,
    List<Ring>? rings,
    int? score,
    int? highScore,
    GameStatus? status,
    double? gameSpeed,
  }) {
    return GameStateEntity(
      player: player ?? this.player,
      rings: rings ?? this.rings,
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      status: status ?? this.status,
      gameSpeed: gameSpeed ?? this.gameSpeed,
    );
  }

  @override
  List<Object?> get props => [player, rings, score, highScore, status, gameSpeed];
}
