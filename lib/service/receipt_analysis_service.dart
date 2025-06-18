import 'dart:convert';
import 'dart:typed_data';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:firebase_ai/firebase_ai.dart' as ai;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

// 作成したモデルファイルをインポート
import '../model/receipt_analysis_response.dart';

// このサービスをRiverpodで利用可能にするためのProvider
final receiptAnalysisServiceProvider =
    Provider((ref) => ReceiptAnalysisService());

class ReceiptAnalysisService {
  /// 画像を解析し、構造化されたレスポンスを返す
  Future<ReceiptAnalysisResponse> analyzeReceiptImage({
    required XFile imageFile,
    required List<String> availableCategories,
  }) async {
    try {
      // 1. 動的なJSONスキーマを構築
      final jsonSchema = _buildJsonSchema(availableCategories);

      // 2. モデルを初期化
      final model = ai.FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash-preview-05-20',
        generationConfig: ai.GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: jsonSchema,
        ),
      );

      // 3. プロンプトと画像データを準備
      final prompt = ai.TextPart(
          "画像がレシートなら、購入日・税込金額・商品名・カテゴリを返してください。レシートでない場合は、status:1、nameに画像の内容とユーモアのあるコメントを含めて返してください");

      final imageBytes = await imageFile.readAsBytes();
      final mimeType = lookupMimeType(imageFile.path);
      final imagePart = ai.InlineDataPart(
        mimeType ?? 'application/octet-stream',
        imageBytes,
      );

      // 4. APIにリクエストを送信
      print('AI Service: リクエスト開始');
      final response = await model.generateContent([
        ai.Content.multi([prompt, imagePart])
      ]);
      print('AI Service: レスポンス受信');
      print(response.text);

      // 5. 受け取ったJSON文字列をパースし、モデルクラスに変換して返す
      final decodedJson = jsonDecode(response.text ?? '{}');
      return ReceiptAnalysisResponse.fromJson(decodedJson);
    } catch (e) {
      print('AI Service Error: $e');

      if (e.toString().contains('blockReason')) {
        // 安全性エラーの場合は、ステータス2をセットした特別なレスポンスを返す
        return const ReceiptAnalysisResponse(
          status: 2, // 2 = 安全性によりブロックされた
          items: [],
          date: 'N/A',
        );
      }

      rethrow;
    }
  }

  /// カテゴリリストから動的にスキーマを生成するヘルパーメソッド
  ai.Schema _buildJsonSchema(List<String> categories) {
    return ai.Schema.object(
      properties: {
        'status':
            ai.Schema.integer(description: 'レシート画像のステータス (0: 正常, 1: 読み取れない)'),
        'date': ai.Schema.string(description: 'レシートの日付 (例:2025-06-05)'),
        'items': ai.Schema.array(
          items: ai.Schema.object(
            properties: {
              'name': ai.Schema.string(description: '商品名'),
              'price': ai.Schema.integer(description: '商品の価格 (円)'),
              'category': ai.Schema.enumString(
                // ViewModelから渡されたカテゴリリストをここに設定
                enumValues: categories,
                description: 'カテゴリーから選択',
              ),
            },
          ),
        ),
      },
    );
  }
}
