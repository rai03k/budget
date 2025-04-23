import 'package:budget/views/input_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:budget/views/budget_page.dart';
import 'package:budget/views/calendar_page.dart';
import 'package:budget/views/goal_page.dart';
import 'package:budget/views/home_page.dart';

final goRouter = GoRouter(
  initialLocation: '/home', // アプリ起動時の初期画面
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // BottomNavigationBarを表示する共通の画面
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/budget',
              name: 'budget',
              builder: (context, state) => const BudgetPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              name: 'calendar',
              builder: (context, state) => const CalendarPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/input',
              name: 'input',
              builder: (context, state) => const InputPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/goal',
              name: 'goal',
              builder: (context, state) => const GoalPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: ''),
            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 20, // アイコンを囲む円の半径
                    backgroundColor: Colors.black, // 円の色
                  ),
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white, // 中央のアイコンの色
                    size: 24, // 中央のアイコンのサイズ
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.flag), label: ''),
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
