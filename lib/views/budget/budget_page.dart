import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/views/budget/widget/budget_card.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:budget/views/budget/budget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class BudgetPage extends ConsumerStatefulWidget {
  const BudgetPage({super.key});

  @override
  ConsumerState<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends ConsumerState<BudgetPage> {
  PageController _pageController = PageController();
  DateTime _currentDate = DateTime.now();
  List<DateTime> _months = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateMonths();
    // 現在の月を中央に設定
    _currentIndex = _months.indexWhere((date) =>
        date.year == _currentDate.year && date.month == _currentDate.month);
    if (_currentIndex == -1) _currentIndex = 12; // デフォルトで現在月

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController = PageController(initialPage: _currentIndex);
    });
  }

  void _generateMonths() {
    // 現在から前後2年分の月を生成
    DateTime startDate = DateTime(_currentDate.year - 2, 1);
    DateTime endDate = DateTime(_currentDate.year + 2, 12);

    _months.clear();
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      _months.add(DateTime(current.year, current.month));
      current = DateTime(current.year, current.month + 1);
    }
  }

  String _formatMonth(DateTime date) {
    return '${date.year}年${date.month}月';
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentDate = _months[index];
    });

    // 現在選択されている年月を取得
    print('選択された年月: ${_formatMonth(_currentDate)}');
    print('年: ${_currentDate.year}, 月: ${_currentDate.month}');
  }

  void _goToPreviousMonth() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextMonth() {
    if (_currentIndex < _months.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        title: '予算比',
      ),
      body: Column(
        children: [
          // 上部の年月表示とナビゲーションボタン
          Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左ボタン
                GestureDetector(
                  onTap: _currentIndex > 0 ? _goToPreviousMonth : null,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),

                // 年月表示
                Expanded(
                  child: Center(
                    child: Text(
                      _formatMonth(_currentDate),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                // 右ボタン
                GestureDetector(
                  onTap: _currentIndex < _months.length - 1
                      ? _goToNextMonth
                      : null,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowRight01,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // スライド可能なコンテンツエリア
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _months.length,
              itemBuilder: (context, index) {
                return _buildMonthContent(_months[index]);
              },
            ),
          ),

          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  // 各月のコンテンツを構築
  Widget _buildMonthContent(DateTime monthDate) {
    final budgetState = ref.watch(budgetViewModelProvider);
    
    return budgetState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('データの読み込みに失敗しました'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.refresh(budgetViewModelProvider),
              child: const Text('再読み込み'),
            ),
          ],
        ),
      ),
      data: (state) => ListView.builder(
        itemCount: state.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = state.categories[index];
          return BudgetCard(
            categoryState: category,
            monthDate: monthDate,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
