import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/widget/common_category_icon.dart';
import 'package:budget/data/local/app_database.dart';
import 'package:budget/model/dto/category_dto.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:budget/util/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListItemResult extends StatefulWidget {
  final String date;
  final ReceiptItem item;
  final int index;
  final List<Category> categories;
  final Function(ReceiptItem updatedItem) onUpdate;

  const ListItemResult({
    super.key,
    required this.date,
    required this.item,
    required this.index,
    required this.categories,
    required this.onUpdate,
  });

  @override
  State<ListItemResult> createState() => _ListItemResultState();
}

class _ListItemResultState extends State<ListItemResult> {
  @override
  Widget build(BuildContext context) {
    return _buildListItem(widget.item, widget.index);
  }

  void _removeItem(int index) {
    setState(() {});
  }

  late int _selectedCategory = widget.item.categoryDto?.id ?? -1;

  // リストの各項目
  Widget _buildListItem(ReceiptItem item, int index) {
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25, // スライド領域を少し狭く
        children: [
          CustomSlidableAction(
            onPressed: (ctx) => _removeItem(index),
            backgroundColor: const Color(0xFFFE453A),
            foregroundColor: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Icon(
              Icons.delete,
              size: 35,
            ),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: ListTile(
          onTap: () => _showEditSheet(context),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary, // アイコン背景
              borderRadius: BorderRadius.circular(12),
            ),
            child: CommonCategoryIcon(
                color: item.categoryDto?.iconColor?.color(context),
                icon: item.categoryDto?.icon?.iconData),
          ),
          title: Text(
            item.name,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            DateFormat('yyyy年MM月dd日').format(DateTime.parse(widget.date)),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              "¥${FormatNumber.format(item.price)}",
              style: GoogleFonts.robotoMono(
                  // 金額表示に適したフォント
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext context) {
    final item = widget.item;
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  left: 24,
                  right: 24,
                  top: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- タイトル ---
                    Text(
                      "項目の編集",
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 24),

                    // --- 横並びの編集フォーム ---
                    _buildEditableRow(
                        context: context,
                        title: "商品名",
                        widget: _buildTextField(controller: nameController)),
                    const SizedBox(height: 16),
                    _buildEditableRow(
                        context: context,
                        title: "金額",
                        widget: _buildTextField(
                            controller: priceController,
                            keyboardType: TextInputType.number)),
                    const SizedBox(height: 24),

                    // --- カテゴリ選択チップ ---
                    Text("カテゴリ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 2,
                      children: widget.categories.map((category) {
                        // ★ 変更点③: Stateの変数ではなく、一時変数で選択状態を判断
                        final selected = _selectedCategory == category.id;
                        return ChoiceChip(
                          label: Text(
                            category.categoryName,
                            style: TextStyle(
                              color: selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          selected: selected,
                          selectedColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          side: BorderSide.none,
                          onSelected: (isSelected) {
                            // ★★★★★ これが最も重要な変更点 ★★★★★
                            // 親の`setState`ではなく、StatefulBuilderの`setModalState`を呼ぶ
                            setModalState(() {
                              if (isSelected) {
                                _selectedCategory = category.id;
                              }
                            });
                          },
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    // --- 保存ボタン ---
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        final selectedCategoryObject =
                            widget.categories.firstWhere(
                          (cat) => cat.id == _selectedCategory,
                          orElse: () => widget.categories.first, // デフォルトで最初のカテゴリを選択
                        );

                        final updatedItem = widget.item.copyWith(
                          name: nameController.text,
                          price: int.tryParse(priceController.text) ??
                              widget.item.price,
                          categoryDto:
                              CategoryDto.fromEntity(selectedCategoryObject),
                        );

                        // 親ウィジェットに更新を通知
                        await widget.onUpdate(updatedItem);
                        Navigator.of(context).pop();
                      },
                      child: const Text("変更を保存"),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- 編集モーダル用のヘルパーウィジェット ---
  Widget _buildEditableRow(
      {required BuildContext context,
      required String title,
      required Widget widget}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80, // ラベルの幅を固定
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: widget),
      ],
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      TextInputType? keyboardType}) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
