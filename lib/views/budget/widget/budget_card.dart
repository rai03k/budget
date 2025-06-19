import 'package:budget/common/widget/common_category_icon.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/views/budget/budget_state.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetCard extends ConsumerStatefulWidget {
  final CategoryState categoryState;
  final DateTime monthDate;
  final bool isEditing;
  final Function(int categoryId, int budgetAmount)? onBudgetInputChanged;

  const BudgetCard({
    super.key,
    required this.categoryState,
    required this.monthDate,
    this.isEditing = false,
    this.onBudgetInputChanged,
  });

  @override
  ConsumerState<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends ConsumerState<BudgetCard> {
  late TextEditingController _budgetController;
  Map<String, int>? _budgetData;

  @override
  void initState() {
    super.initState();
    _budgetController = TextEditingController();
    _loadBudgetData();
  }

  Future<void> _loadBudgetData() async {
    final budgetViewModel = ref.read(budgetViewModelProvider.notifier);
    final data = await budgetViewModel.getBudgetAndSpentForCategory(
      widget.categoryState.id,
      widget.monthDate,
    );

    if (mounted) {
      setState(() {
        _budgetData = data;
        // TextFieldに現在の予算額を設定
        _budgetController.text =
            data['budget'] == 0 ? '' : data['budget'].toString();
      });
    }
  }

  @override
  void didUpdateWidget(BudgetCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 月が変わった場合はデータを再読み込み
    if (oldWidget.monthDate != widget.monthDate) {
      _loadBudgetData();
    }
    // 編集モードが終了した場合もデータを再読み込み
    if (oldWidget.isEditing && !widget.isEditing) {
      _loadBudgetData();
    }
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  /// 進捗率を計算（0.0-1.0、超過時は1.0）
  double _calculateProgress() {
    if (_budgetData == null) return 0.0;

    final budget = _budgetData!['budget']!;
    final spent = _budgetData!['spent']!;

    if (budget == 0) return 0.0;

    final progress = spent / budget;
    return progress > 1.0 ? 1.0 : progress;
  }

  /// 進捗バーの色を取得（常にカテゴリー色）
  Color _getProgressColor() {
    return widget.categoryState.color.color(context);
  }

  /// 使用量テキストを取得
  String _getUsageText() {
    if (_budgetData == null) return '読み込み中...';

    final budget = _budgetData!['budget']!;
    final spent = _budgetData!['spent']!;

    if (budget == 0) {
      return spent == 0 ? '予算未設定' : '¥${spent}使用';
    }

    if (spent > budget) {
      final excess = spent - budget;
      return '¥${excess}超え';
    } else {
      final remaining = budget - spent;
      return '残り¥${remaining}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // BudgetViewModelの変更を監視してリアルタイム更新
    ref.listen<AsyncValue<BudgetPageState>>(budgetViewModelProvider,
        (previous, next) {
      if (next.hasValue && previous?.hasValue == true) {
        // データが更新された場合は予算データを再読み込み
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _loadBudgetData();
          }
        });
      }
    });

    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CommonCategoryIcon(
                  color: widget.categoryState.color.color(context),
                  icon: widget.categoryState.icon.iconData),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.categoryState.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              // if (isEditing)
              //   SizedBox(
              //     width: 120,
              //     height: 40,
              //     child: TextField(
              //       controller: TextEditingController(text: 'a'),
              //       style: const TextStyle(color: Colors.white),
              //       textAlign: TextAlign.right,
              //       decoration: const InputDecoration(
              //         hintText: '予算を入力',
              //         hintStyle: TextStyle(color: Colors.grey),
              //         enabledBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.grey),
              //         ),
              //         focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.white),
              //         ),
              //         suffixText: '円',
              //         suffixStyle: TextStyle(color: Colors.grey),
              //         contentPadding: EdgeInsets.only(bottom: 8),
              //       ),
              //       // onChanged: (value) =>
              //       //     viewModel.updateBudget(index, value),
              //       keyboardType: TextInputType.number,
              //     ),
              //   )
              // else
              widget.isEditing
                  ? SizedBox(
                      width: 120,
                      height: 40,
                      child: TextField(
                        controller: _budgetController,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '予算を入力',
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          suffixText: '円',
                          suffixStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 8),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // 値が変更されたら親に通知
                          final budgetAmount = int.tryParse(value);
                          if (budgetAmount != null && budgetAmount > 0) {
                            widget.onBudgetInputChanged?.call(
                              widget.categoryState.id,
                              budgetAmount,
                            );
                          }
                        },
                      ),
                    )
                  : Expanded(
                      child: _budgetData == null
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: _calculateProgress(),
                                      backgroundColor: const Color(0xFFD5D7DA),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getProgressColor(),
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getUsageText(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
