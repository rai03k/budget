import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/app_icon.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/widget/common_category_icon.dart';
import 'package:budget/common/widget/common_scaffold.dart';
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/views/calendar/widget/calendar_toggle_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodを使用
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/date_symbol_data_local.dart'; // ロケールデータ初期化用
import 'package:intl/intl.dart';

import 'calendar_state.dart'; // Stateをインポート (Purchaseクラスも含まれるか、Purchaseは別途インポート)
import 'calendar_view_model.dart'; // ViewModelをインポート
// import 'purchase.dart'; // Purchaseクラスを別ファイルに定義した場合はインポート

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  // 各カレンダーページに対応するScrollControllerを管理
  final Map<String, ScrollController> _scrollControllers = {};
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ja_JP');
    // PageController の初期化は build メソッド内の asyncState.when(data: ...) で
    // state.currentPageIndex が利用可能になった時点で行う
  }

  ScrollController _getOrAllocateScrollController(DateTime pageDate) {
    final key = pageDate
        .toIso8601String(); // DateTime を直接キーにすると同一インスタンスでないと比較がうまくいかないことがあるため文字列化
    return _scrollControllers.putIfAbsent(key, () => ScrollController());
  }

  @override
  void dispose() {
    _pageController?.dispose();
    for (var controller in _scrollControllers.values) {
      controller.dispose();
    }
    _scrollControllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // buildメソッドにWidgetRefを追加
    // ViewModelの状態を監視
    final asyncState = ref.watch(calendarViewModelProvider);
    // ViewModelのNotifier（メソッド）を読み取り
    final viewModel = ref.read(calendarViewModelProvider.notifier);

    // 日付フォーマットのロケールデータを初期化
    // これはアプリ起動時に一度だけ実行するのが望ましいですが、
    // 元のコードに合わせて、ここではbuild内で呼び出す形を維持します。
    // アプリ全体で一度だけ実行されるように修正することを検討してください。
    initializeDateFormatting('ja_JP');

    return CommonScaffold(
      body: SafeArea(
        // AsyncValue の状態に応じて表示を切り替える
        child: asyncState.when(
          data: (state) {
            // データが正常にロードされた場合
            // PageControllerはView側で管理し、ViewModelの状態と同期させる
            // state が確定してから PageController を初期化
            // PageControllerの初期化と状態同期
            // ビルドのたびに PageController を再生成しないように、
            // _pageController が null の場合か、ViewModel の index と異なる場合のみ初期化
            // _pageController の初期化ロジック (ユーザー報告で動作したものを維持)
            if (_pageController == null ||
                (_pageController!.hasClients &&
                    _pageController!.page?.round() != state.currentPageIndex) ||
                (!_pageController!.hasClients &&
                    _pageController!.initialPage != state.currentPageIndex)) {
              _pageController?.dispose();
              _pageController =
                  PageController(initialPage: state.currentPageIndex);
            }

            // ViewModelの状態変化を監視
            ref.listen<AsyncValue<CalendarState>>(
              calendarViewModelProvider,
              (prevAsyncValue, nextAsyncValue) {
                final prevData = prevAsyncValue?.value;
                final nextData = nextAsyncValue.value;

                if (nextData == null) return;

                // _pageController の null チェック (念のため)
                if (_pageController == null) {
                  print("エラー: ref.listenコールバック内で _pageController が null です。");
                  return;
                }

                // ページインデックスの変更をPageControllerに反映
                if (prevData != null &&
                    _pageController!.hasClients &&
                    prevData.currentPageIndex != nextData.currentPageIndex) {
                  if (_pageController!.page?.round() !=
                      nextData.currentPageIndex) {
                    _pageController!.jumpToPage(nextData.currentPageIndex);
                  }
                }

                // ボトムシート表示状態の変化を監視してスクロール判定
                final prevBottomSheetVisible =
                    prevData?.isBottomSheetVisible ?? false;
                if (!prevBottomSheetVisible && nextData.isBottomSheetVisible) {
                  bool shouldScroll = true; // デフォルトはスクロールする

                  //final Rect? cellRect = nextData.selectedCellGlobalRect;
                  final double position = nextData.position;
                  print("❤️ position: $position");
                  if (position != null) {
                    //final cellBottomY = cellRect.bottom;
                    final screenHeight = MediaQuery.of(context).size.height;
                    final bottomSheetHeight = screenHeight * 0.3;
                    // ボトムシートは画面下端からの高さなので、その上端のY座標
                    final bottomSheetTopY = screenHeight - bottomSheetHeight;

                    // セルの下端がボトムシートの上端よりも上（小さい値）なら隠れていない
                    if (position <= bottomSheetTopY) {
                      shouldScroll = false;
                    }
                    print(
                        "CellBottomY: $position, BottomSheetTopY: $bottomSheetTopY, ShouldScroll: $shouldScroll");
                  }

                  if (shouldScroll) {
                    final currentScrollControllerKey =
                        nextData.currentPageDate.toIso8601String();
                    final scrollController =
                        _scrollControllers[currentScrollControllerKey];
                    if (scrollController != null &&
                        scrollController.hasClients) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      });
                    }
                  }
                  // Rect情報をクリア (スクロール有無に関わらず、判定に使ったらクリア)
                  if (nextData.position != null) {
                    viewModel.clearSelectedCellRect();
                  }
                }
              },
            );

            return Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(context, state, viewModel),
                    _buildWeekdayHeader(context),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: viewModel.updateCurrentPage,
                        itemBuilder: (context, index) {
                          final int monthDiff =
                              index - CalendarState.initial().currentPageIndex;
                          final DateTime pageDate = DateTime(
                            DateTime.now().year,
                            DateTime.now().month + monthDiff,
                            1,
                          );
                          final scrollController =
                              _getOrAllocateScrollController(pageDate);
                          return _buildCalendarPage(context, state, viewModel,
                              pageDate, scrollController);
                        },
                      ),
                    ),
                  ],
                ),
                if (state.isBottomSheetVisible)
                  _buildPurchaseBottomSheet(context, state, viewModel),
              ],
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()), // ローディング中
          error: (error, stackTrace) =>
              Center(child: Text('エラーが発生しました: $error')), // エラー発生時
        ),
      ),
    );
  }

  // ヘルパーメソッド - ViewModelの状態とメソッドを受け取るように変更
  Widget _buildHeader(
      BuildContext context, CalendarState state, CalendarViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ViewModelの状態から年月を表示
          Text(
            DateFormat('yyyy年M月').format(state.currentPageDate),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          // Row(
          //   children: [
          //     // ViewModelのメソッドを呼び出す
          //     GestureDetector(
          //       onTap: () {
          //         viewModel.goToToday();
          //       },
          //       child: HugeIcon(
          //         icon: HugeIcons.strokeRoundedArrowTurnBackward,
          //         color: Theme.of(context).colorScheme.onPrimary,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 24,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         showModalBottomSheet(
          //           context: context,
          //           backgroundColor: Colors.transparent,
          //           isScrollControlled: true,
          //           builder: (context) => const CalendarToggleSheet(),
          //         );
          //       },
          //       child: HugeIcon(
          //         icon: HugeIcons.strokeRoundedFilter,
          //         color: Theme.of(context).colorScheme.onPrimary,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays.map((day) {
          bool isWeekend = day == '土' || day == '日';
          return Expanded(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isWeekend
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  // PageView.builderから呼ばれる各月のカレンダーページを生成するメソッド
  // そのページが表示する月の初日 (pageDate) を受け取る
  Widget _buildCalendarPage(
      BuildContext context,
      CalendarState state,
      CalendarViewModel viewModel,
      DateTime pageDate,
      ScrollController scrollController) {
    // この月のカレンダーグリッドを計算する
    // このロジックはViewModelの状態には依存せず、与えられたpageDateにのみ依存するため、View側に配置する
    final List<List<DateTime>> weeks = _calculateCalendarWeeksForPage(pageDate);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalHeight = constraints.maxHeight;
        // 週の数が0でないことを確認して割り算
        final double cellHeight =
            weeks.isNotEmpty ? totalHeight / weeks.length : 0;
        // cellHeightが0でないことを確認してchildAspectRatioを計算
        final double childAspectRatio = cellHeight > 0
            ? 1 / (cellHeight / (constraints.maxWidth / 7))
            : 1.0; // cellHeightが0の場合はデフォルト値

        List<Widget> calendarCells = [];
        for (var week in weeks) {
          for (var date in week) {
            final bool isCurrentMonth = date.month == pageDate.month;
            // ViewModelの状態にある選択日と比較
            final bool isSelected = date.year == state.selectedDate.year &&
                date.month == state.selectedDate.month &&
                date.day == state.selectedDate.day;
            final bool isToday = date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day;

            // ViewModelの状態からその日の支出を取得
            final String dateKey = DateFormat('yyyy-MM-dd').format(date);

            calendarCells.add(
              // セル生成メソッドに必要なデータとViewModelメソッドを渡す
              _buildCalendarCell(
                  context,
                  state,
                  viewModel, // StateとViewModelを渡す
                  date,
                  isCurrentMonth,
                  isSelected,
                  isToday),
            );
          }
        }

        return Padding(
          padding: EdgeInsets.only(
            left: 4,
            right: 4,
            top: 4,
            // ボトムシートの表示状態をViewModelから取得
            bottom: state.isBottomSheetVisible
                ? MediaQuery.of(context).size.height * 0.3
                : 0,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            // スクロール可能かどうかをViewModelの状態から判断
            physics: state.isBottomSheetVisible
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              // GridView自体はスクロールさせない (SingleChildScrollViewでラップしているため)
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

  // カレンダーセルを生成するメソッド
  // セルの日付 (date) と表示に必要な状態、ViewModelメソッドを受け取る
  Widget _buildCalendarCell(
    BuildContext context,
    CalendarState state,
    CalendarViewModel viewModel, // StateとViewModelを受け取る
    DateTime date,
    bool isCurrentMonth,
    bool isSelected,
    bool isToday,
  ) {
    // 色のロジックはViewに残すが、必要なデータはStateから取得
    Color cellColor = isToday
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.primary;
    Color textColor = isCurrentMonth
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onSecondary;
    Color? expenseColor;
    final int? expense = viewModel.getExpenseForDate(date);
    final transactions = viewModel.getTransactionsForDate(date);
    final categoryColors = viewModel.getCategoriesForDate(date); // 特定日付のカテゴリを取得

    final maxVisible = 4;
    final visibleTransactions = categoryColors.take(maxVisible).toList();
    final hasOverflow = transactions.length > maxVisible;

    // if (isSelected) {
    //   textColor = Colors.blue[800]!;
    //   expenseColor = Colors.blue[800];
    // } else if (isToday) {
    //   textColor = Colors.blue;
    //   expenseColor = Colors.blue;
    // } else if (expense != null) {
    //   expenseColor = isCurrentMonth ? Colors.red[700] : Colors.red[200];
    // }
    final key = GlobalKey();
    return GestureDetector(
      key: key,
      // タップされたらViewModelのselectDateメソッドを呼び出す
      onTap: () {
        print("❤️ タップされました: $date");

        double position = 0;
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final posi = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;
          position = posi.dy + renderBox.size.height;
          print('位置: ${posi.dy}, 高さ: ${size.height}');
          // → 必要に応じてここで処理（例: showModalAtPosition(position.dy) など）
        }

        //print("💕cellGlobalRect: $cellGlobalRect, 位置: ${position.dy}");
        viewModel.selectDate(date, position); // Rect情報をViewModelに渡す
      }, // ViewModelのメソッドを呼び出し
      child: Container(
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(8),
          // 選択状態をViewModelの状態から判断
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onPrimary, width: 1)
              : null,
        ),
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ),
            if (expense != null) // 支出がある場合のみ表示
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // カテゴリーごとの色付き丸を表示
                    if (categoryColors.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...visibleTransactions.map(
                              (category) => Container(
                                width: 6,
                                height: 6,
                                margin: const EdgeInsets.only(right: 2),
                                decoration: BoxDecoration(
                                  color: category.color.color(context),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            if (hasOverflow)
                              const Text(
                                '…',
                                style: TextStyle(fontSize: 12), // 必要なら調整
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    // 支出金額
                    Text(
                      '${expense}',
                      style: TextStyle(
                        color: expenseColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 購入リスト表示用のボトムシートを生成するメソッド
  // ViewModelの状態とメソッドを受け取る
  Widget _buildPurchaseBottomSheet(
      BuildContext context, CalendarState state, CalendarViewModel viewModel) {
    // ViewModelのgetterを使って、選択された日付の購入リストを取得
    final List<TransactionState> transactions =
        viewModel.getTransactionsForDate(state.selectedDate);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      // ボトムシートの高さを画面の30%に設定 (元のコードに合わせて修正)
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // ヘッダー（日付と閉じるボタン）
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ViewModelの状態から選択日付を表示
                  Text(
                    DateFormat('yyyy年M月d日(E)', 'ja_JP')
                        .format(state.selectedDate),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ViewModelのメソッドを呼び出す
                  IconButton(
                    icon: HugeIcon(
                      size: 20,
                      icon: HugeIcons.strokeRoundedCancel01,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: viewModel.closeBottomSheet,
                  ),
                ],
              ),
            ),
            // 購入リストまたは空のメッセージ
            Expanded(
              child: transactions.isEmpty
                  ? Center(
                      child: Text(
                        '記録された支出はありません',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) => Container(),
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Dismissible(
                          key: ValueKey(transaction.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onDismissed: (direction) {
                            viewModel.deleteTransaction(transaction.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                CommonCategoryIcon(
                                    color:
                                        transaction.category.color.color(context),
                                    icon: transaction.category.icon.iconData),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  transaction.itemName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '¥${transaction.amount}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
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

  // PageView.builder内で各ページのカレンダー週リストを計算するためのヘルパー関数
  // View側で、特定の月の表示に必要な計算を行う
  List<List<DateTime>> _calculateCalendarWeeksForPage(DateTime pageDate) {
    // 月の最初の日を取得
    final DateTime firstDayOfMonth = DateTime(pageDate.year, pageDate.month, 1);

    // 表示する最初の日を計算（前の月の日を含む）
    // 週の始まりを月曜日(1)にする
    int firstWeekday = firstDayOfMonth.weekday;
    final DateTime firstDisplayedDay = firstDayOfMonth.subtract(
      Duration(days: firstWeekday - 1),
    );

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
            (date.month == 1 && pageDate.month == 12), // 年末年始の跨ぎも考慮
      );

      if (!isAllNextMonth) {
        weeks.add(week);
      } else {
        // 最後の週が全て次の月の場合はループ終了
        break;
      }
    }
    return weeks;
  }
}

// PurchaseクラスはStateファイルに移動済み
/*
// 購入データを表すクラス
class Purchase {
  final String name; // 購入品名
  final int price; // 価格
  final String shop; // 店舗名
  final String category; // カテゴリー

  Purchase({
    required this.name,
    required this.price,
    required this.shop,
    required this.category,
    });
}
*/
