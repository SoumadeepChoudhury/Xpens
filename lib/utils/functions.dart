import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:xpens/utils/card_model.dart';
import 'package:xpens/utils/transaction_model.dart';
import 'package:xpens/variables.dart';

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

getFormattedAmount(double amount) {
  int counter = 3;
  int index = amount.toString().indexOf(".");
  String refinedAmount = amount.toString().substring(0, index);
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
  return finalAmount + amount.toString().substring(index);
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
    List<AccountTransaction> accounts, String dateUptoWhichFilter) {
  List<AccountTransaction> filteredList = [];
  for (var acc in accounts) {
    if (acc.date == dateUptoWhichFilter) {
      break;
    }
    filteredList.add(acc);
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

void openUPIPayment({
  required double amount,
  required String title,
  String upiid = "",
  String payeename = "",
  String qrData = "",
}) async {
  AndroidIntent? intent;
  if (qrData.isNotEmpty) {
    intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: "$qrData&am=$amount&cu=INR&tn=$title",
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
  } else if (upiid.isNotEmpty) {
    intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: "upi://pay?pa=$upiid&pn=$payeename&am=$amount&cu=INR&tn=$title",
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
  }
  if (intent != null) {
    await intent.launch();
  }
}

bool isValidDecimal(String input) {
  final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
  return regex.hasMatch(input);
}
