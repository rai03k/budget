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
          items: [
            _buildAnimatedNavItem(Icons.home, 0),
            _buildAnimatedNavItem(Icons.pie_chart, 1),
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
            _buildAnimatedNavItem(Icons.add, 3),
            _buildAnimatedNavItem(Icons.flag, 4),
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedNavItem(IconData icon, int index) {
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
            scale:
                navigationShell.currentIndex == index
                    ? 1.0 -
                        0.2 *
                            (1.0 - value) // タップ時に1.2倍になり元に戻る
                    : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                color:
                    navigationShell.currentIndex == index
                        ? Colors.black
                        : Colors.grey,
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
