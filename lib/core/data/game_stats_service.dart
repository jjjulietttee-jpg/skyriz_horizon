import 'package:shared_preferences/shared_preferences.dart';

class GameStatsService {
  static const String _keyHighScore = 'high_score';
  static const String _keyTotalGames = 'total_games';
  static const String _keyTotalScore = 'total_score';
  static const String _keyTotalRings = 'total_rings';
  static const String _keyBestStreak = 'best_streak';
  static const String _keyTotalPlayTime = 'total_play_time';
  static const String _keyLastPlayDate = 'last_play_date';
  static const String _keyUsername = 'username';
  static const String _keyAchievements = 'achievements';

  Future<void> saveGameResult({
    required int score,
    required int ringsPassed,
    required int playTimeSeconds,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final currentHighScore = prefs.getInt(_keyHighScore) ?? 0;
    if (score > currentHighScore) {
      await prefs.setInt(_keyHighScore, score);
    }

    final totalGames = (prefs.getInt(_keyTotalGames) ?? 0) + 1;
    await prefs.setInt(_keyTotalGames, totalGames);

    final totalScore = (prefs.getInt(_keyTotalScore) ?? 0) + score;
    await prefs.setInt(_keyTotalScore, totalScore);

    final totalRings = (prefs.getInt(_keyTotalRings) ?? 0) + ringsPassed;
    await prefs.setInt(_keyTotalRings, totalRings);

    final bestStreak = prefs.getInt(_keyBestStreak) ?? 0;
    if (ringsPassed > bestStreak) {
      await prefs.setInt(_keyBestStreak, ringsPassed);
    }

    final totalPlayTime = (prefs.getInt(_keyTotalPlayTime) ?? 0) + playTimeSeconds;
    await prefs.setInt(_keyTotalPlayTime, totalPlayTime);

    await prefs.setString(_keyLastPlayDate, DateTime.now().toIso8601String());

    await _checkAndUnlockAchievements(prefs);
  }

  Future<Map<String, dynamic>> getStats() async {
    final prefs = await SharedPreferences.getInstance();

    final totalGames = prefs.getInt(_keyTotalGames) ?? 0;
    final totalScore = prefs.getInt(_keyTotalScore) ?? 0;
    final avgScore = totalGames > 0 ? (totalScore / totalGames).round() : 0;

    return {
      'highScore': prefs.getInt(_keyHighScore) ?? 0,
      'totalGames': totalGames,
      'totalScore': totalScore,
      'averageScore': avgScore,
      'totalRings': prefs.getInt(_keyTotalRings) ?? 0,
      'bestStreak': prefs.getInt(_keyBestStreak) ?? 0,
      'totalPlayTime': prefs.getInt(_keyTotalPlayTime) ?? 0,
      'lastPlayDate': prefs.getString(_keyLastPlayDate),
    };
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? 'Pilot';
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  Future<List<String>> getUnlockedAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyAchievements) ?? [];
  }

  Future<void> _checkAndUnlockAchievements(SharedPreferences prefs) async {
    final unlocked = prefs.getStringList(_keyAchievements) ?? [];
    final stats = await getStats();

    if (!unlocked.contains('first_flight') && stats['totalGames'] >= 1) {
      unlocked.add('first_flight');
    }

    if (!unlocked.contains('novice') && stats['totalGames'] >= 5) {
      unlocked.add('novice');
    }

    if (!unlocked.contains('experienced') && stats['totalGames'] >= 20) {
      unlocked.add('experienced');
    }

    if (!unlocked.contains('veteran') && stats['totalGames'] >= 50) {
      unlocked.add('veteran');
    }

    if (!unlocked.contains('score_10') && stats['highScore'] >= 10) {
      unlocked.add('score_10');
    }

    if (!unlocked.contains('score_25') && stats['highScore'] >= 25) {
      unlocked.add('score_25');
    }

    if (!unlocked.contains('score_50') && stats['highScore'] >= 50) {
      unlocked.add('score_50');
    }

    if (!unlocked.contains('rings_100') && stats['totalRings'] >= 100) {
      unlocked.add('rings_100');
    }

    if (!unlocked.contains('rings_500') && stats['totalRings'] >= 500) {
      unlocked.add('rings_500');
    }

    if (!unlocked.contains('time_30min') && stats['totalPlayTime'] >= 1800) {
      unlocked.add('time_30min');
    }

    await prefs.setStringList(_keyAchievements, unlocked);
  }

  Future<void> resetStats() async {
    final prefs = await SharedPreferences.getInstance();
    final username = await getUsername();
    await prefs.clear();
    await saveUsername(username);
  }
}
