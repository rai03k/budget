import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    // 取引データの変更を監視してホーム画面を自動更新
    ref.listen(homeViewModelProvider, (previous, next) {
      // エラー状態でrefreshボタンが押された時の処理は既に実装済み
    });
    return CommonScaffold(
      appBar: CommonAppBar(title: 'ホーム'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 先週の支出を見直すバナー
                _buildWeeklyExpenseReview(context),
                const SizedBox(height: 24),

                // 支出データの表示
                homeState.when(
                  data: (state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 最近の支出セクション
                      Text(
                        '最近の支出',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 今日の支出カード
                      _buildExpenseCard(
                        context: context,
                        title: '今日の支出',
                        amount:
                            NumberFormat('#,###').format(state.todayExpense),
                        comparison:
                            '昨日 ¥${NumberFormat('#,###').format(state.yesterdayExpense)}',
                        percentage: state.yesterdayComparison,
                      ),
                      const SizedBox(height: 16),

                      // 今週の支出カード
                      _buildExpenseCard(
                        context: context,
                        title: '今週の支出',
                        amount:
                            NumberFormat('#,###').format(state.thisWeekExpense),
                        comparison:
                            '先週 ¥${NumberFormat('#,###').format(state.lastWeekExpense)}',
                        percentage: state.lastWeekComparison,
                      ),
                      const SizedBox(height: 16),

                      // 今月の支出カード
                      _buildExpenseCard(
                        context: context,
                        title: '今月の支出',
                        amount: NumberFormat('#,###')
                            .format(state.thisMonthExpense),
                        comparison:
                            '先月 ¥${NumberFormat('#,###').format(state.lastMonthExpense)}',
                        percentage: state.lastMonthComparison,
                      ),
                    ],
                  ),
                  loading: () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSavingsCard(context: context, savings: '---'),
                      const SizedBox(height: 24),
                      Text(
                        '最近の支出',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // ローディング状態でも基本レイアウトを維持
                      _buildLoadingExpenseCard(context, '今日の支出'),
                      const SizedBox(height: 16),
                      _buildLoadingExpenseCard(context, '今週の支出'),
                      const SizedBox(height: 16),
                      _buildLoadingExpenseCard(context, '今月の支出'),
                    ],
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('データの読み込みに失敗しました'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => homeViewModel.refresh(),
                          child: const Text('再読み込み'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSavingsCard(
      {required BuildContext context, required String savings}) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '今までの節約額',
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¥ $savings',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard({
    required BuildContext context,
    required String title,
    required String amount,
    required String comparison,
    required double percentage,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  getComparisonText(percentage),
                  style: TextStyle(
                    fontSize: 16,
                    color: _getComparisonColor(
                        context, getComparisonType(percentage)),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  _getComparisonIcon(getComparisonType(percentage)),
                  size: 20,
                  color: _getComparisonColor(
                      context, getComparisonType(percentage)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¥ $amount',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              comparison,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyExpenseReview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.go('/weekly-review');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none, // 子が親の境界からはみ出すのを許可
                children: [
                  HugeIcon(
                    // メールアイコン
                    icon: HugeIcons.strokeRoundedMail01,
                    color: colorScheme.onPrimary,
                  ),
                  // 赤い丸をアイコンの右上に配置
                  Positioned(
                    right: -4,
                    top: -2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '先週の支出を見直そう！',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 比較タイプに基づいてアイコンを取得
  IconData _getComparisonIcon(ComparisonType type) {
    switch (type) {
      case ComparisonType.increase:
        return Icons.trending_up;
      case ComparisonType.decrease:
        return Icons.trending_down;
      case ComparisonType.same:
        return Icons.trending_flat;
    }
  }

  /// 比較タイプに基づいて色を取得
  Color _getComparisonColor(BuildContext context, ComparisonType type) {
    switch (type) {
      case ComparisonType.increase:
        return Colors.red; // 支出増加は赤
      case ComparisonType.decrease:
        return Colors.green; // 支出減少は緑
      case ComparisonType.same:
        return Theme.of(context).colorScheme.onPrimary;
    }
  }

  /// ローディング中の支出カード
  Widget _buildLoadingExpenseCard(BuildContext context, String title) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¥ ---',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '読み込み中...',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ArrowDialog(
          child: Container(
            width: 280,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.help, color: Colors.blue, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'ヘルプ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'このアプリの使い方：',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                _buildHelpItem('1. ボタンをタップして操作を開始'),
                _buildHelpItem('2. 設定画面で好みに合わせてカスタマイズ'),
                _buildHelpItem('3. 困ったときはこのヘルプを参照'),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, size: 16, color: Colors.grey[600]),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowDialog extends StatelessWidget {
  final Widget child;

  const ArrowDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // メインのダイアログボックス
          Container(
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
          // 矢印部分
          Positioned(
            top: 0,
            left: 20,
            child: CustomPaint(
              size: Size(24, 12),
              painter: ArrowPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // 影の矢印
    final shadowPath = Path();
    shadowPath.moveTo(size.width / 2 + 1, 1);
    shadowPath.lineTo(0 + 1, size.height + 1);
    shadowPath.lineTo(size.width + 1, size.height + 1);
    shadowPath.close();
    canvas.drawPath(shadowPath, shadowPaint);

    // メインの矢印
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
