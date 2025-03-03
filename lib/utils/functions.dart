import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xpens/utils/card_model.dart';
import 'package:xpens/utils/transaction_model.dart';
import 'package:xpens/variables.dart';
import 'package:http/http.dart' as http;

getNameFromUsername() {
  if (userName.contains(" ")) {
    return userName.substring(0, userName.indexOf(" "));
  } else {
    return userName;
  }
}

getDate(var now) {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final year = now.substring(0, 4);
  final month = int.parse(now.substring(5, 7));
  final date = now.substring(8, 10);
  return "${months[month - 1]} $date, $year";
}

DateTime parseCustomDate(String dateStr) {
  Map<String, int> monthMap = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12,
  };
  List<String> parts = dateStr.split(' '); // ["March", "03,", "2025"]
  int month = monthMap[parts[0]]!; // Convert month name to number
  int day = int.parse(parts[1].replaceAll(',', '')); // Remove comma
  int year = int.parse(parts[2]);

  return DateTime(year, month, day);
}

getFormattedAmount(double amount) {
  String _amount = amount.toStringAsFixed(2);
  int counter = 3;
  int index = _amount.indexOf(".");
  String refinedAmount = _amount.substring(0, index);
  String finalAmountReversed = "";
  String finalAmount = "";
  for (int i = refinedAmount.length - 1; i >= 0; i--) {
    finalAmountReversed += refinedAmount[i];
    if (finalAmountReversed.length == counter && i != 0) {
      finalAmountReversed += ",";
      counter *= 2;
    }
  }
  for (int i = finalAmountReversed.length - 1; i >= 0; i--) {
    finalAmount += finalAmountReversed[i];
  }
  return finalAmount + _amount.substring(index);
}

//get the balance from title and if title not mentioned get the balance of the primary account
getBalanceFromTitle(List<AccountCard> accounts, {String title = ""}) {
  if (title.isEmpty) {
    for (var cards in accounts) {
      if (cards.isPrimary == "Yes") {
        return cards.balance;
      }
    }
  } else {
    if (title.isNotEmpty) {
      for (var cards in accounts) {
        if (cards.title == title) {
          return cards.balance;
        }
      }
    }
  }
}

getCardNoFromTitle(List<AccountCard> accounts, {String title = ""}) {
  if (title.isEmpty) {
    for (var cards in accounts) {
      if (cards.isPrimary == "Yes") {
        return cards.cardNo;
      }
    }
  } else {
    if (title.isNotEmpty) {
      for (var cards in accounts) {
        if (cards.title == title) {
          return cards.cardNo;
        }
      }
    }
  }
}

getTransactionTableName(String cardNo, String accountName) {
  return "$accountName$cardNo";
}

Map<String, String> getDateRange(String option) {
  final DateTime today = DateTime.now();
  DateTime startDate;
  DateTime endDate = today;

  switch (option.toLowerCase()) {
    case 'week':
      startDate = today.subtract(Duration(days: today.weekday - 1));
      break;
    case 'month':
      startDate = DateTime(today.year, today.month, 1);
      break;
    case '6 months':
      final monthBefore6Months = today.month - 6;
      startDate = (monthBefore6Months < 1)
          ? DateTime(today.year - 1, today.month + (12 - 6), 1)
          : DateTime(today.year, monthBefore6Months, 1);
      break;
    case 'year':
      startDate = DateTime(today.year, 1, 1);
      break;
    default:
      startDate = today;
  }
  return {
    "start": getDate(startDate.toString()),
    "end": getDate(endDate.toString())
  };
}

List<AccountTransaction> getFilteredList(
    List<AccountTransaction> accounts, String startDate) {
  List<AccountTransaction> filteredList = [];
  DateTime formattedStartdate = parseCustomDate(startDate);
  bool started = false;
  for (var acc in accounts) {
    DateTime formattedDate = parseCustomDate(acc.date);
    if (!formattedDate.isBefore(formattedStartdate)) {
      started = true;
    }
    if (started) filteredList.add(acc);
  }
  return filteredList;
}

getMsgFromTimeofday() {
  String dt = DateTime.now().toString();
  String ft = dt.substring(11);
  String time = ft.substring(0, ft.indexOf(".") - 3); //19:48

  final msgs = ["Good Morning", "Good Afternoon", "Good Evening"];
  int hr = int.parse(time.substring(0, time.indexOf(":")));
  int min = int.parse(time.substring(time.indexOf(":") + 1));

  List<int> setHr = [12, 16, 24];
  List<int> setMin = [0, 30, 0];

  for (int i = 0; i < msgs.length; i++) {
    if (hr == setHr[i] ? min <= setMin[i] : hr <= setHr[i]) {
      return msgs[i];
    }
  }
  return "";
}

String generateTransactionID() {
  DateTime now = DateTime.now();
  String timestamp = now.millisecondsSinceEpoch.toString();
  String randomPart =
      (1000 + (9999 - 1000) * (DateTime.now().microsecondsSinceEpoch % 1000))
          .toString();

  return "TXN$timestamp$randomPart"; // Example: TXN1706713401123456
}

