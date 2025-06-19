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
  bool _isEditing = false;
  
  // 無限スクロール用の大きな初期値
  static const int _initialPage = 10000;
  int _currentPageIndex = _initialPage;
  
  // 編集中の予算データを一時保存
  Map<int, int> _pendingBudgets = {};

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime(_currentDate.year, _currentDate.month, 1);
    _pageController = PageController(initialPage: _initialPage);
  }

  String _formatMonth(DateTime date) {
    return '${date.year}年${date.month}月';
  }

  void _goToPreviousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
      // ページインデックスの差分から現在の月を計算
      final monthDiff = pageIndex - _initialPage;
      final now = DateTime.now();
      final baseDate = DateTime(now.year, now.month, 1);
      
      // 月の加算・減算を正しく処理
      DateTime newDate = baseDate;
      if (monthDiff > 0) {
        // 未来の月
        for (int i = 0; i < monthDiff; i++) {
          if (newDate.month == 12) {
            newDate = DateTime(newDate.year + 1, 1, 1);
          } else {
            newDate = DateTime(newDate.year, newDate.month + 1, 1);
          }
        }
      } else if (monthDiff < 0) {
        // 過去の月
        for (int i = 0; i < -monthDiff; i++) {
          if (newDate.month == 1) {
            newDate = DateTime(newDate.year - 1, 12, 1);
          } else {
            newDate = DateTime(newDate.year, newDate.month - 1, 1);
          }
        }
      }
      
      _currentDate = newDate;
    });
    print('選択された年月: ${_formatMonth(_currentDate)}');
  }

  /// すべての予算を保存
  Future<void> _saveBudgets() async {
    final budgetViewModel = ref.read(budgetViewModelProvider.notifier);
    
    try {
      final saveCount = _pendingBudgets.length;
      
      // 編集中の予算データを一括保存
      for (final entry in _pendingBudgets.entries) {
        final categoryId = entry.key;
        final budgetAmount = entry.value;
        
        await budgetViewModel.saveBudget(
          categoryId: categoryId,
          budgetAmount: budgetAmount,
          month: _currentDate,
        );
      }
      
      // 一時保存データをクリア
      _pendingBudgets.clear();
      
      // データを再読み込み
      await budgetViewModel.refresh();
      
      // 保存完了メッセージを表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${saveCount}件の予算を保存し、未来の月に引き継ぎました'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('予算保存エラー: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('予算の保存に失敗しました'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        title: '予算比',
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () async {
              if (_isEditing) {
                // 編集完了時：すべての予算を保存
                await _saveBudgets();
                // 編集モードを終了してリアルタイム更新をトリガー
                setState(() {
                  _isEditing = false;
                });
              } else {
                // 編集開始
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 上部の年月表示とナビゲーションボタン
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左ボタン
                GestureDetector(
                  onTap: _goToPreviousMonth,
                  child: Icon(
                    Icons.arrow_back_ios_new,
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
                  onTap: _goToNextMonth,
                  child: Icon(
                    Icons.arrow_forward_ios,
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
              itemBuilder: (context, index) {
                // ページインデックスから月を計算
                final monthDiff = index - _initialPage;
                final now = DateTime.now();
                final baseDate = DateTime(now.year, now.month, 1);
                
                DateTime pageDate = baseDate;
                if (monthDiff > 0) {
                  // 未来の月
                  for (int i = 0; i < monthDiff; i++) {
                    if (pageDate.month == 12) {
                      pageDate = DateTime(pageDate.year + 1, 1, 1);
                    } else {
                      pageDate = DateTime(pageDate.year, pageDate.month + 1, 1);
                    }
                  }
                } else if (monthDiff < 0) {
                  // 過去の月
                  for (int i = 0; i < -monthDiff; i++) {
                    if (pageDate.month == 1) {
                      pageDate = DateTime(pageDate.year - 1, 12, 1);
                    } else {
                      pageDate = DateTime(pageDate.year, pageDate.month - 1, 1);
                    }
                  }
                }
                
                return _buildMonthContent(pageDate);
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
            isEditing: _isEditing,
            onBudgetInputChanged: (categoryId, budgetAmount) {
              // 予算入力を一時保存
              _pendingBudgets[categoryId] = budgetAmount;
              print('予算入力: カテゴリ$categoryId = ¥$budgetAmount');
            },
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
