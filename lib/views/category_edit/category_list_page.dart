import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/app_icon.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/routes/app_routes.dart';
import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_blur_dialog_button.dart';
import 'package:budget/common/widget/common_category_icon.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/views/category_edit/category_edit_view_model.dart';
import 'package:budget/views/category_edit/category_list_view_model.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:budget/views/settings/setting_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // GoRouterを使用
import 'package:hugeicons/hugeicons.dart';

class CategoryListPage extends ConsumerStatefulWidget {
  const CategoryListPage({super.key});

  @override
  ConsumerState<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends ConsumerState<CategoryListPage> {
  bool _showingDelete = false;

  @override
  void initState() {
    super.initState();
    _showingDelete = false;
  }

  @override
  void dispose() {
    super.dispose();
    _showingDelete = false;
  }

  @override
  Widget build(BuildContext context) {
    final categoryListAsync = ref.watch(categoryListViewModelProvider);

    final viewModel = ref.watch(categoryListViewModelProvider.notifier);

    return CommonScaffold(
      appBar: CommonAppBar(title: "カテゴリー編集", actions: [
        TextButton(
          onPressed: () {
            if (_showingDelete) {
              viewModel.saveOrder();
            }
            setState(() {
              _showingDelete = !_showingDelete;
            });
          },
          child: Text(
            _showingDelete ? '完了' : '編集',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ]),
      body: categoryListAsync.when(
        loading: () => Container(),
        error: (error, stackTrace) => Center(child: Text('データの取得に失敗しました')),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('カテゴリーがありません'));
          }

          return ReorderableListView.builder(
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              viewModel.reorder(oldIndex, newIndex);
            },
            padding: const EdgeInsets.all(16.0), // ListView全体のパディング
            itemCount: categories.length, // カテゴリ数分アイテムを生成
            itemBuilder: (context, index) {
              final category = categories[index];
              final isFirstItem = index == 0;
              final isLastItem = index == categories.length - 1;

              // 角丸の半径
              const double borderRadiusValue = 12.0;

              // アイテムの角丸の形状を決定
              BorderRadius itemBorderRadius;
              if (isFirstItem && isLastItem) {
                // アイテムが1つしかない場合
                itemBorderRadius = BorderRadius.circular(borderRadiusValue);
              } else if (isFirstItem) {
                // リストの最初のアイテム
                itemBorderRadius = const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusValue),
                  bottom: Radius.zero,
                );
              } else if (isLastItem) {
                // リストの最後のアイテム
                itemBorderRadius = const BorderRadius.vertical(
                  top: Radius.zero,
                  bottom: Radius.circular(borderRadiusValue),
                );
              } else {
                // それ以外のアイテム (角丸なし)
                itemBorderRadius = BorderRadius.zero;
              }

              return Container(
                key: ValueKey(category.id),
                // 各ListItemContainerが独立したカードと見なされる
                margin: EdgeInsets.only(
                  bottom: isLastItem ? 0 : 1.0, // 区切り線ではなく、カード間の隙間を制御
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary, // カードの背景色
                  borderRadius: itemBorderRadius, // アイテムごとの角丸を適用
                ),
                // InkWellのリップルエフェクトが角丸からはみ出ないようにクリップ
                child: ClipRRect(
                  borderRadius: itemBorderRadius, // ここもアイテムごとの角丸を適用
                  child: InkWell(
                    onTap: () {
                      if (!_showingDelete) {
                        ref
                            .read(categoryEditViewModelProvider.notifier)
                            .setCategory(category);
                        context.pushNamed(AppRoutes.categoryEdit);
                      }
                    },
                    // タップ時のハイライト/リップルエフェクトの形状を角丸に合わせます
                    borderRadius: itemBorderRadius,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- 設定項目のコンテンツ (テキストとアイコン) ---
                        Padding(
                          padding:
                              const EdgeInsets.all(16.0), // アイテム内のコンテンツパディング
                          child: Row(
                            children: [
                              if (_showingDelete)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      CommonBlurDialogButton.showConfirm(
                                        context,
                                        message: 'このカテゴリーを削除しますか？',
                                        okButtonText: '削除',
                                        onOkPressed: () async {
                                          // 削除処理
                                          await viewModel
                                              .deleteCategory(category.id);
                                          ref.invalidate(
                                              inputViewModelProvider);
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),

                              // アイコン
                              CommonCategoryIcon(
                                icon:
                                    category.icon?.iconData ?? Icons.restaurant,
                                color: category.iconColor?.color(context) ??
                                    AppColors.red.color(context),
                              ),
                              const SizedBox(width: 12),
                              // タイトル
                              Expanded(
                                child: Text(
                                  category.categoryName ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 矢印アイコン
                              if (!_showingDelete)
                                Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.5),
                                )
                              else
                                ReorderableDragStartListener(
                                  index: index,
                                  child: Icon(
                                    Icons.drag_handle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.5),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // --- 区切り線 (リストの最後のアイテムでなければ表示) ---
                        // 各アイテムの下に区切り線を表示
                        if (!isLastItem)
                          Padding(
                            // 区切り線の左右にパディングを設けます
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 0.2, // Dividerが占める高さ（線の太さと一致させます）
                              thickness: 0.2, // 線の太さ
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary, // 線の色
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
