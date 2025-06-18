class HomeState {
  final int todayExpense;
  final int yesterdayExpense;
  final int thisWeekExpense;
  final int lastWeekExpense;
  final int thisMonthExpense;
  final int lastMonthExpense;
  final int totalSavings;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.todayExpense = 0,
    this.yesterdayExpense = 0,
    this.thisWeekExpense = 0,
    this.lastWeekExpense = 0,
    this.thisMonthExpense = 0,
    this.lastMonthExpense = 0,
    this.totalSavings = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  // 昨日との比較パーセンテージ
  double get yesterdayComparison {
    if (yesterdayExpense == 0) return todayExpense > 0 ? 100.0 : 0.0;
    return ((todayExpense - yesterdayExpense) / yesterdayExpense) * 100;
  }

  // 先週との比較パーセンテージ
  double get lastWeekComparison {
    if (lastWeekExpense == 0) return thisWeekExpense > 0 ? 100.0 : 0.0;
    return ((thisWeekExpense - lastWeekExpense) / lastWeekExpense) * 100;
  }

  // 先月との比較パーセンテージ
  double get lastMonthComparison {
    if (lastMonthExpense == 0) return thisMonthExpense > 0 ? 100.0 : 0.0;
    return ((thisMonthExpense - lastMonthExpense) / lastMonthExpense) * 100;
  }

  HomeState copyWith({
    int? todayExpense,
    int? yesterdayExpense,
    int? thisWeekExpense,
    int? lastWeekExpense,
    int? thisMonthExpense,
    int? lastMonthExpense,
    int? totalSavings,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      todayExpense: todayExpense ?? this.todayExpense,
      yesterdayExpense: yesterdayExpense ?? this.yesterdayExpense,
      thisWeekExpense: thisWeekExpense ?? this.thisWeekExpense,
      lastWeekExpense: lastWeekExpense ?? this.lastWeekExpense,
      thisMonthExpense: thisMonthExpense ?? this.thisMonthExpense,
      lastMonthExpense: lastMonthExpense ?? this.lastMonthExpense,
      totalSavings: totalSavings ?? this.totalSavings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}