import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xpens/components/favourite_component.dart';
import 'package:xpens/components/recent_transaction.dart';
import 'package:xpens/components/recent_transaction_date.dart';
import 'package:xpens/utils/card_model.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/utils/transaction_model.dart';
import 'package:xpens/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;

  bool accountIsChangedfromDropdown = false;
  String selectedAccount = "";
  String selectedAccountCardNo = "";
  double balanceAmount = 0.0;
  String date = "";

  final ScrollController _scrollController = ScrollController();
  int noOfTransactionsToBeShown = 4;

  List<AccountCard> accounts = [];
  List<AccountTransaction> transactionsList = [];

  DatabaseService db = DatabaseService.instance;

  addTransaction(String title, String category, String mode, double amount) {
    DatabaseService _db_new = DatabaseService.instance;
    _db_new.addNewTransaction(transactionTableName,
        date: dateToday,
        cardNo: selectedAccountCardNo,
        title: title,
        category: category,
        mode: mode,
        amount: amount);
    if (mode == "Transferred") {
      balanceAmount -= amount;
    } else {
      balanceAmount += amount;
    }

    db.updateBalance(selectedAccountCardNo, balanceAmount);

    date = "";
    updateRecentTransactions();
    setState(() {
      date = "";
    });
  }

  updateRecentTransactions() {
    if (transactionTableName.isNotEmpty) {
      db
          .fetchTransactions(transactionTableName, selectedAccountCardNo)
          .then((val) {
        transactionsList.clear();
        for (var item in val.reversed) {
          transactionsList.add(item);
        }
        setState(() {
          date = "";
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    date = "";

    _selectedImage = profile_url.isNotEmpty ? File(profile_url) : null;

    db.fetchAccounts().then((val) {
      accounts = val;
      balanceAmount = getBalanceFromTitle(accounts);
      selectedAccountCardNo = getCardNoFromTitle(accounts);
      for (var card in val) {
        if (card.cardNo == selectedAccountCardNo) {
          transactionTableName = "${card.title}$selectedAccountCardNo";
        }
      }

      updateRecentTransactions();
      setState(() {
        date = "";
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          date = "";
          noOfTransactionsToBeShown += 5;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header Section
            Container(
                child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white70),
                  child: Center(
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              width: 50,
                              height: 50,
                              _selectedImage!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Text(
                            userName.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          "${getMsgFromTimeofday()}, ${getNameFromUsername()}!",
                          style: TextStyle(
                              fontSize: home_page_profile_text_size,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Text("Spend Wisely, Save Smartly.")
                    ],
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            //Balance Section
            Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Your Current Balance",
                            style: TextStyle(
                                fontSize: your_current_balance_text_size,
                                color: Colors.white70),
                          ),
                          Spacer(),
                          FutureBuilder<List<AccountCard>>(
                              future: db.fetchAccounts(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  String initialVal = "";
                                  if (!accountIsChangedfromDropdown) {
                                    for (var card in snapshot.data!) {
                                      if (card.isPrimary == "Yes") {
                                        initialVal = card.title;
                                      }
                                    }
                                  }
                                  return DropdownButton(
                                      value: accountIsChangedfromDropdown
                                          ? selectedAccount
                                          : initialVal,
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.white70,
                                      ),
                                      elevation: 16,
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w700),
                                      underline: SizedBox.shrink(),
                                      onChanged: (val) {
                                        setState(() {
                                          accountIsChangedfromDropdown = true;
                                          selectedAccount = val!;
                                          balanceAmount = getBalanceFromTitle(
                                              accounts,
                                              title: selectedAccount);
                                          selectedAccountCardNo =
                                              getCardNoFromTitle(accounts,
                                                  title: selectedAccount);
                                          transactionTableName =
                                              "$selectedAccount$selectedAccountCardNo";
                                          updateRecentTransactions();
                                        });
                                      },
                                      items: [
                                        for (var card in snapshot.data!)
                                          DropdownMenuItem(
                                              value: card.title,
                                              child: Text(card.title)),
                                      ]);
                                }
                                return CircularProgressIndicator();
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: 40,
                              color: Colors.deepPurple[300],
                            ),
                            Text(
                              getFormattedAmount(balanceAmount),
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[300]),
                            ),
                          ]),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(dateToday),
                        ],
                      )
                    ])),
            SizedBox(
              height: 20,
            ),
            //Favourite Categories Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favourite Categories",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var component in favourite_components)
                          FavouriteCategory(
                            icon: iconsWithLabels[component],
                            label: component,
                            addTransaction: addTransaction,
                          ),
                        FavouriteCategory(
                          icon: Icons.add,
                          label: "Add",
                          isAddButton: true,
                          addTransaction: addTransaction,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Recent transactions section
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: transactionsList.isNotEmpty
                        ? SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...transactionsList
                                    .take(noOfTransactionsToBeShown)
                                    .map((transaction) {
                                  if (transaction.date != date) {
                                    date = transaction.date;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RecentTransactionDate(
                                            label: date == dateToday
                                                ? "Today"
                                                : date),
                                        RecentTransaction(
                                          icon: iconsWithLabels[
                                              transaction.category],
                                          title: transaction.title,
                                          category: transaction.category,
                                          amount: getFormattedAmount(
                                              transaction.amount),
                                          isReceived: transaction.isReceived,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return RecentTransaction(
                                      icon:
                                          iconsWithLabels[transaction.category],
                                      title: transaction.title,
                                      category: transaction.category,
                                      amount: getFormattedAmount(
                                          transaction.amount),
                                      isReceived: transaction.isReceived,
                                    );
                                  }
                                }).expand((widget) => widget is Column
                                        ? widget.children
                                        : [widget])
                              ],
                            ))
                        : Text(
                            "No Transaction Record found...",
                            style: TextStyle(color: Colors.white70),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
