import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xpens/utils/file_manager.dart';

String VERSION = "1.1.0";

bool isAccountAdded = false;

double bottomNavigationBar_height = 56;
double bottomNavigationBar_padding = 12;
double bottomNavigationBar_hmargin = 20;
int bottomNavigationBar_color = 0x220033;
int currentPageIndex = 1;
double home_page_profile_icon_size = 50;
double home_page_profile_text_size = 20;
double your_current_balance_text_size = 15;

Color amount_deducted_color = Color.fromARGB(255, 244, 54, 127);
Color amount_added_color = Colors.green;

List<String> favourite_components = [
  "Food",
  "Grocery",
  "Education",
  "Sports",
  "Travel",
  "Other"
];

Map<String, dynamic> iconsWithLabels = {
  "Food": Icons.fastfood,
  "Grocery": Icons.local_grocery_store,
  "Education": Icons.book,
  "Sports": Icons.sports_tennis,
  "Travel": Icons.mode_of_travel_rounded,
  "Other": Icons.error_outline_sharp
};

double balance = 0.0;

String userName = "";
String email = "";
String profile_url = "";
FileManager fileManager = FileManager();
String? directoryPath = "";
String fileName = "xpens-profile.json";
Map<String, String> jsonData = {};
String dateToday = "";

String databasePath = "";
String accountTableName = "accounts";
String transactionTableName = "";

String accountTableAccountColumnName = "account";
String accountTableCardNoColumnName = "card_no";
String accountTableisPrimaryColumnName = "isPrimary";
String accountTableBalanceColumnName = "balance";

String transactionTableSlNoColumnName = "slno";
String transactionTableDateColumnName = "date";
String transactionTableCardNoColumnName = "card_no";
String transactionTableTitleColumnName = "title";
String transactionTableCategoryColumnName = "Category";
String transactionTableAmountColumnName = "amount";
String transactionTableModeColumnName = "mode";
