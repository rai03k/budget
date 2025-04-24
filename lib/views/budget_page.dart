import 'package:flutter/material.dart';
import 'package:budget/views/category_detail_page.dart';

/// 予算管理画面
///
/// カテゴリー別の予算使用状況を一覧表示するページ
class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 食費カテゴリー
            _buildCategoryCard(
              context: context,
              icon: Icons.fastfood,
              iconColor: Colors.red,
              categoryName: '食費',
              progress: 0.8, // 予算使用率80%
              progressColor: Colors.red,
              remainingAmount: '¥50,000 残り',
            ),
            const SizedBox(height: 8),
            // 日用品カテゴリー
            _buildCategoryCard(
              context: context,
              icon: Icons.cleaning_services,
              iconColor: Colors.orange,
              categoryName: '日用品',
              progress: 0.6, // 予算使用率60%
              progressColor: Colors.orange,
              remainingAmount: '¥500 超え',
            ),
            const SizedBox(height: 8),
            // 衣類カテゴリー
            _buildCategoryCard(
              context: context,
              icon: Icons.checkroom,
              iconColor: Colors.blue,
              categoryName: '衣類',
              progress: 0.4, // 予算使用率40%
              progressColor: Colors.blue,
              remainingAmount: '¥500 超え',
            ),
            const SizedBox(height: 8),
            // デート代カテゴリー
            _buildCategoryCard(
              context: context,
              icon: Icons.favorite,
              iconColor: Colors.pink,
              categoryName: 'デート代',
              progress: 0.6, // 予算使用率60%
              progressColor: Colors.pink,
              remainingAmount: '¥500 超え',
            ),
            const SizedBox(height: 8),
            // 交通費カテゴリー
            _buildCategoryCard(
              context: context,
              icon: Icons.directions_bus,
              iconColor: Colors.amber,
              categoryName: '交通費',
              progress: 0.2, // 予算使用率20%
              progressColor: Colors.grey,
              remainingAmount: '¥???',
            ),
          ],
        ),
      ),
    );
  }

  /// 予算カテゴリーカードを構築するメソッド
  ///
  /// [context] - ビルドコンテキスト
  /// [icon] - カテゴリーを表すアイコン
  /// [iconColor] - アイコンの色
  /// [categoryName] - カテゴリー名
  /// [progress] - 予算使用率（0.0〜1.0）
  /// [progressColor] - プログレスバーの色
  /// [remainingAmount] - 残額または超過額の表示テキスト
  Widget _buildCategoryCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String categoryName,
    required double progress,
    required Color progressColor,
    required String remainingAmount,
  }) {
    return GestureDetector(
      // タップ時の処理
      onTap: () {
        // カテゴリー詳細画面に遷移
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => CategoryDetailPage(
                  categoryName: categoryName,
                  icon: icon,
                  iconColor: iconColor,
                  progress: progress,
                  progressColor: progressColor,
                  remainingAmount: remainingAmount,
                ),
          ),
        );
      },
      child: Container(
        // カードのスタイル設定
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: [
              // カテゴリーアイコン
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              // カテゴリー名
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              // 予算使用状況の表示
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // プログレスバー
                  SizedBox(
                    width: 100,
                    height: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progressColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // 残額表示
                  Text(
                    remainingAmount,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // 詳細表示用の矢印アイコン
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
