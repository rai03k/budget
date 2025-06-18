import 'dart:ui' as ui; // BackdropFilterのために必要
import 'package:budget/common/routes/app_routes.dart';
import 'package:budget/common/widget/common_blur_dialog_button.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/views/input/receipt_scanner/receipt_scanner_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class ReceiptScannerPage extends ConsumerStatefulWidget {
  const ReceiptScannerPage({super.key});

  @override
  ConsumerState<ReceiptScannerPage> createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends ConsumerState<ReceiptScannerPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ViewModelの状態とインスタンスを取得
    final viewModel = ref.read(receiptScannerViewModelProvider.notifier);
    final state = ref.watch(receiptScannerViewModelProvider);

    ref.listen<String?>(
      // 1. stateの中からエラーメッセージだけを監視する
      receiptScannerViewModelProvider.select((value) => value.errorMessage),
      // 2. エラーメッセージが変化した時にこの部分が呼ばれる
      (previousErrorMessage, newErrorMessage) {
        // 新しいエラーメッセージが存在し、前の状態と違う場合にダイアログを表示
        if (newErrorMessage != null &&
            newErrorMessage != previousErrorMessage) {
          CommonBlurDialogButton.showConfirm(context,
              message: newErrorMessage.toString(), // 新しいエラーメッセ,
              okButtonText: '閉じる',
              onOkPressed: () {},
              visibleCancelButton: false);
        }
      },
    );

    ref.listen<ReceiptAnalysisResponse?>(
      transactionProvider.select((s) => s.value?.first.scannedData),
      (previous, next) {
        // 新しい解析結果が存在する場合
        // 条件を「以前の状態がnullで、かつ新しい状態がnullでない時」に限定する
        if (previous == null && next != null) {
          if (next.status == 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                print("スキャン結果一覧へ (初回のみ)");
                ref.invalidate(receiptScannerViewModelProvider);
                context.goNamed(AppRoutes.scannerResult);
              }
            });
          }
          // レシート以外
          if (next.status == 1) {
            CommonBlurDialogButton.showConfirm(context,
                icon: HugeIcon(
                    size: 50,
                    icon: HugeIcons.strokeRoundedRobotic,
                    color: Theme.of(context).colorScheme.onPrimary),
                message: next.items.first.name.toString(),
                okButtonText: '閉じる',
                onOkPressed: () {},
                visibleCancelButton: false);
            // 不適切な写真
          } else if (next.status == 2) {
            CommonBlurDialogButton.showConfirm(context,
                icon: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12), // アイコンの周囲に余白
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle, // 円形にする
                    ),
                    child: HugeIcon(
                      size: 40,
                      icon: HugeIcons.strokeRoundedAlert02,
                      color: Colors.white,
                    ),
                  ),
                ),
                message: '不適切な画像を検出しました。\n不適切な画像を続けて読み込むと、機能の利用が制限される可能性があります。',
                okButtonText: '閉じる',
                onOkPressed: () {},
                visibleCancelButton: false);
          }
        }
      },
    );

    // スキャンエリアの定義（UIの見た目に関する定義はViewに残す）
    final screenSize = MediaQuery.of(context).size;
    final double scanAreaWidth = screenSize.width * 0.8;
    final double scanAreaHeight = screenSize.height * 0.6;
    final Radius cornerRadius = const Radius.circular(16.0);
    final Rect scanRect = Rect.fromCenter(
      // 現在の「-80」を「0」に近づける（例: -40）か、プラスの値にすると枠が下に下がります。
      center: Offset(screenSize.width / 2, screenSize.height / 2 - 40),
      width: scanAreaWidth,
      height: scanAreaHeight,
    );
    final RRect scanRRect = RRect.fromRectAndRadius(scanRect, cornerRadius);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // --- カメラプレビュー / エラー表示 ---
          if (state.isCameraInitialized && viewModel.cameraController != null)
            Positioned.fill(
              child: CameraPreview(viewModel.cameraController!),
            )
          else
            Center(
              child: const CircularProgressIndicator(),
            ),

          // --- ぼかし & くり抜きレイヤー ---
          ClipPath(
            clipper: InvertedRRectClipper(scanRRect),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          // --- UIレイヤー ---
          Positioned(
            top: scanRect.top,
            left: scanRect.left,
            width: scanRect.width,
            height: scanRect.height,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white.withOpacity(0.8), width: 2.5),
                borderRadius: BorderRadius.all(cornerRadius),
              ),
            ),
          ),

          // --- 下部ボタンエリア ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 40,
                top: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(
                    icon: Icons.photo_library,
                    onPressed:
                        viewModel.pickImageFromGallery, // ViewModelのメソッドを呼ぶ
                  ),
                  _buildIconButton(
                    icon: Icons.camera_alt,
                    onPressed: viewModel.takePicture, // ViewModelのメソッドを呼ぶ
                    isLarge: true,
                  ),
                  _buildIconButton(
                    icon: switch (state.flashMode) {
                      FlashMode.off => Icons.flash_off_outlined,
                      FlashMode.auto => Icons.flash_auto_outlined,
                      FlashMode.torch => Icons.flash_on_outlined,
                      _ => Icons.flash_off_outlined,
                    },
                    onPressed: viewModel.toggleFlash, // ViewModelのメソッドを呼ぶ
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: scanRect.top,
            left: scanRect.left,
            width: scanRect.width,
            height: scanRect.height,
            child: Stack(
              // childをStackに変更
              children: [
                // 1. 既存の枠線
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0.8), width: 2.5),
                    borderRadius: BorderRadius.all(cornerRadius),
                  ),
                ),

                // 2. 新しく追加するツールチップ
                Align(
                  alignment: Alignment.bottomCenter, // 枠内の下中央に配置
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16), // 枠の下辺からの余白
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6), // 半透明の背景
                      borderRadius: BorderRadius.circular(8), // 角丸
                    ),
                    child: Text(
                      '購入日・金額・購入品目を収めてください',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            // ステータスバーの高さ + 余白を考慮して上からの位置を決定
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 30),
                    // ボタンが見やすくなるように半透明の背景をつける（任意）
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                    // ボタンが押されたら、現在の画面を閉じる
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Text(
                    'レシートスキャン',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 46),
                ],
              ),
            ),
          ),

          // --- 処理中オーバーレイ ---
          if (state.isProcessing)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  /// ボタンを生成するためのヘルパーウィジェット
  Widget _buildIconButton(
      {required IconData icon,
      required VoidCallback onPressed,
      bool isLarge = false}) {
    return Container(
      decoration: BoxDecoration(
          color: isLarge ? Colors.white : Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: isLarge
              ? null
              : Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                )),
      child: IconButton(
        icon: Icon(icon, color: isLarge ? Colors.black : Colors.white),
        iconSize: isLarge ? 36 : 28,
        onPressed: onPressed,
        padding: isLarge ? EdgeInsets.all(24) : EdgeInsets.all(16),
      ),
    );
  }
}

/// 角丸の四角形を「くり抜く」ためのカスタムクリッパー
class InvertedRRectClipper extends CustomClipper<Path> {
  final RRect innerRRect;

  InvertedRRectClipper(this.innerRRect);

  @override
  Path getClip(Size size) {
    // `Path.combine` を使い、画面全体の四角形から内側の角丸四角形を引きます
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRRect(innerRRect),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
