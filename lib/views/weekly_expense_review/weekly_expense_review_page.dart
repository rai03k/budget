import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'weekly_expense_review_view_model.dart';

class WeeklyExpenseReviewPage extends ConsumerWidget {
  const WeeklyExpenseReviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(weeklyExpenseReviewViewModelProvider);
    final viewModel = ref.read(weeklyExpenseReviewViewModelProvider.notifier);

    // 全項目スワイプ後に自動遷移（GoRouterを使用）
    ref.listen(weeklyExpenseReviewViewModelProvider, (prev, next) {
      next.whenData((state) {
        if (state.isAllItemsDismissed && 
            (prev?.value?.isAllItemsDismissed != true)) {
          context.go(
            '/savings',
            extra: {
              'totalSavings': state.dismissedTotal.toDouble(),
              'emojis': state.dismissedEmojis,
            },
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              '本当に必要だった？',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '不要なら左、必要なら右にスワイプ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: asyncState.when(
                data: (state) => ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    if (item.isDismissed) return const SizedBox.shrink();

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Dismissible(
                      key: Key('expense_item_?$index'),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.only(left: 32),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 32),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.only(right: 32),
                        child: const Icon(Icons.delete,
                            color: Colors.white, size: 32),
                      ),
                      onDismissed: (direction) {
                        // 左スワイプ（不要）だけ記録
                        if (direction == DismissDirection.endToStart) {
                          viewModel.dismissItem(index);
                        } else {
                          // 必要なら何もしない or 別の処理
                          viewModel.dismissItem(index); // 必要なら右スワイプも同じ処理
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF363638),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                item.emoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat('yyyy/MM/dd(E)', 'ja').format(item.date),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                          trailing: Text(
                            '${NumberFormat('#,###').format(item.amount)} 円',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'エラーが発生しました: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
