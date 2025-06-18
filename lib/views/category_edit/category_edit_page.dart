import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_blur_dialog.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/views/category_edit/category_edit_view_model.dart';
import 'package:budget/views/category_edit/category_list_view_model.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/enum/app_colors.dart';
import '../../common/enum/app_icon.dart';
import '../../common/widget/category_edit_form.dart';

class CategoryEditPage extends ConsumerWidget {
  CategoryEditPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(categoryEditViewModelProvider.notifier).getCategory();
    final viewModel = ref.read(categoryEditViewModelProvider.notifier);

    return CommonScaffold(
      appBar: CommonAppBar(
        title: 'カテゴリー編集',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: CategoryEditForm(
            categoryName: state.categoryName,
            selectedColor: state.selectedColor.index,
            selectedIcon: state.selectedIcon.index,
            onNameChanged: viewModel.updateCategoryName,
            onColorChanged: viewModel.selectColor,
            onIconChanged: viewModel.selectIcon,
            onSave: () async {
              if (_formKey.currentState!.validate()) {
                final ret = await viewModel.saveCategory();
                if (ret == 'success') {
                  await CommonBlurDialog.showSuccess(context);
                  ref.invalidate(categoryListViewModelProvider);
                  ref.invalidate(inputViewModelProvider);
                } else {
                  await CommonBlurDialog.showError(context, message: ret);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
