import 'package:flutter/material.dart';

/// カテゴリー詳細画面
///
/// 各予算カテゴリーの詳細情報を表示するページ
class CategoryDetailPage extends StatelessWidget {
  /// カテゴリー名
  final String categoryName;

  /// カテゴリーアイコン
  final IconData icon;

  /// アイコンの色
  final Color iconColor;

  /// 予算使用率（0.0〜1.0）
  final double progress;

  /// プログレスバーの色
  final Color progressColor;

  /// 残額または超過額の表示テキスト
  final String remainingAmount;

  const CategoryDetailPage({
    super.key,
    required this.categoryName,
    required this.icon,
    required this.iconColor,
    required this.progress,
    required this.progressColor,
    required this.remainingAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 本文
      body: Column(
        children: [
          // ヘッダー部分
          _buildHeader(),
          // コンテンツ部分
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  /// ヘッダー部分を構築するメソッド
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          // カテゴリーアイコンと名前
          Row(
            children: [
              // アイコン
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              // カテゴリー名
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // プログレスバー
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          // 残額情報
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 残額表示
              Text(
                remainingAmount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: progress > 0.7 ? Colors.red : Colors.black87,
                ),
              ),
              // 使用率表示
              Text(
                '${(progress * 100).toInt()}% 使用済み',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// コンテンツ部分を構築するメソッド
  Widget _buildContent() {
    // ダミーの取引データ
    final transactions = [
      _Transaction(
        title: 'スーパーマーケット',
        amount: '¥1,200',
        date: '今日',
        icon: Icons.shopping_basket,
      ),
      _Transaction(
        title: 'レストラン',
        amount: '¥3,500',
        date: '昨日',
        icon: Icons.restaurant,
      ),
      _Transaction(
        title: 'コンビニ',
        amount: '¥560',
        date: '3日前',
        icon: Icons.store,
      ),
      _Transaction(
        title: 'カフェ',
        amount: '¥480',
        date: '先週',
        icon: Icons.coffee,
      ),
      _Transaction(
        title: 'オンラインショッピング',
        amount: '¥2,400',
        date: '先週',
        icon: Icons.shopping_cart,
      ),
    ];

    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // セクションタイトル
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text(
              '最近の取引',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // 取引リスト
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: iconColor.withOpacity(0.1),
                    child: Icon(transaction.icon, color: iconColor, size: 20),
                  ),
                  title: Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    transaction.date,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    transaction.amount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 取引データのモデルクラス
class _Transaction {
  final String title;
  final String amount;
  final String date;
  final IconData icon;

  _Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
  });
}