void openUPIPayment({
  required double amount,
  required String title,
  String upiid = "",
  String payeename = "",
  String qrData = "",
}) async {
  // String tid_tr = generateTransactionID();
  // AndroidIntent? intent;
  // if (qrData.isNotEmpty) {
  //   intent = AndroidIntent(
  //     action: 'android.intent.action.VIEW',
  //     data: "$qrData&am=$amount&cu=INR&tn=$title&tid=$tid_tr&tr=$tid_tr",
  //     flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
  //   );
  // } else if (upiid.isNotEmpty) {
  //   intent = AndroidIntent(
  //     action: 'android.intent.action.VIEW',
  //     data:
  //         "upi://pay?pa=$upiid&pn=$payeename&am=$amount&cu=INR&tn=$title&tid=$tid_tr&tr=$tid_tr",
  //     package: 'com.google.android.apps.nbu.paisa.user',
  //     flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
  //   );
  // }
  // if (intent != null) {
  //   // await intent.launch();
  // }
  // String url =
  //     "intent://upi/#Intent;scheme=upi;package=com.google.android.apps.nbu.paisa.user;component=com.google.android.apps.nbu.paisa.user/com.google.android.apps.nbu.paisa.user.activities.MainActivity;end;";

  // if (await canLaunchUrl(Uri.parse(url))) {
  //   await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  // }
  // final intent = AndroidIntent(
  //   action: 'android.intent.action.VIEW',
  //   package: 'com.google.android.apps.nbu.paisa.user',
  //   componentName:
  //       'com.google.android.apps.nbu.paisa.user/com.google.android.apps.nbu.paisa.user.ui.HomeActivity',
  //   flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
  // );
  // intent.launch();
}

bool isValidDecimal(String input) {
  final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
  return regex.hasMatch(input);
}

void checkUpdate(BuildContext context) async {
  String path = (await getExternalStorageDirectory())?.path ??
      "/storage/emulated/0/Download";
  File file = File("$path/app-release-v$VERSION.apk");
  if (await file.exists()) {
    try {
      await file.delete();
    } on FileSystemException catch (_) {
      print("Can't delete the file");
    }
  }
  File file1 = File("$path/app-release-v$VERSION-vcc.apk");
  if (await file1.exists()) {
    try {
      await file1.delete();
    } on FileSystemException catch (_) {
      print("Can't delete the file");
    }
  }
  final response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/SoumadeepChoudhury/Xpens/refs/heads/main/VERSION_TRACKER.txt"));
  if (response.statusCode == 200) {
    String data = response.body;
    String url = "";
    String version = "";
    //NEW
    List versions = data.split("\n");
    String latest = versions[versions.length - 1];
    List latest_split = latest.split("/");
    String latestVersion = latest_split[0].replaceAll("v", "");
    String latestVersionCode = latest_split[1];
    if (VERSION != latestVersion) {
      url =
          "https://github.com/SoumadeepChoudhury/Xpens/releases/download/v$latestVersion/app-release.apk";
      version = latestVersion;
    } else {
      if (VC != latestVersionCode) {
        url =
            "https://github.com/SoumadeepChoudhury/Xpens/releases/download/v$VERSION/app-release.apk";
        version = "$latestVersion-vcc";
      }
    }

    //OLD
    // if (data.endsWith(VERSION) || data.endsWith("$VERSION\n")) {
    //   return;
    // }
    // if (data.endsWith("VCC\n") || data.endsWith("VCC")) {
    //   version = "$VERSION-vcc";
    //   print(data.split("\n").length);
    //   url =
    //       "https://github.com/SoumadeepChoudhury/Xpens/releases/download/v$VERSION/app-release.apk";
    // } else {
    //   data = data.replaceAll(data.substring(0, data.indexOf(VERSION)), "");
    //   data = data.replaceAll("$VERSION\nv", "");
    //   version = data;
    //   if (version.endsWith("\n")) {
    //     version = version.replaceAll("\n", "");
    //   }
    //   url =
    //       "https://github.com/SoumadeepChoudhury/Xpens/releases/download/v$version/app-release.apk";
    // }
    if (url.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "New Update Available",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: Duration(days: 1),
          action: SnackBarAction(
              label: "Download",
              onPressed: () async {
                String? taskId =
                    await downloadAndInstallAPK(url, version, context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Automatically installation will start..\nIf not, Check notification... After download completes, click it to install.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    duration: Duration(seconds: 10),
                    action: SnackBarAction(
                        label: "Cancel",
                        onPressed: () async {
                          await FlutterDownloader.cancel(taskId: taskId!);
                        }),
                  ),
                );
              }),
        ),
      );
    }
  } else {
    print("Fail");
  }
}

Future<String?> downloadAndInstallAPK(
    String apkUrl, String version, BuildContext context) async {
  // Request storage permission
  if (await Permission.manageExternalStorage.request().isGranted ||
      await Permission.storage.request().isGranted) {
    final savePath = (await getExternalStorageDirectory())?.path ??
        "/storage/emulated/0/Download";
    final fileName = "app-release-v$version.apk";

    if (await Permission.notification.request().isGranted) {
      // Track download completion
      FlutterDownloader.registerCallback(MyDownloader.downloadCallback);

      // Start downloading
      String? taskId = await FlutterDownloader.enqueue(
        url: apkUrl,
        savedDir: savePath,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      return taskId;
    }
  } else {
    return null;
  }
}

class MyDownloader {
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) async {
    print("$status -> $progress");
    if (progress == 100) {
      print("Downlaod completed");
      // String? filePath = await getDownloadPath();
      // print(filePath);
      // if (filePath != null) {
      // File file = File(
      //     "/storage/emulated/0/Android/data/com.example.xpens-debug/files/");
      // try {
      //   OpenFilex.open(file.path);
      // } catch (e) {
      //   print("Can't open file");
      // }
      // }
    }
  }
}
