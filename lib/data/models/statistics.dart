class Statistics {
  int _correctRate = 0;
  int _dailySolved = 0;
  int _monthlySolved = 0;
  int _totalSolved = 0;
  int _maxStreak = 0;
  int _collectedCards = 0;

  Statistics(
      this._correctRate,
      this._dailySolved,
      this._monthlySolved,
      this._totalSolved,
      this._maxStreak,
      this._collectedCards);

  int get collectedCards => _collectedCards;
  int get maxStreak => _maxStreak;
  int get totalSolved => _totalSolved;
  int get monthlySolved => _monthlySolved;
  int get dailySolved => _dailySolved;
  int get correctRate => _correctRate;

  @override
  String toString() {
    return 'Statistics{_correctRate: $_correctRate, _dailySolved: $_dailySolved, _monthlySolved: $_monthlySolved, _totalSolved: $_totalSolved, _maxStreak: $_maxStreak, _collectedCards: $_collectedCards}';
  }

  static Map<String, dynamic> toJson(Statistics statistics) {
    return {
      'correct_rate' : statistics.correctRate,
      'daily_solved' : statistics.dailySolved,
      'monthly_solved' : statistics.monthlySolved,
      'total_solved' : statistics.totalSolved,
      'max_streak' : statistics.maxStreak,
      'collected_cards' : statistics.collectedCards
    };
  }

  static Statistics fromJson(Map<String, dynamic> statisticsMap) {
    return Statistics(
        statisticsMap['correct_rate'], statisticsMap['daily_solved'], statisticsMap['monthly_solved'], statisticsMap['total_solved'],
        statisticsMap['max_streak'], statisticsMap['collected_cards']
    );
  }
}