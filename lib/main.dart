import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:xpens/components/bottom_navigation_bar.dart';
import 'package:xpens/pages/welcome.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  directoryPath = await fileManager.getDirectoryPath();
  directoryPath = "$directoryPath/";
  bool isHome = await File("${directoryPath}profile.json").exists();
  //Set today's date
  final now = DateTime.now().toString();
  dateToday = getDate(now);
  //Set database path
  databasePath = "${directoryPath!}xpens.db";

  //Check is accounts are added in database. If added:
  DatabaseService db = DatabaseService.instance;
  db.fetchAccounts().then((val) {
    if (val.isNotEmpty) {
      currentPageIndex = 0;
      isAccountAdded = true;
    }
  });

  if (isHome) {
    fileManager
        .readJsonFile(directoryPath!, 'profile.json')
        .then((_) => runApp(MyApp(
              widget: CustomBottomNavigationBar(
                pageIndex: currentPageIndex,
              ),
            )));
  } else {
    runApp(MyApp(
      widget: Welcome(),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});

  final Widget widget;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpens',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: widget,
      debugShowCheckedModeBanner: false,
    );
  }
}
