import 'dart:ui';

import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/views/budget/budget_page.dart';
import 'package:budget/views/calendar/calendar_page.dart';
import 'package:budget/views/category_create/category_create_page.dart';
import 'package:budget/views/category_edit/category_edit_page.dart';
import 'package:budget/views/category_edit/category_list_page.dart';
import 'package:budget/views/home/home_page.dart';
import 'package:budget/views/input/input_page.dart';
import 'package:budget/views/input/receipt_scanner/receipt_scanner_page.dart';
import 'package:budget/views/input/scanner_result/scanner_result_page.dart';
import 'package:budget/views/savings/savings_screen.dart';
import 'package:budget/views/settings/settings_page.dart';
import 'package:budget/views/weekly_expense_review/weekly_expense_review_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'common/enum/app_colors.dart';
import 'common/enum/app_icon.dart';
import 'common/routes/app_routes.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.input, // アプリ起動時の初期画面
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.budget,
              name: AppRoutes.budget,
              builder: (context, state) => const BudgetPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.input,
              name: AppRoutes.input,
              pageBuilder: (context, state) {
                // ★★★ このpageBuilder内を修正 ★★★

                // 1. extraをチェックして、上から下への遷移かを判断
                final isSlideDown = state.extra == 'from_scanner';

                if (isSlideDown) {
                  // 2. extraが'from_scanner'なら、上から下へのスライドアニメーションを返す
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const InputPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // 上から下へのアニメーション
                      const begin = Offset(0.0, -1.0); // 画面の上外から開始
                      const end = Offset.zero; // 画面の中央へ
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: Curves.easeOutCubic));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  );
                } else {
                  // 3. それ以外の場合は、これまで通りのフェードアニメーションを返す
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const InputPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // FadeTransition を使ってフェードイン・フェードアウトさせる
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.calendar,
              name: AppRoutes.calendar,
              builder: (context, state) => const CalendarPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              name: AppRoutes.settings,
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.recipeScanner, // 例: '/scanner'
      name: AppRoutes.recipeScanner,
      // ★要件2: 下から上へのスライドアニメーション
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ReceiptScannerPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            return SlideTransition(
                position: animation.drive(tween), child: child);
          },
        );
      },
    ),
    GoRoute(
      path: AppRoutes.scannerResult,
      name: AppRoutes.scannerResult,
      // ★要件3: builderを使い、デフォルトの横スライドアニメーションにする
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: ScannerResultPage(),
        );
      },
    ),
    // 週間レビューページのルート
    GoRoute(
      path: '/weekly-review',
      name: 'weekly-review',
      builder: (context, state) => const WeeklyExpenseReviewPage(),
    ),
    // 節約結果画面のルート
    GoRoute(
      path: '/savings',
      name: 'savings',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return SavingsScreen(
          emojis: extra['emojis'] as List<String>,
          totalSavings: extra['totalSavings'] as double,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.categoryEdit,
      name: AppRoutes.categoryEdit,
      builder: (context, state) => CategoryEditPage(),
    ),
    GoRoute(
      path: AppRoutes.categoryList,
      name: AppRoutes.categoryList,
      builder: (context, state) => CategoryListPage(),
    ),
    GoRoute(
      path: AppRoutes.categoryCreate,
      name: AppRoutes.categoryCreate,
      builder: (context, state) => CategoryCreatePage(),
    ),
  ],
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              items: [
                _buildAnimatedNavItem(AppIcon.home, 0),
                _buildAnimatedNavItem(AppIcon.chart, 1),
                BottomNavigationBarItem(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22, // アイコンを囲む円の半径
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary, // 円の色
                      ),
                      HugeIcon(
                        icon: AppIcon.plus.iconData,
                        color:
                            Theme.of(context).colorScheme.primary, // 中央のアイコンの色
                        size: 26, // 中央のアイコンのサイズ
                      ),
                    ],
                  ),
                  label: '',
                ),
                _buildAnimatedNavItem(AppIcon.calendar, 3),
                _buildAnimatedNavItem(AppIcon.setting, 4),
              ],
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedNavItem(AppIcon icon, int index) {
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: navigationShell.currentIndex == index ? 1.0 : 0.0,
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: navigationShell.currentIndex == index
                ? 1.0 - 0.2 * (1.0 - value) // タップ時に1.2倍になり元に戻る
                : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              child: HugeIcon(
                icon: icon.iconData,
                color: navigationShell.currentIndex == index
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
                size: navigationShell.currentIndex == index ? 28 : 24,
              ),
            ),
          );
        },
      ),
      label: '',
    );
  }
}
