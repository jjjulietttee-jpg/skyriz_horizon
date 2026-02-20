import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/widgets/card_widget.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import '../../../../core/data/game_stats_service.dart';
import '../../../../core/data/achievement_data.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final GameStatsService _statsService = GameStatsService();
  List<Achievement> _achievements = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final unlockedIds = await _statsService.getUnlockedAchievements();
    final achievements = AchievementData.getAchievements(unlockedIds);

    setState(() {
      _achievements = achievements;
      _isLoading = false;
    });
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/fone.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                          size: context.widthPercent(0.08),
                        ),
                        onPressed: _handleBack,
                      ),
                      title: CustomText(
                        text: 'ACHIEVEMENTS',
                        fontSize: context.largeTextSize,
                        fontWeight: FontWeight.w900,
                        color: AppColors.accentRed,
                      ),
                      centerTitle: true,
                    ),
                    SliverPadding(
                      padding: context.defaultPadding,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final achievement = _achievements[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: context.heightPercent(0.02),
                              ),
                              child: CardWidget(
                                child: Padding(
                                  padding: EdgeInsets.all(context.widthPercent(0.04)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: context.widthPercent(0.15),
                                        height: context.widthPercent(0.15),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: achievement.isUnlocked
                                              ? AppColors.accentRed.withValues(alpha: 0.3)
                                              : AppColors.textSecondary.withValues(alpha: 0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            achievement.icon,
                                            style: TextStyle(
                                              fontSize: context.largeTextSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: context.widthPercent(0.04)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: achievement.title.toUpperCase(),
                                              fontSize: context.mediumTextSize,
                                              fontWeight: FontWeight.w900,
                                              enableGlow: false,
                                              color: achievement.isUnlocked
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                            ),
                                            SizedBox(height: context.heightPercent(0.005)),
                                            CustomText(
                                              text: achievement.description,
                                              fontSize: context.smallTextSize,
                                              enableGlow: false,
                                              color: AppColors.textSecondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (achievement.isUnlocked)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.accentRed,
                                          size: context.widthPercent(0.06),
                                        )
                                      else
                                        Icon(
                                          Icons.lock,
                                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                                          size: context.widthPercent(0.06),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: _achievements.length,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
