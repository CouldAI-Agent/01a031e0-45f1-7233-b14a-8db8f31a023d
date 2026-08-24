import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/compose_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HeartSpaceApp());
}

class HeartSpaceApp extends StatelessWidget {
  const HeartSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartSpace',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/compose': (context) => const ComposeScreen(),
      },
    );
  }
}
