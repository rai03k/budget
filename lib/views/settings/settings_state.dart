import 'package:freezed_annotation/freezed_annotation.dart';

import '../../provider/category/category_provider.dart';

part 'settings_state.freezed.dart';

// 設定画面全体の状態を保持するクラス
@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    // 設定画面に表示するカテゴリー設定のリスト
    required List<CategoryState> categories,
  }) = _SettingsState;
}
