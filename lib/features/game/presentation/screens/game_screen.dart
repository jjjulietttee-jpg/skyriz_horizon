import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import '../../domain/entities/game_state_entity.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../widgets/player_widget.dart';
import '../widgets/ring_widget.dart';
import '../widgets/game_hud.dart';
import '../widgets/game_over_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: const _GameScreenContent(),
    );
  }
}

class _GameScreenContent extends StatefulWidget {
  const _GameScreenContent();

  @override
  State<_GameScreenContent> createState() => _GameScreenContentState();
}

class _GameScreenContentState extends State<_GameScreenContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    context.read<GameBloc>().setScreenDimensions(size.width, size.height);
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.push('/menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                if (state.status == GameStatus.initial)
                  _buildInitialScreen(context),
                if (state.status == GameStatus.playing ||
                    state.status == GameStatus.paused)
                  _buildGameplayScreen(context, state),
                if (state.status == GameStatus.gameOver)
                  _buildGameOverScreen(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInitialScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.8),
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: context.defaultPadding,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: context.widthPercent(0.08),
                    ),
                    onPressed: _handleBack,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'SKYLINE DRIFT',
                      fontSize: context.largeTextSize * 1.5,
                      fontWeight: FontWeight.w900,
                      textAlign: TextAlign.center,
                      color: AppColors.accentRed,
                    ),
                    SizedBox(height: context.heightPercent(0.02)),
                    CustomText(
                      text: 'Navigate through the flow',
                      fontSize: context.mediumTextSize,
                      enableGlow: false,
                      color: AppColors.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.heightPercent(0.06)),
                    Container(
                      padding: EdgeInsets.all(context.widthPercent(0.05)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.cardBackground.withValues(alpha: 0.6),
                            AppColors.secondaryDark.withValues(alpha: 0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(context.widthPercent(0.04)),
                      ),
                      child: Column(
                        children: [
                          _buildInstructionRow(
                            context,
                            '👆',
                            'Tap and hold to rise',
                          ),
                          SizedBox(height: context.heightPercent(0.02)),
                          _buildInstructionRow(
                            context,
                            '👇',
                            'Release to descend',
                          ),
                          SizedBox(height: context.heightPercent(0.02)),
                          _buildInstructionRow(
                            context,
                            '🎯',
                            'Fly through the rings',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPercent(0.06)),
                    CustomElevatedButton(
                      text: 'TAKE OFF',
                      onPressed: () {
                        context.read<GameBloc>().add(const GameStarted());
                      },
                      fontSize: context.mediumTextSize,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionRow(BuildContext context, String emoji, String text) {
    return Row(
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: context.largeTextSize),
        ),
        SizedBox(width: context.widthPercent(0.04)),
        Expanded(
          child: CustomText(
            text: text,
            fontSize: context.mediumTextSize,
            enableGlow: false,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildGameplayScreen(BuildContext context, GameState state) {
    return GestureDetector(
      onTapDown: (_) {
        context.read<GameBloc>().add(const PlayerTapped());
      },
      onTapUp: (_) {
        context.read<GameBloc>().add(const PlayerReleased());
      },
      onTapCancel: () {
        context.read<GameBloc>().add(const PlayerReleased());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            for (final ring in state.rings) RingWidget(ring: ring),
            PlayerWidget(player: state.player),
            GameHUD(
              score: state.score,
              highScore: state.highScore,
              onPause: () {
                context.read<GameBloc>().add(const GamePaused());
              },
            ),
            if (state.status == GameStatus.paused)
              _buildPauseOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPauseOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(context.widthPercent(0.08)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.cardBackground.withValues(alpha: 0.95),
                AppColors.secondaryDark.withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(context.widthPercent(0.06)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Paused',
                fontSize: context.largeTextSize,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: context.heightPercent(0.04)),
              CustomElevatedButton(
                text: 'Resume',
                onPressed: () {
                  context.read<GameBloc>().add(const GameResumed());
                },
              ),
              SizedBox(height: context.heightPercent(0.02)),
              CustomElevatedButton(
                text: 'Exit',
                onPressed: _handleBack,
                gradient: LinearGradient(
                  colors: [
                    AppColors.textSecondary.withValues(alpha: 0.6),
                    AppColors.textSecondary.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverScreen(BuildContext context, GameState state) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.black.withValues(alpha: 0.8),
        child: Stack(
          children: [
            for (final ring in state.rings) RingWidget(ring: ring),
            PlayerWidget(player: state.player),
            GameOverDialog(
              score: state.score,
              highScore: state.highScore,
              onRestart: () {
                context.read<GameBloc>().add(const GameRestarted());
              },
              onExit: _handleBack,
            ),
          ],
        ),
      ),
    );
  }
}
