import 'dart:ui';

import 'package:flutter/material.dart';

class CommonBlurDialogButton {
  // 確認ダイアログを表示
  static Future<void> showConfirm(
    BuildContext context, {
    Widget? icon,
    required String message,
    String okButtonText = 'OK',
    String cancelButtonText = 'キャンセル',
    required VoidCallback onOkPressed,
    VoidCallback? onCancelPressed,
    bool visibleCancelButton = true,
  }) {
    return _showBlurConfirmDialog(
      context,
      icon: icon,
      message: message,
      okButtonText: okButtonText,
      cancelButtonText: cancelButtonText,
      onOkPressed: onOkPressed,
      onCancelPressed: onCancelPressed,
      visibleCancelButton: visibleCancelButton,
    );
  }

  // 共通のぼかし確認ダイアログ表示メソッド
  static Future<void> _showBlurConfirmDialog(
    BuildContext context, {
    Widget? icon,
    required String message,
    required String okButtonText,
    required String cancelButtonText,
    required VoidCallback onOkPressed,
    VoidCallback? onCancelPressed,
    required bool visibleCancelButton,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            onCancelPressed?.call();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: GestureDetector(
                onTap: () {}, // ダイアログ内のタップを無効化
                child: _BlurConfirmDialogContent(
                  icon: icon,
                  message: message,
                  okButtonText: okButtonText,
                  cancelButtonText: cancelButtonText,
                  onOkPressed: onOkPressed,
                  onCancelPressed: onCancelPressed,
                  visibleCancelButton: visibleCancelButton,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 確認ダイアログコンテンツウィジェット
class _BlurConfirmDialogContent extends StatelessWidget {
  final Widget? icon;
  final String message;
  final String okButtonText;
  final String cancelButtonText;
  final VoidCallback onOkPressed;
  final VoidCallback? onCancelPressed;
  final bool visibleCancelButton;

  const _BlurConfirmDialogContent({
    this.icon,
    required this.message,
    required this.okButtonText,
    required this.cancelButtonText,
    required this.onOkPressed,
    this.onCancelPressed,
    required this.visibleCancelButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
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
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: icon,
              ),
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
            const SizedBox(height: 24),
            // ボタン部分
            Row(
              children: [
                // キャンセルボタン
                if (visibleCancelButton)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancelPressed?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        cancelButtonText,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                // OKボタン
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onOkPressed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(
                      okButtonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
