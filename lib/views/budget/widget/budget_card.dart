import 'package:budget/common/widget/common_category_icon.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              CommonCategoryIcon(color: Colors.red, icon: Icons.abc),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'テスト',
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
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 3,
                          //category.budget?.budgetAmount?.toDouble() ?? 0,
                          backgroundColor: const Color(0xFFD5D7DA),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                          minHeight: 6, // プログレスバーの高さを6ピクセルに設定（太さを調整）
                        ),
                      ),
                      const SizedBox(height: 4),
                      // 使用量
                      Text(
                        '使用料',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
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
