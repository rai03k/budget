import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  late PageController _pageController;
  late DateTime _currentPageDate;

  // 表示中のページインデックス
  int _currentPageIndex = 1000;

  // ボトムシートが表示されているかどうか
  bool _isBottomSheetVisible = false;

  // サンプルの支出データ
  final Map<String, int> _expenses = {
    '2025-04-01': 1200,
    '2025-04-03': 3500,
    '2025-04-07': 800,
    '2025-04-10': 1500,
    '2025-04-15': 6000,
    '2025-04-17': 2800,
    '2025-04-22': 1300,
    '2025-04-25': 4200,
    '2025-04-28': 950,
  };

  // サンプルの購入リストデータ
  final Map<String, List<Purchase>> _purchases = {
    '2025-04-01': [
      Purchase(name: 'コーヒー', price: 500, shop: 'スターバックス'),
      Purchase(name: '書籍', price: 700, shop: '紀伊国屋書店'),
    ],
    '2025-04-03': [
      Purchase(name: '夕食', price: 1800, shop: '和食レストラン'),
      Purchase(name: '映画チケット', price: 1700, shop: 'TOHOシネマズ'),
    ],
    '2025-04-07': [
      Purchase(name: 'パン', price: 300, shop: 'ベーカリー'),
      Purchase(name: '牛乳', price: 200, shop: 'スーパー'),
      Purchase(name: 'ヨーグルト', price: 300, shop: 'スーパー'),
    ],
    '2025-04-10': [Purchase(name: 'ランチ', price: 1500, shop: 'イタリアンレストラン')],
    '2025-04-15': [Purchase(name: 'スニーカー', price: 6000, shop: 'スポーツショップ')],
    '2025-04-17': [
      Purchase(name: 'ディナー', price: 2300, shop: '中華料理店'),
      Purchase(name: 'デザート', price: 500, shop: 'カフェ'),
    ],
    '2025-04-22': [
      Purchase(name: '文房具', price: 800, shop: '文具店'),
      Purchase(name: 'ノート', price: 500, shop: '文具店'),
    ],
    '2025-04-25': [Purchase(name: 'ジャケット', price: 4200, shop: 'アパレルショップ')],
    '2025-04-28': [
      Purchase(name: 'ケーキ', price: 450, shop: 'ケーキ屋'),
      Purchase(name: 'コーヒー豆', price: 500, shop: 'カフェ'),
    ],
  };

  @override
  void initState() {
    super.initState();
    // 日本語のロケールデータを初期化
    initializeDateFormatting('ja_JP');
    _currentPageDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
    // 初期ページ（現在の月）から始める
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildWeekdayHeader(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        // ページが変わったときにインデックスを更新
                        final int monthDiff = page - _currentPageIndex;
                        _currentPageIndex = page;

                        // ページの差分に基づいて日付を更新
                        _currentPageDate = DateTime(
                          _currentPageDate.year,
                          _currentPageDate.month + monthDiff,
                          1,
                        );
                      });
                    },
                    itemBuilder: (context, index) {
                      // インデックスに基づいて表示する月を計算
                      final int monthDiff = index - 1000;
                      final DateTime pageDate = DateTime(
                        DateTime.now().year,
                        DateTime.now().month + monthDiff,
                        1,
                      );
                      return _buildCalendarPage(pageDate);
                    },
                  ),
                ),
              ],
            ),

            // ボトムシート
            if (_isBottomSheetVisible) _buildPurchaseBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左上に年月を表示
          Text(
            DateFormat('yyyy年M月').format(_currentPageDate),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          // 右上にアイコンボタン
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.today, color: Colors.black87),
                onPressed: () {
                  final now = DateTime.now();
                  setState(() {
                    _selectedDate = now;
                    _currentPageDate = DateTime(now.year, now.month, 1);
                    _currentPageIndex = 1000;
                    // 今日の月にジャンプ
                    _pageController.jumpToPage(1000);
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.calendar_view_month,
                  color: Colors.black87,
                ),
                onPressed: () {
                  // カレンダー表示オプションを変更するなどの機能を追加可能
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            weekdays.map((day) {
              bool isWeekend = day == '土' || day == '日';
              return Expanded(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isWeekend ? Colors.grey[400] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCalendarPage(DateTime pageDate) {
    // 月の最初の日を取得
    final DateTime firstDayOfMonth = DateTime(pageDate.year, pageDate.month, 1);

    // 表示する最初の日を計算（前の月の日を含む）
    // 週の始まりを月曜日(1)にする
    int firstWeekday = firstDayOfMonth.weekday;
    final DateTime firstDisplayedDay = firstDayOfMonth.subtract(
      Duration(days: firstWeekday - 1),
    );

    // 週ごとのリスト作成
    List<List<DateTime>> weeks = [];
    DateTime currentDay = firstDisplayedDay;

    // 最大6週まで表示可能だが、最後の週が全て次の月なら表示しない
    for (int weekIndex = 0; weekIndex < 6; weekIndex++) {
      List<DateTime> week = [];
      for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
        week.add(currentDay);
        currentDay = currentDay.add(const Duration(days: 1));
      }

      // この週が全て次の月の場合は追加しない
      bool isAllNextMonth = week.every(
        (date) =>
            date.month > pageDate.month ||
            (date.month == 1 && pageDate.month == 12),
      );

      if (!isAllNextMonth) {
        weeks.add(week);
      } else {
        // 最後の週が全て次の月の場合はループ終了
        break;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalHeight = constraints.maxHeight;
        final double cellHeight = totalHeight / weeks.length;
        final double childAspectRatio =
            1 / (cellHeight / (constraints.maxWidth / 7));

        // カレンダーのセルをフラットなリストに変換
        List<Widget> calendarCells = [];
        for (var week in weeks) {
          for (var date in week) {
            final bool isCurrentMonth = date.month == pageDate.month;
            final bool isSelected =
                date.year == _selectedDate.year &&
                date.month == _selectedDate.month &&
                date.day == _selectedDate.day;
            final bool isToday =
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day;

            // その日の支出を取得
            final String dateKey = DateFormat('yyyy-MM-dd').format(date);
            final int? expense = _expenses[dateKey];

            calendarCells.add(
              _buildCalendarCell(
                date,
                isCurrentMonth,
                isSelected,
                isToday,
                expense,
              ),
            );
          }
        }

        // カレンダーを表示（スクロール可能）
        return Padding(
          padding: EdgeInsets.only(
            left: 4,
            right: 4,
            top: 4,
            // ボトムシートが表示されている時は、その高さ分の余白を追加
            bottom:
                _isBottomSheetVisible
                    ? MediaQuery.of(context).size.height * 0.3 + 4
                    : 4,
          ),
          child: SingleChildScrollView(
            // ボトムシートが表示されている時のみスクロール可能
            physics:
                _isBottomSheetVisible
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: childAspectRatio,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: calendarCells,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendarCell(
    DateTime date,
    bool isCurrentMonth,
    bool isSelected,
    bool isToday,
    int? expense,
  ) {
    // Color logic
    Color cellColor = Colors.white;
    Color textColor = isCurrentMonth ? Colors.black87 : Colors.grey[400]!;
    Color? expenseColor;

    if (isSelected) {
      cellColor = Colors.blue[100]!;
      textColor = Colors.blue[800]!;
      expenseColor = Colors.blue[800];
    } else if (isToday) {
      textColor = Colors.blue;
      expenseColor = Colors.blue;
    } else if (expense != null) {
      expenseColor = isCurrentMonth ? Colors.red[700] : Colors.red[200];
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;

          // 選択した日付が現在のページの月と異なる場合、そのページに移動
          if (date.month != _currentPageDate.month ||
              date.year != _currentPageDate.year) {
            final DateTime newPageDate = DateTime(date.year, date.month, 1);
            final int monthDiff =
                (newPageDate.year - DateTime.now().year) * 12 +
                newPageDate.month -
                DateTime.now().month;
            _currentPageIndex = 1000 + monthDiff;
            _currentPageDate = newPageDate;
            _pageController.jumpToPage(_currentPageIndex);
          }

          // ボトムシートを表示
          _isBottomSheetVisible = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            // 日付を左下に配置
            Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight:
                      isSelected || isToday
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ),

            // 支出を中央に配置
            if (expense != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '${expense}',
                    style: TextStyle(
                      color: expenseColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

            // Today indicator
            if (isToday && !isSelected)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 購入リスト表示用のボトムシート
  Widget _buildPurchaseBottomSheet() {
    final String dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final List<Purchase> dayPurchases = _purchases[dateKey] ?? [];

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      // ボトムシートの高さを画面の40%に設定
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // ヘッダー（日付と閉じるボタン）
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy年M月d日 (E)', 'ja_JP').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isBottomSheetVisible = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            // 購入リストまたは空のメッセージ
            Expanded(
              child:
                  dayPurchases.isEmpty
                      ? const Center(
                        child: Text(
                          '記録された支出はありません',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                      : ListView.separated(
                        itemCount: dayPurchases.length,
                        separatorBuilder:
                            (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final purchase = dayPurchases[index];
                          return ListTile(
                            title: Text(
                              purchase.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(purchase.shop),
                            trailing: Text(
                              '¥${purchase.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[700],
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

// 購入データを表すクラス
class Purchase {
  final String name; // 購入品名
  final int price; // 価格
  final String shop; // 店舗名

  Purchase({required this.name, required this.price, required this.shop});
}
