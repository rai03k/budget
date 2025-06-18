import 'dart:io';

import 'package:budget/common/routes/app_routes.dart';
import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_blur_dialog.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/data/local/app_database.dart';
import 'package:budget/views/input/input_state.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:budget/views/input/widget/calendar_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class InputPage extends ConsumerStatefulWidget {
  const InputPage({super.key});

  @override
  ConsumerState<InputPage> createState() => _InputPageState();
}

class _InputPageState extends ConsumerState<InputPage> {
  String? _categoryError;
  late int _selectedCategory = -1;

  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(inputViewModelProvider.notifier);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (!_isAtBottom) {
        setState(() {
          _isAtBottom = true;
        });
      }
    } else {
      // 一番下から離れた場合
      if (_isAtBottom) {
        setState(() {
          _isAtBottom = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(inputViewModelProvider);

    final viewModel = ref.watch(inputViewModelProvider.notifier);

    return asyncState.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('エラーが発生しました'),
      data: (state) {
        return CommonScaffold(
          appBar: CommonAppBar(
            title: '支出入力',
          ),
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildLabel('日付'),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: _buildDateField(
                                      viewModel, context, state.selectedDate)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              _buildLabel('支出'),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: _buildAmountField(viewModel),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              _buildLabel('内容'),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: _buildTitleField(viewModel),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildLabel('カテゴリー'),
                          if (_categoryError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _categoryError!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                          const SizedBox(height: 8),
                          _buildCategoryChips(viewModel, state.categories),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: [
                          _buildScanButton(viewModel),
                          const SizedBox(width: 16),
                          Expanded(child: _buildSaveButton(viewModel)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16,
      ),
    );
  }

  Widget _buildDateField(
    InputViewModel viewModel,
    BuildContext context,
    DateTime selectedDate,
  ) {
    return GestureDetector(
      onTap: () async {
        _showCalendarBottomSheet(viewModel, selectedDate);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          DateFormat('yyyy年M月d日 (E)', 'ja_JP').format(selectedDate),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showCalendarBottomSheet(
      InputViewModel viewModel, DateTime selectedDate) async {
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CalendarBottomSheet(
          initialDate: selectedDate,
        );
      },
    );

    if (picked != null) {
      viewModel.setSelectedDate(picked);
    }
  }

  Widget _buildAmountField(InputViewModel viewModel) {
    final double fontSize = 16;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: fontSize,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '入力必須項目です';
          }
          if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
            return '正しい金額を入力してください';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: _commonInputDecoration(
            hintText: '0', fillColor: Theme.of(context).colorScheme.primary),
        onChanged: (v) {
          viewModel.setAmount(v);
        },
      ),
    );
  }

  Widget _buildTitleField(InputViewModel viewModel) {
    final double fontSize = 16;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: fontSize,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '入力必須項目です';
          }
          return null;
        },
        decoration: _commonInputDecoration(
            hintText: '購入したもの',
            fillColor: Theme.of(context).colorScheme.primary),
        onChanged: (v) {
          viewModel.setItemName(v);
        },
      ),
    );
  }

  Widget _buildCategoryChips(
      InputViewModel viewModel, List<Category> categories) {
    return AbsorbPointer(
      absorbing: false,
      child: Wrap(
        spacing: 10,
        runSpacing: 2,
        children: categories.map((category) {
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
            selectedColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide.none,
            onSelected: (isSelected) {
              setState(() {
                _selectedCategory = category.id;
                viewModel.setSelectedCategory(category);
              });
            },
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            showCheckmark: true,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSaveButton(InputViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          // MaterialStateProperty を使用して状態に応じたスタイルを設定
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              // MaterialState.disabled は onPressed が null の場合に true になる
              if (states.contains(MaterialState.disabled)) {
                // isFormValid が false のため非活性化されている状態
                return Theme.of(context).colorScheme.secondary; // 非活性時の背景色
              }
              // 上記以外（活性状態）
              return _isAtBottom
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.7); // 活性時の背景色
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            // テキストの色。保存中のインジケータの色は child で直接指定。
            if (states.contains(MaterialState.disabled)) {
              return Theme.of(context).colorScheme.primary; // 非活性時（入力未完了）の文字色
            }
            return Theme.of(context)
                .colorScheme
                .primary; // 活性時または保存中（インジケータは白前提）の文字色
          }),
        ),
        onPressed: () async {
          final isCategorySelected = _selectedCategory >= 0;
          final formValid = _formKey.currentState!.validate();

          setState(() {
            _categoryError = isCategorySelected ? null : 'カテゴリを選択してください';
          });

          if (formValid && isCategorySelected) {
            final ret = await viewModel.saveTransaction();
            if (ret == 'success') {
              CommonBlurDialog.showSuccess(context);
            } else {
              CommonBlurDialog.showError(context);
            }
          }
        },
        child: const Text(
          '保存',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color プロパティは ElevatedButton.styleFrom の foregroundColor で制御される
          ),
        ),
      ),
    );
  }

  Widget _buildScanButton(InputViewModel viewModel) {
    return SizedBox(
      width: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary, // 枠線の色
              width: 1,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            // MaterialStateProperty を使用して状態に応じたスタイルを設定
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                // MaterialState.disabled は onPressed が null の場合に true になる
                if (states.contains(MaterialState.disabled)) {
                  // isFormValid が false のため非活性化されている状態
                  return Theme.of(context).colorScheme.secondary; // 非活性時の背景色
                }
                // 上記以外（活性状態）
                return _isAtBottom
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7); // 活性時の背景色
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              // テキストの色。保存中のインジケータの色は child で直接指定。
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.primary; // 非活性時（入力未完了）の文字色
              }
              return Theme.of(context)
                  .colorScheme
                  .primary; // 活性時または保存中（インジケータは白前提）の文字色
            }),
          ),
          onPressed: () async {
            context.pushNamed(AppRoutes.recipeScanner);
          },
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCamera01,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 26,
          )),
    );
  }

  InputDecoration _commonInputDecoration({
    required String hintText,
    required Color fillColor,
    double borderRadius = 10.0, // デフォルトの角丸の半径
  }) {
    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontSize: 16,
      ),
      contentPadding: EdgeInsets.all(16),
      // 各ボーダーの状態を共通化
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
    );
  }
}
