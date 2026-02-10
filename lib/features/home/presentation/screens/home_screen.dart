import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/widgets/custom_elevated_button.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import '../../../../core/data/game_stats_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GameStatsService _statsService = GameStatsService();
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await _statsService.getStats();
    setState(() {
      _stats = stats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: context.defaultPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      CustomText(
                        text: 'SKYLINE DRIFT',
                        fontSize: context.largeTextSize * 1.8,
                        fontWeight: FontWeight.w900,
                        textAlign: TextAlign.center,
                        color: AppColors.accentRed,
                      ),
                      SizedBox(height: context.heightPercent(0.01)),
                      CustomText(
                        text: 'TAKE OFF TO THE STARS',
                        fontSize: context.mediumTextSize,
                        enableGlow: true,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.center,
                      ),
                      if (_stats != null) ...[
                        SizedBox(height: context.heightPercent(0.04)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem(
                              context,
                              'High Score',
                              '${_stats!['highScore']}',
                            ),
                            SizedBox(width: context.widthPercent(0.08)),
                            _buildStatItem(
                              context,
                              'Games',
                              '${_stats!['totalGames']}',
                            ),
                            SizedBox(width: context.widthPercent(0.08)),
                            _buildStatItem(
                              context,
                              'Rings',
                              '${_stats!['totalRings']}',
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: context.heightPercent(0.08)),
                      CustomElevatedButton(
                        text: 'Play',
                        onPressed: () async {
                          await context.push('/game');
                          _loadStats();
                        },
                        fontSize: context.largeTextSize,
                        height: context.heightPercent(0.09),
                      ),
                      SizedBox(height: context.heightPercent(0.03)),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: 'Profile',
                              onPressed: () async {
                                await context.push('/profile');
                                _loadStats();
                              },
                              fontSize: context.mediumTextSize,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.accentRed.withValues(alpha: 0.8),
                                  AppColors.accentOrange.withValues(alpha: 0.6),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: context.widthPercent(0.04)),
                          Expanded(
                            child:                       CustomElevatedButton(
                        text: 'Achievements',
                        onPressed: () async {
                          await context.push('/achievements');
                          _loadStats();
                        },
                        fontSize: context.mediumTextSize,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accentOrange.withValues(alpha: 0.6),
                            AppColors.accentRed.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        CustomText(
          text: value,
          fontSize: context.largeTextSize,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: context.heightPercent(0.005)),
        CustomText(
          text: label,
          fontSize: context.smallTextSize,
          enableGlow: false,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}
