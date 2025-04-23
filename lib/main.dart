import 'package:flutter/material.dart';
import 'package:budget/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MVVM App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      routerConfig: goRouter, // 直接 goRouter を渡す
    );
  }
}