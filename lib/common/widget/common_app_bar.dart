import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
    this.tabBar,
  });

  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final TabBar? tabBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: leading,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      bottom: tabBar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (tabBar?.preferredSize.height ?? 0),
      );
}
