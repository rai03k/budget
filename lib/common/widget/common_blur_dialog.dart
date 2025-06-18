import 'dart:async';
import 'dart:ui';

import 'package:budget/common/enum/dialog_type.dart';
import 'package:flutter/material.dart';

class CommonBlurDialog {
  // 成功ダイアログを表示
  static Future<void> showSuccess(BuildContext context, {String? message}) {
    return _showBlurDialog(
      context,
      type: DialogType.success,
      message: message ?? '保存しました',
    );
  }

  // 失敗ダイアログを表示
  static Future<void> showError(BuildContext context, {String? message}) {
    return _showBlurDialog(
      context,
      type: DialogType.error,
      message: message ?? '保存に失敗しました',
    );
  }

  // 共通のぼかしダイアログ表示メソッド
  static Future<void> _showBlurDialog(
    BuildContext context, {
    required DialogType type,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return _DialogContent(type: type, message: message);
      },
    );
  }
}

class _DialogContent extends StatefulWidget {
  final DialogType type;
  final String message;

  const _DialogContent({required this.type, required this.message});

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        //念のためここでもmountedチェック
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ★★★これが重要★★★
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: _BlurDialogContent(
          type: widget.type,
          message: widget.message,
        ),
      ),
    );
  }
}

// ダイアログコンテンツウィジェット
class _BlurDialogContent extends StatelessWidget {
  final DialogType type;
  final String message;

  const _BlurDialogContent({
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // アイコン部分
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            // メッセージ部分
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // タイプに応じたアイコンを取得
  IconData _getIcon() {
    switch (type) {
      case DialogType.success:
        return Icons.check;
      case DialogType.error:
        return Icons.close;
    }
  }

  // タイプに応じたアイコン背景色を取得
  Color _getIconBackgroundColor() {
    switch (type) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return Colors.red;
    }
  }
}
