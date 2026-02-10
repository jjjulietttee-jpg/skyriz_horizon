import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/widgets/card_widget.dart';
import '../../../../core/shared/widgets/custom_popup.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import '../../../../core/data/game_stats_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GameStatsService _statsService = GameStatsService();
  String _username = 'Pilot';
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;
  bool _hasShownPopup = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final username = await _statsService.getUsername();
    final stats = await _statsService.getStats();

    setState(() {
      _username = username;
      _stats = stats;
      _isLoading = false;
    });

    if (!_hasShownPopup && username == 'Pilot') {
      _hasShownPopup = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showUsernamePopup();
      });
    }
  }

  void _showUsernamePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPopup(
        title: 'Welcome!',
        message: 'Enter your pilot name',
        showTextField: true,
        textFieldHint: 'Pilot Name',
        confirmText: 'Confirm',
        onConfirm: (value) async {
          if (value != null && value.trim().isNotEmpty) {
            await _statsService.saveUsername(value.trim());
            setState(() {
              _username = value.trim();
            });
          }
        },
      ),
    );
  }

  void _editUsername() {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        title: 'Edit Name',
        message: 'Enter your new pilot name',
        showTextField: true,
        textFieldHint: 'Pilot Name',
        initialValue: _username,
        confirmText: 'Save',
        cancelText: 'Cancel',
        onConfirm: (value) async {
          if (value != null && value.trim().isNotEmpty) {
            await _statsService.saveUsername(value.trim());
            setState(() {
              _username = value.trim();
            });
          }
        },
      ),
    );
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.push('/menu');
    }
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        title: 'SETTINGS',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSettingTile(
              context,
              'About App',
              Icons.info_outline,
              () {
                showDialog(
                  context: context,
                  builder: (context) => CustomPopup(
                    title: 'ABOUT APP',
                    message:
                        'SKYRIS HORIZON v1.0.0\n\nExperience the ultimate flight challenge. Navigate through the rings, master the winds, and become a legendary pilot.\n\nDesigned for speed and precision.',
                    confirmText: 'OK',
                    cancelText: '',
                    onConfirm: (_) {},
                  ),
                );
              },
            ),
            _buildSettingTile(
              context,
              'Reset Progress',
              Icons.refresh,
              () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => CustomPopup(
                    title: 'RESET PROGRESS?',
                    message: 'All your statistics will be lost forever.',
                    confirmText: 'RESET',
                    cancelText: 'CANCEL',
                    onConfirm: (_) => Navigator.pop(context, true),
                  ),
                );
                if (confirm == true) {
                  await _statsService.resetStats();
                  _loadData();
                  if (mounted) Navigator.pop(context);
                }
              },
              isDestructive: true,
            ),
          ],
        ),
        confirmText: 'CLOSE',
        cancelText: '',
        onConfirm: (_) {},
      ),
    );
  }

  Widget _buildSettingTile(
      BuildContext context, String title, IconData icon, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppColors.accentRed,
      ),
      title: CustomText(
        text: title,
        fontSize: context.mediumTextSize,
        color: isDestructive ? Colors.red : AppColors.textPrimary,
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'FLIGHT STATISTICS',
          fontSize: context.largeTextSize,
          fontWeight: FontWeight.w900,
          color: AppColors.accentRed,
        ),
        SizedBox(height: context.heightPercent(0.02)),
        CardWidget(
          child: Padding(
            padding: EdgeInsets.all(context.widthPercent(0.05)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatDetailItem(
                      context,
                      'High Score',
                      '${_stats['highScore'] ?? 0}',
                      Icons.emoji_events,
                    ),
                    _buildStatDetailItem(
                      context,
                      'Total Rings',
                      '${_stats['totalRings'] ?? 0}',
                      Icons.adjust,
                    ),
                  ],
                ),
                SizedBox(height: context.heightPercent(0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatDetailItem(
                      context,
                      'Games Played',
                      '${_stats['totalGames'] ?? 0}',
                      Icons.flight_takeoff,
                    ),
                    _buildStatDetailItem(
                      context,
                      'Play Time',
                      _formatPlayTime(_stats['totalPlayTime'] ?? 0),
                      Icons.timer,
                    ),
                  ],
                ),
                SizedBox(height: context.heightPercent(0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatDetailItem(
                      context,
                      'Avg Score',
                      '${_stats['averageScore'] ?? 0}',
                      Icons.analytics,
                    ),
                    _buildStatDetailItem(
                      context,
                      'Best Streak',
                      '${_stats['bestStreak'] ?? 0}',
                      Icons.bolt,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatDetailItem(
      BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.accentRed,
            size: context.widthPercent(0.06),
          ),
          SizedBox(height: context.heightPercent(0.01)),
          CustomText(
            text: value,
            fontSize: context.mediumTextSize,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.heightPercent(0.005)),
          CustomText(
            text: label.toUpperCase(),
            fontSize: context.smallTextSize * 0.8,
            enableGlow: false,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatPlayTime(int seconds) {
    if (seconds < 60) return '${seconds}s';
    if (seconds < 3600) return '${(seconds / 60).floor()}m';
    return '${(seconds / 3600).toStringAsFixed(1)}h';
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
                      pinned: false,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                          size: context.widthPercent(0.08),
                        ),
                        onPressed: _handleBack,
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: AppColors.textPrimary,
                            size: context.widthPercent(0.07),
                          ),
                          onPressed: _showSettings,
                        ),
                        SizedBox(width: 8),
                      ],
                      expandedHeight: context.heightPercent(0.25),
                      flexibleSpace: FlexibleSpaceBar(
                        background: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _editUsername,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.primaryGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.glowColor.withValues(alpha: 0.4),
                                        blurRadius: 12.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _username.isNotEmpty ? _username[0].toUpperCase() : 'P',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              GestureDetector(
                                onTap: _editUsername,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _username.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.edit,
                                      color: AppColors.accentRed,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: context.defaultPadding,
                      sliver: SliverToBoxAdapter(
                        child: _buildStatsSection(context),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
