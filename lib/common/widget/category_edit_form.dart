import 'dart:ui';

import 'package:budget/common/enum/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../enum/app_colors.dart';
import '../enum/app_icon.dart';

class CategoryEditForm extends StatefulWidget {
  final String categoryName;
  final int selectedColor;
  final int selectedIcon;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<AppColors> onColorChanged;
  final ValueChanged<CategoryIcons> onIconChanged;
  final VoidCallback onSave;
  const CategoryEditForm({
    super.key,
    required this.categoryName,
    required this.selectedColor,
    required this.selectedIcon,
    required this.onNameChanged,
    required this.onColorChanged,
    required this.onIconChanged,
    required this.onSave,
  });

  @override
  State<CategoryEditForm> createState() => _CategoryEditFormState();
}

class _CategoryEditFormState extends State<CategoryEditForm>
    with TickerProviderStateMixin {
  late int selectedColorIndex = widget.selectedColor;
  late int selectedIconIndex = widget.selectedIcon;

  late AnimationController _scaleController;
  late AnimationController _rippleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;

  late Color _previousColor;
  late Color _currentColor;

  late final TextEditingController _controller =
      TextEditingController(text: widget.categoryName);

  // カラーリスト（enum values）
  final List<AppColors> colors = AppColors.values;

  // アイコンリスト（enum values）
  final List<CategoryIcons> icons = CategoryIcons.values;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _rippleController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _previousColor = AppColors.values[selectedColorIndex].color(context);
    _currentColor = AppColors.values[selectedColorIndex].color(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _triggerIconAnimation() {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
  }

  void _triggerColorRipple(Color newColor) {
    _previousColor = _currentColor;
    _currentColor = newColor;
    _rippleController.forward().then((_) {
      _rippleController.reset();
      setState(() {
        _previousColor = _currentColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 140),
                  // カテゴリー名
                  Text(
                    'カテゴリー名',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _controller,
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '入力必須項目です';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                    decoration: _commonInputDecoration(
                      hintText: 'カテゴリー名を入力してください',
                      fillColor: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: widget.onNameChanged,
                  ),
                  const SizedBox(height: 24),
                  // カラー
                  Text(
                    'カラー',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onColorChanged(colors[index]);
                            Color newColor = colors[index].color(context);
                            setState(() {
                              selectedColorIndex = index;
                            });
                            _triggerColorRipple(newColor);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: index == colors.length - 1 ? 0 : 6),
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: selectedColorIndex == index
                                  ? Border.all(
                                      color: colors[index].color(context),
                                      width: 3)
                                  : null,
                            ),
                            child: Center(
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: colors[index].color(context),
                                  shape: BoxShape.circle,
                                ),
                                child: selectedColorIndex == index
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 20,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  // アイコン
                  Text(
                    'アイコン',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: icons.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onIconChanged(icons[index]);
                            setState(() {
                              selectedIconIndex = index;
                            });
                            _triggerIconAnimation();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                              border: selectedIconIndex == index
                                  ? Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      width: 2)
                                  : null,
                            ),
                            child: Icon(
                              icons[index].iconData,
                              color: selectedIconIndex == index
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSecondary,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: // アイコン＋背景色
                AnimatedBuilder(
              animation:
                  Listenable.merge([_scaleController, _rippleController]),
              builder: (context, child) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: _currentColor.withOpacity(0.3),
                          blurRadius: 12 + _scaleAnimation.value * 8,
                          spreadRadius: 2 + _scaleAnimation.value * 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // ベース色
                          Container(
                            width: 96,
                            height: 96,
                            color: _previousColor,
                          ),
                          // 波紋効果
                          AnimatedBuilder(
                            animation: _rippleAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                size: Size(96, 96),
                                painter: RipplePainter(
                                  progress: _rippleAnimation.value,
                                  color: _currentColor,
                                ),
                              );
                            },
                          ),
                          // アイコン
                          Center(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Icon(
                                icons[selectedIconIndex].iconData,
                                key: ValueKey(
                                    '${selectedColorIndex}-${selectedIconIndex}'),
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: // 保存ボタン
                _buildSaveButton(),
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
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
                return Theme.of(context).colorScheme.onPrimary; // 活性時の背景色
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
          // 2. onPressed プロパティを制御
          onPressed: widget.onSave,
          child: const Text(
            '保存',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // color プロパティは ElevatedButton.styleFrom の foregroundColor で制御される
            ),
          ),
        ),
      ),
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

// 波紋効果を描画するカスタムペインター
class RipplePainter extends CustomPainter {
  final double progress;
  final Color color;

  RipplePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 * 1.5; // 対角線の半分より少し大きく

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 波紋の半径を計算（中心から外側へ）
    final currentRadius = maxRadius * progress;

    // クリッピング用の矩形
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(rect);

    // 波紋を描画
    canvas.drawCircle(center, currentRadius, paint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
