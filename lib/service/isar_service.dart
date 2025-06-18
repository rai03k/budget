// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io'; // Directory クラスを使用するためにインポート

// // ★あなたが定義したCollectionのモデルファイルをインポートしてください★
// // 提供されたファイル名に基づいてインポートします
// import '../model/budget.dart'; // budget.dart ファイルをインポート
// import '../model/category.dart'; // category.dart ファイルをインポート
// import '../model/transaction.dart'; // transaction.dart ファイルをインポート

// class IsarService {
//   // シングルトンインスタンス
//   late Future<Isar> db;

//   // プライベートコンストラクタでシングルトンパターンを実装
//   IsarService._privateConstructor() {
//     db = openDB();
//   }

//   // シングルトンインスタンスへのゲッター
//   static final IsarService _instance = IsarService._privateConstructor();
//   factory IsarService() {
//     return _instance;
//   }

//   // Isarデータベースを開くメソッド
//   Future<Isar> openDB() async {
//     // Isarインスタンスが既に開かれているか確認
//     if (Isar.instanceNames.isEmpty) {
//       // アプリケーションのドキュメントディレクトリを取得
//       final Directory dir = await getApplicationDocumentsDirectory();

//       // Isarデータベースを開く
//       final isar = await Isar.open(
//         // ★ここにアプリケーションで使用する全てのCollectionのスキーマを追加してください★
//         [BudgetSchema, CategorySchema, TransactionSchema], // 提供されたスキーマを追加
//         directory: dir.path,
//         inspector: true, // Isar Inspectorを有効にする (デバッグ時推奨)
//       );
//       return isar;
//     }
//     // 既に開かれているインスタンスを返す
//     return Future.value(Isar.getInstance());
//   }

//   // データベースを閉じるメソッド (アプリ終了時などに任意で呼び出す)
//   Future<void> closeDB() async {
//     final isar = await db;
//     if (isar.isOpen) {
//       await isar.close();
//     }
//   }

//   // --- Budget Collectionに対するCRUD操作メソッド ---

//   // Budgetを保存または更新するメソッド (Create/Update)
//   Future<void> saveBudget(Budget budget) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.budgets.put(budget); // put() はIDがあれば更新、なければ新規追加
//     });
//   }

//   // 全てのBudgetを取得するメソッド (Read)
//   Future<List<Budget>> getAllBudgets() async {
//     final isar = await db;
//     return await isar.budgets.where().findAll();
//   }

//   // 指定されたIDのBudgetを取得するメソッド (Read)
//   Future<Budget?> getBudgetById(int id) async {
//     final isar = await db;
//     return await isar.budgets.get(id);
//   }

//   // 指定されたIDのBudgetを削除するメソッド (Delete)
//   Future<void> deleteBudget(int id) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.budgets.delete(id);
//     });
//   }

//   // --- Category Collectionに対するCRUD操作メソッド ---

//   // Categoryを保存または更新するメソッド (Create/Update)
//   Future<void> saveCategory(Category category) async {
//     final isar = await db;
//     try {
//       await isar.writeTxn(() async {
//         // 既存の最大 orderIndex を取得
//         final maxOrderIndex = await isar.categorys
//             .where()
//             .filter()
//             .sortOrderIsNotNull()
//             .sortBySortOrderDesc()
//             .limit(1)
//             .findFirst();

//         final newOrderIndex = maxOrderIndex?.sortOrder ?? -1;

//         // まだ orderIndex が設定されていない場合にのみ追加
//         category.sortOrder ??= newOrderIndex + 1;

//         await isar.categorys.put(category);
//       });
//       print('✅ カテゴリー保存しました: ${category.categoryName}'); // デバッグ用ログ
//     } catch (e) {
//       print('❌ カテゴリー保存に失敗しました: $e'); // エラーログ
//       rethrow;
//     }
//   }

//   // 全てのCategoryを取得するメソッド (Read)
//   Future<List<Category>> getAllCategorys() async {
//     final isar = await db;
//     return await isar.categorys.where().sortBySortOrder().findAll();
//   }

//   // 指定されたIDのCategoryを取得するメソッド (Read)
//   Future<Category?> getCategoryById(int id) async {
//     final isar = await db;
//     return await isar.categorys.get(id);
//   }

//   // 指定されたIDのCategoryを削除するメソッド (Delete)
//   Future<void> deleteCategory(int id) async {
//     try {
//       final isar = await db;
//       await isar.writeTxn(() async {
//         await isar.categorys.delete(id);
//       });
//       print('✅ カテゴリー削除しました：$id'); // デバッグ用ログ
//     } catch (e) {
//       print('❌ カテゴリー削除に失敗しました: $e'); // エラーログ
//       rethrow;
//     }
//   }

//   // --- Transaction Collectionに対するCRUD操作メソッド ---

//   // Transactionを保存または更新するメソッド (Create/Update)
//   Future<void> saveTransaction(
//       Category category, Transaction transaction) async {
//     try {
//       final isar = await db;
//       await isar.writeTxn(() async {
//         await isar.categorys.put(category);
//         await isar.transactions.put(transaction); // put() はIDがあれば更新、なければ新規追加
//         await transaction.category.save(); // 関連付けられたCategoryを保存
//       });
//       print('✅ 取引保存しました: ${transaction.itemName}'); // デバッグ用ログ
//     } catch (e) {
//       print('❌ 取引保存に失敗しました: $e'); // エラーログ
//       rethrow;
//     }
//   }

//   Future<void> saveAllTransactions(List<Transaction> transactions) async {
//     final isar = await db;
//     // IsarのWriteトランザクション内で全ての書き込みを行う
//     await isar.writeTxn(() async {
//       // リスト内の各トランザクションをループ処理する
//       for (final transaction in transactions) {
//         // 1. リンクされているCategoryオブジェクトを取得
//         final category = transaction.category.value;

//         // 2. Categoryオブジェクトが存在すれば、まずそれを保存(put)する
//         //    putはIDがあれば更新、なければ新規作成(Upsert)なので、既存カテゴリもこれでOK
//         if (category != null) {
//           await isar.categorys.put(category);
//         }

//         // 3. Transactionオブジェクト本体を保存(put)する
//         await isar.transactions.put(transaction);

//         // 4. 最後に、TransactionとCategoryの関連付け(Link)を明示的に保存する
//         //    これが最も確実な方法
//         await transaction.category.save();
//       }
//     });
//   }

//   // 全てのTransactionを取得するメソッド (Read)
//   Future<List<Transaction>> getAllTransactions() async {
//     final isar = await db;
//     return await isar.transactions.where().findAll();
//   }

//   // 指定されたIDのTransactionを取得するメソッド (Read)
//   Future<Transaction?> getTransactionById(int id) async {
//     final isar = await db;
//     return await isar.transactions.get(id);
//   }

//   // 指定されたIDのTransactionを削除するメソッド (Delete)
//   Future<void> deleteTransaction(int id) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.transactions.delete(id);
//     });
//   }

// // 補足: 特定のフィールドだけを更新したい場合は、
// // 該当オブジェクトをIDで取得 -> フィールドを修正 -> put() で保存、という流れになります。
// // 例: updateUserName メソッドのように実装可能です。
// }
