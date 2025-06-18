import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget body;

  CommonScaffold({
    super.key,
    this.backgroundColor,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        extendBodyBehindAppBar: false,
        appBar: appBar,
        body: body,
      ),
    );
  }
}
