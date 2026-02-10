import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class GameStarted extends GameEvent {
  const GameStarted();
}

class GameTick extends GameEvent {
  final double deltaTime;

  const GameTick(this.deltaTime);

  @override
  List<Object?> get props => [deltaTime];
}

class PlayerTapped extends GameEvent {
  const PlayerTapped();
}

class PlayerReleased extends GameEvent {
  const PlayerReleased();
}

class GamePaused extends GameEvent {
  const GamePaused();
}

class GameResumed extends GameEvent {
  const GameResumed();
}

class GameRestarted extends GameEvent {
  const GameRestarted();
}
