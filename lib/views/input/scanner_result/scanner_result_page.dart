import 'package:budget/common/routes/app_routes.dart';
import 'package:budget/common/widget/common_blur_dialog.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/util/format_number.dart';
import 'package:budget/views/input/scanner_result/scanner_result_view_model.dart';
import 'package:budget/views/input/scanner_result/widget/list_item_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannerResultPage extends ConsumerWidget {
  const ScannerResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(scannerResultViewModelProvider.notifier);

    return CommonScaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "スキャン結果",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          leading: IconButton(
              onPressed: () {
                ref.read(transactionProvider.notifier).clearScannedData();

                context.goNamed(AppRoutes.recipeScanner);
              },
              icon: Icon(Icons.arrow_back_ios, size: 24)),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 28),
              onPressed: () async {
                final success = await viewModel.saveAllTransactions();
                if (!context.mounted) return;

                if (success) {
                  await CommonBlurDialog.showSuccess(context);
                  if (!context.mounted) return;
                  context.goNamed(
                    AppRoutes.input,
                    extra: 'from_scanner',
                  );
                } else {
                  await CommonBlurDialog.showError(context);
                }
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: _buildBody(context, ref, viewModel));
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, ScannerResultViewModel viewModel) {
    // カテゴリー情報を含むViewModelの状態を監視する
    // buildがasyncになったため、AsyncValueでラップされている
    final asyncScannerResultState = ref.watch(scannerResultViewModelProvider);

    // トランザクション情報（スキャンされたアイテムリスト）を監視する
    // こちらは以前のコードから流用
    final scannedData = ref
        .watch(transactionProvider.select((s) => s.value?.first.scannedData));
    final items = scannedData?.items ?? [];
    final totalPrice = items.map((item) => item.price).fold(0, (a, b) => a + b);

    // AsyncValueのwhenを使って、状態（データ有り、ローディング中、エラー）に応じてUIを分岐する
    return asyncScannerResultState.when(
      // -----------------------------------------
      // ⏳ ローディング中のUI
      // -----------------------------------------
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      // -----------------------------------------
      // ❌ エラー発生時のUI
      // -----------------------------------------
      error: (error, stackTrace) {
        return Center(
          child: Text(
            'カテゴリーの読み込みに失敗しました: $error',
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
      // -----------------------------------------
      // ✅ データ取得成功時のUI
      // -----------------------------------------
      data: (scannerResultState) {
        // stateからカテゴリーリストを取得
        final categories = scannerResultState.categories;

        // ユーザーから提供された元のUIコードをここに配置
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return AnimatedListItem(
                    key: ValueKey(item.id),
                    index: index,
                    child: ListItemResult(
                      date: scannedData?.date ?? DateTime.now().toString(),
                      item: item,
                      index: index,
                      // 成功して取得したカテゴリー情報を渡す
                      categories: categories,
                      onUpdate: (updatedItem) {
                        // viewModelの参照は以前のままでOK
                        viewModel.updateTransaction(updatedItem);
                      },
                    ),
                  );
                },
              ),
            ),
            _buildTotalFooter(totalPrice),
          ],
        );
      },
    );
  }

  // 合計金額フッター
  Widget _buildTotalFooter(int totalPrice) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                  width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "合計金額",
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                // 親のRowの幅に合わせるためにExpandedでラップ
                child: FittedBox(
                  fit: BoxFit.scaleDown, // テキストが小さくなるように調整
                  alignment: Alignment.centerRight, // 右寄せにする
                  child: Text(
                    "¥ ${FormatNumber.format(totalPrice)}",
                    style: GoogleFonts.poppins(
                      fontSize: 28, // 基本となるフォントサイズ
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5);
    });
  }
}

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

// 1. with AutomaticKeepAliveClientMixin を追加
class _AnimatedListItemState extends State<AnimatedListItem>
    with AutomaticKeepAliveClientMixin {
  // 2. wantKeepAlive を override して true を返す
  //    これにより、Stateが破棄されなくなります。
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // 3. super.build(context) を呼び出すことが推奨されています。
    super.build(context);

    // アニメーションのコードは変更なし
    return widget.child
        .animate(delay: (80 * widget.index).ms)
        .fadeIn(duration: 500.ms)
        .slideX(begin: -0.2, curve: Curves.easeOutCubic);
  }
}
