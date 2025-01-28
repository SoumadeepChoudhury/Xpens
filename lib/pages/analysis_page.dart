import 'package:flutter/material.dart';

import 'package:xpens/components/custom_button_group_selection_month_week_etc.dart';

import 'package:xpens/utils/card_model.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/utils/graph_handlers.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final DatabaseService db = DatabaseService.instance;
  String selectedAccount = "";
  String selectedAccountCardNo = "";
  double balanceAmount = 0.0;
  List<AccountCard> accountList = [];
  String selectedLabel = "Month";
  String selectedGraphType = 'line';

  @override
  void initState() {
    super.initState();
    db.fetchAccounts().then((accountsList) {
      for (var account in accountsList) {
        if (account.isPrimary == "Yes") {
          balanceAmount = account.balance;
          selectedAccount = account.title;
          selectedAccountCardNo = account.cardNo;
        }
      }
      accountList.addAll(accountsList);
      setState(() {});
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
            Text(
              "Analysis",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "Your Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                DropdownButton(
                    value: selectedAccount,
                    hint: Text("Accounts"),
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white70,
                    ),
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w700),
                    underline: SizedBox.shrink(),
                    onChanged: (val) {
                      setState(() {
                        selectedAccount = val!;
                        for (var account in accountList) {
                          if (account.title == selectedAccount) {
                            balanceAmount = account.balance;
                            selectedAccountCardNo = account.cardNo;
                          }
                        }
                      });
                    },
                    items: [
                      for (var acc in accountList)
                        DropdownMenuItem(
                          child: Text(acc.title),
                          value: acc.title,
                        )
                    ])
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        size: 40,
                      ),
                      Text(
                        getFormattedAmount(balanceAmount),
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    "Available Balance",
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),
            //WEEk,MONTH,HALF_YEARLY,ANNUALLY
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectionButton(
                  label: "Week",
                  isSelected: selectedLabel == "Week",
                  onTap: () {
                    setState(() {
                      selectedLabel = "Week";
                    });
                  },
                ),
                SelectionButton(
                  label: "Month",
                  isSelected: selectedLabel == "Month",
                  onTap: () {
                    setState(() {
                      selectedLabel = "Month";
                    });
                  },
                ),
                SelectionButton(
                    label: "6 Months",
                    isSelected: selectedLabel == "6 Months",
                    onTap: () {
                      setState(() {
                        selectedLabel = "6 Months";
                      });
                    }),
                SelectionButton(
                  label: "Year",
                  isSelected: selectedLabel == "Year",
                  onTap: () {
                    setState(() {
                      selectedLabel = "Year";
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Graph Type",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                DropdownButton<String>(
                    value: selectedGraphType,
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white70,
                    ),
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w700),
                    underline: SizedBox.shrink(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGraphType = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(value: "bar", child: Text("Bar Graph")),
                      DropdownMenuItem(
                          value: "line", child: Text("Line Graph")),
                      DropdownMenuItem(value: "pie", child: Text("Pie Graph"))
                    ]),
              ],
            ),
            if (selectedAccount.isEmpty)
              Center(child: CircularProgressIndicator.adaptive()),
            if (selectedAccount.isNotEmpty)
              Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 300,
                  child: Graph(
                    key: ValueKey(selectedAccount),
                    selectedGraphType: selectedGraphType,
                    tableName: getTransactionTableName(
                        selectedAccountCardNo, selectedAccount),
                    selectedlabel: selectedLabel,
                  ))
          ],
        ),
      ),
    );
  }
}
