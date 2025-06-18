import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/app_icon.dart';
import 'package:budget/common/routes/app_routes.dart';
import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/views/settings/setting_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // GoRouterを使用
import 'package:hugeicons/hugeicons.dart';

class SettingsPage extends ConsumerWidget {
  SettingsPage({super.key});

  final List<Map<String, List<SettingType>>> settingList = [
    {
      'カテゴリー': [
        SettingType.categoryAdd,
        SettingType.categoryEdit,
      ],
    },
    {
      '支出管理': [
        SettingType.recurringExpense,
      ],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonScaffold(
      appBar: CommonAppBar(title: "設定"),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0), // ListView全体のパディング
        itemCount: settingList.length, // settingListは外部から渡される想定です
        itemBuilder: (context, index) {
          final section = settingList[index];
          final sectionTitle = section.keys.first;
          final settingTypes = section.values.first;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- セクションタイトル ---
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0, // 左パディング
                  bottom: 8.0, // 下パディング
                  top: index == 0 ? 0.0 : 32.0, // 最初のセクション以外の場合の上部マージン
                ),
                child: Text(
                  sectionTitle.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // --- 設定項目のカード ---
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary, // カードの背景色
                  borderRadius: BorderRadius.circular(12.0), // カードの角丸
                ),
                // InkWellのリップルエフェクトがカードの角丸からはみ出ないようにクリップします
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Column(
                    children: settingTypes.asMap().entries.map((entry) {
                      final itemIndex = entry.key;
                      final settingType = entry.value;
                      final isFirstItemInCard = itemIndex == 0;
                      final isLastItemInCard =
                          itemIndex == settingTypes.length - 1;

                      return InkWell(
                        onTap: () {
                          _switchSetting(context, settingType);
                        },
                        // タップ時のハイライト/リップルエフェクトの形状をカードの角丸に合わせます
                        borderRadius: BorderRadius.vertical(
                          top: isFirstItemInCard
                              ? const Radius.circular(12.0) // カード上端の角丸
                              : Radius.zero,
                          bottom: isLastItemInCard
                              ? const Radius.circular(12.0) // カード下端の角丸
                              : Radius.zero,
                        ),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Columnが必要な高さだけを占めるようにします
                          children: [
                            // --- 設定項目のコンテンツ (テキストとアイコン) ---
                            Padding(
                              padding: const EdgeInsets.all(
                                  16.0), // アイテム内のコンテンツパディング
                              child: Row(
                                children: [
                                  // タイトル
                                  Expanded(
                                    child: Text(
                                      _getSettingTitle(
                                          settingType), // _getSettingTitleは別途定義されている想定です
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ),
                                  // 矢印アイコン
                                  Icon(
                                    Icons.chevron_right,
                                    size: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                            // --- 区切り線 (カード内の最後のアイテムでなければ表示) ---
                            if (!isLastItemInCard)
                              Padding(
                                // 区切り線の左右にパディングを設けます
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  height: 0.2, // Dividerが占める高さ（線の太さと一致させます）
                                  thickness: 0.2, // 線の太さ
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary, // 線の色 (元のBorderの色)
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getSettingTitle(SettingType type) {
    switch (type) {
      case SettingType.categoryAdd:
        return 'カテゴリーを追加';
      case SettingType.categoryEdit:
        return 'カテゴリーを編集';
      case SettingType.recurringExpense:
        return '定期支出設定';
      default:
        return '';
    }
  }

  void _switchSetting(BuildContext context, SettingType type) {
    switch (type) {
      case SettingType.categoryAdd:
        // カテゴリー追加画面に遷移
        context.pushNamed(AppRoutes.categoryCreate);
        break;
      case SettingType.categoryEdit:
        // カテゴリー一覧画面に遷移
        context.pushNamed(AppRoutes.categoryList);
        break;
      case SettingType.recurringExpense:
        // 定期支出設定画面に遷移
        context.pushNamed('recurring-expense');
        break;
      default:
        break;
    }
  }
}
