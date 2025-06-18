import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/widget/common_app_bar.dart';
import 'package:budget/common/widget/common_blur_dialog.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/enum/app_colors.dart';
import '../../common/enum/app_icon.dart';
import '../../common/widget/category_edit_form.dart';
import 'category_create_view_model.dart';

class CategoryCreatePage extends ConsumerWidget {
  CategoryCreatePage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryCreateViewModelProvider);
    final viewModel = ref.read(categoryCreateViewModelProvider.notifier);

    return CommonScaffold(
      appBar: CommonAppBar(
        title: 'カテゴリー作成',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
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
