import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime initialDate;

  const CalendarBottomSheet({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime currentMonth;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    selectedDate = widget.initialDate;
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    Navigator.of(context).pop(date);
  }

  List<Widget> _buildCalendarDays() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday % 7; // 日曜日を0にする

    List<Widget> dayWidgets = [];

    // 前月の空白セルを追加
    for (int i = 0; i < firstDayWeekday; i++) {
      dayWidgets.add(Container()); // 空のセル
    }

    // 当月の日付のみ表示
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      dayWidgets.add(
        _buildDayWidget(date, isCurrentMonth: true),
      );
    }

    return dayWidgets;
  }

  Widget _buildDayWidget(DateTime date, {required bool isCurrentMonth}) {
    final isSelected = selectedDate != null &&
        date.year == selectedDate!.year &&
        date.month == selectedDate!.month &&
        date.day == selectedDate!.day;

    final isToday = DateTime.now().year == date.year &&
        DateTime.now().month == date.month &&
        DateTime.now().day == date.day;

    return GestureDetector(
      onTap: () => _selectDate(date),
      child: Container(
        decoration: BoxDecoration(
          color: isToday
              ? Theme.of(context).colorScheme.surface
              : Colors.transparent,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isToday
                  ? Theme.of(context).colorScheme.onPrimary
                  : isCurrentMonth
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.secondary,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 内容のサイズに合わせる
        children: [
          // ヘッダー
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                DateFormat('yyyy年 M月').format(currentMonth),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
          SizedBox(height: 16),

          // 曜日ヘッダー
          Row(
            children: ['日', '月', '火', '水', '木', '金', '土']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 8),

          // カレンダーグリッド
          Container(
            height: 350, // カレンダーグリッドの高さを固定
            child: GridView.count(
              crossAxisCount: 7,
              children: _buildCalendarDays(),
            ),
          ),
        ],
      ),
    );
  }
}
