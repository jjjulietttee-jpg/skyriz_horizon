# Altitude Drift Game

Production-ready implementation of "Altitude Drift" - a motion-based arcade game.

## Architecture

Clean Architecture with BLoC pattern:

```
game/
├── domain/
│   ├── entities/          # Pure business objects
│   │   ├── player.dart
│   │   ├── ring.dart
│   │   └── game_state_entity.dart
│   └── usecases/          # Business logic
│       ├── collision_detector.dart
│       └── ring_generator.dart
├── presentation/
│   ├── bloc/              # State management
│   │   ├── game_bloc.dart
│   │   ├── game_event.dart
│   │   └── game_state.dart
│   ├── screens/
│   │   └── game_screen.dart
│   └── widgets/           # UI components
│       ├── player_widget.dart
│       ├── ring_widget.dart
│       ├── game_hud.dart
│       └── game_over_dialog.dart
```

## Game Mechanics

### Player Control
- **Tap & Hold**: Player rises (upward force applied)
- **Release**: Player descends (gravity applied)
- **Physics**: Velocity-based movement with damping

### Objectives
- Fly through moving rings without collision
- Each ring passed = +1 score
- Avoid hitting ring edges or screen boundaries

### Difficulty Progression
- Game speed increases every 10 points
- Ring gap size decreases with speed
- Ring positions vary smoothly

### Game States
- **Initial**: Start screen with instructions
- **Playing**: Active gameplay
- **Paused**: Game paused (not implemented in UI yet)
- **GameOver**: Score display with restart option

## Technical Details

### Physics Constants
```dart
gravity: 0.0015          // Downward acceleration
tapForce: -0.0025        // Upward force when tapping
maxVelocity: 0.02        // Terminal velocity
velocityDamping: 0.98    // Friction coefficient
```

### Ring Generation
- Spawns at x: 1.2 (off-screen right)
- Y position: 0.2 - 0.8 (safe zone)
- Gap size: 0.25 - 0.18 (decreases with difficulty)
- Speed: 0.008 base + variation + difficulty multiplier

### Collision Detection
- Circle-to-rectangle collision for player-ring
- Boundary checking for screen edges
- Precise hitbox calculations

### Performance
- 60 FPS game loop (16ms tick rate)
- Efficient state updates with Equatable
- Minimal widget rebuilds with BLoC

## Dependencies
- flutter_bloc: ^8.1.6
- equatable: ^2.0.5

## Testing
All game logic is unit-testable:
- CollisionDetector: Pure function testing
- RingGenerator: Deterministic with seed
- GameBloc: Event-driven state testing

## Future Enhancements
- Power-ups
- Multiple difficulty modes
- Particle effects
- Sound effects
- Leaderboard (requires storage)
