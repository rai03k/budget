enum SettingType {
  categoryAdd,
  categoryEdit,
  recurringExpense,
  budgetSetting,
  currencySetting,
  dateFormatSetting,
  notificationSetting,
  backupRestore,
  dataExport,
  themeSwitch,
  lockSetting,
}

extension SettingTypeExtension on SettingType {
  String get title {
    switch (this) {
      case SettingType.categoryAdd:
        return 'カテゴリーを追加';
      case SettingType.categoryEdit:
        return 'カテゴリーを編集';
      case SettingType.recurringExpense:
        return '定期支出の管理';
      default:
        return '';
    }
  }
}
