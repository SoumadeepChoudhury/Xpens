import 'package:flutter/material.dart';
import 'components/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpens',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: CustomBottomNavigationBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
