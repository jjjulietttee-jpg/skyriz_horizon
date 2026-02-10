class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
  });
}

class AchievementData {
  static List<Achievement> getAchievements(List<String> unlockedIds) {
    return [
      Achievement(
        id: 'first_flight',
        title: 'First Flight',
        description: 'Complete your first session',
        icon: '🚀',
        isUnlocked: unlockedIds.contains('first_flight'),
      ),
      Achievement(
        id: 'novice',
        title: 'Novice Pilot',
        description: 'Play 5 games',
        icon: '✈️',
        isUnlocked: unlockedIds.contains('novice'),
      ),
      Achievement(
        id: 'experienced',
        title: 'Experienced',
        description: 'Play 20 games',
        icon: '🛩️',
        isUnlocked: unlockedIds.contains('experienced'),
      ),
      Achievement(
        id: 'veteran',
        title: 'Veteran Pilot',
        description: 'Play 50 games',
        icon: '🛸',
        isUnlocked: unlockedIds.contains('veteran'),
      ),
      Achievement(
        id: 'score_10',
        title: 'Rising Star',
        description: 'Score 10 points',
        icon: '⭐',
        isUnlocked: unlockedIds.contains('score_10'),
      ),
      Achievement(
        id: 'score_25',
        title: 'Sky Master',
        description: 'Score 25 points',
        icon: '🌟',
        isUnlocked: unlockedIds.contains('score_25'),
      ),
      Achievement(
        id: 'score_50',
        title: 'Legend',
        description: 'Score 50 points',
        icon: '💫',
        isUnlocked: unlockedIds.contains('score_50'),
      ),
      Achievement(
        id: 'rings_100',
        title: 'Ring Collector',
        description: 'Pass through 100 rings',
        icon: '💍',
        isUnlocked: unlockedIds.contains('rings_100'),
      ),
      Achievement(
        id: 'rings_500',
        title: 'Ring Master',
        description: 'Pass through 500 rings',
        icon: '👑',
        isUnlocked: unlockedIds.contains('rings_500'),
      ),
      Achievement(
        id: 'time_30min',
        title: 'Dedicated',
        description: 'Play for 30 minutes total',
        icon: '⏱️',
        isUnlocked: unlockedIds.contains('time_30min'),
      ),
    ];
  }
}
