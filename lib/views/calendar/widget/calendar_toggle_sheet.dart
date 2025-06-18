import 'package:flutter/material.dart';

class CalendarToggleSheet extends StatefulWidget {
  const CalendarToggleSheet({super.key});

  @override
  State<CalendarToggleSheet> createState() => _CalendarToggleSheetState();
}

class _CalendarToggleSheetState extends State<CalendarToggleSheet> {
  bool wantToMeet = true;
  bool wantToMeetIfMatched = true;
  bool wantToChat = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー部分
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 24),

            _buildToggleOption(
              title: 'カテゴリー表示',
              value: wantToMeet,
              onChanged: (value) {
                setState(() {
                  wantToMeet = value;
                });
              },
            ),

            const SizedBox(height: 20),

            _buildToggleOption(
              title: '支出額表示',
              value: wantToMeetIfMatched,
              onChanged: (value) {
                setState(() {
                  wantToMeetIfMatched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
          activeTrackColor: Theme.of(context).colorScheme.onPrimary, // ターコイズブルー
          inactiveThumbColor: Theme.of(context).colorScheme.primary,
          inactiveTrackColor: Theme.of(context).colorScheme.secondary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
