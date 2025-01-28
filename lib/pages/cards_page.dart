import 'package:flutter/material.dart';
import 'package:xpens/components/accounts.dart';
import 'package:xpens/components/primary_account_card.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/variables.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _cardNoController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();

  bool progressIndicatorTobeShown = true;

  final DatabaseService db = DatabaseService.instance;

  List<Widget> accountList = [];
  String primaryAccount = "";

  void updateUIonDelete() {
    setState(() {
      updatingAccountsList();
    });
  }

  void updatingAccountsList() {
    db.fetchAccounts().then((val) {
      if (val.isEmpty) progressIndicatorTobeShown = false;
      accountList.clear();
      String oldPrimaryCardNo = "";
      for (var cards in val) {
        if (cards.isPrimary == "Yes") {
          primaryAccount = cards.title;
          oldPrimaryCardNo = cards.cardNo;
          break;
        }
      }
      for (var cards in val) {
        accountList.add(Accounts(
          title: cards.title,
          card_no: cards.cardNo,
          isPrimary: cards.isPrimary == "Yes" ? true : false,
          onUpdate: updateUIonDelete,
          oldPrimaryCardNo: oldPrimaryCardNo,
        ));
        if (cards.isPrimary == "Yes") {
          balance = cards.balance;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updatingAccountsList();
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
            "My Cards",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          //PRIMARY ACCOUNT SELECTED
          if (accountList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Your Selected Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          if (accountList.isNotEmpty)
            PrimaryAccountCard(
                amount: getFormattedAmount(balance), account: primaryAccount),
          SizedBox(height: 20),

          // OTHER ACCOUNTS LINKED
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  "Other Accounts Linked",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurpleAccent,
                                      Colors.lightBlueAccent
                                          .withValues(alpha: 0.5)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Add Account",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        controller: _accountNameController,
                                        decoration: InputDecoration(
                                            hintText: "Enter Account Name",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70)),
                                            filled: false,
                                            fillColor: Colors.transparent,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70))),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        controller: _cardNoController,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter last 4 digit of your card.",
                                            hintMaxLines: 2,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70)),
                                            filled: false,
                                            fillColor: Colors.transparent,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70))),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        controller: _balanceController,
                                        decoration: InputDecoration(
                                            hintText: "Enter account balance",
                                            hintMaxLines: 2,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70)),
                                            filled: false,
                                            fillColor: Colors.transparent,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.white70))),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              if (_cardNoController.text !=
                                                      "" &&
                                                  _cardNoController
                                                          .text.length ==
                                                      4 &&
                                                  _accountNameController.text !=
                                                      "" &&
                                                  _balanceController.text !=
                                                      "") {
                                                db.addNewAccount(
                                                    _cardNoController.text,
                                                    _accountNameController.text,
                                                    double.parse(
                                                        _balanceController
                                                            .text),
                                                    isPrimary:
                                                        accountList.isEmpty
                                                            ? "Yes"
                                                            : "No");
                                                updatingAccountsList();
                                                _cardNoController.clear();
                                                _accountNameController.clear();
                                                _balanceController.clear();
                                                isAccountAdded = true;
                                                Navigator.pop(context);
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(Colors
                                                      .deepPurple
                                                      .withValues(alpha: 0.3)),
                                              padding: WidgetStateProperty.all(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8)),
                                              shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white70),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            child: Text(
                                              "Add",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.deepPurple],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Add",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (accountList.isEmpty && progressIndicatorTobeShown)
            Container(
                height: 100,
                child: Center(child: CircularProgressIndicator.adaptive()))
          else
            for (var widget in accountList) widget,
        ],
      ),
    ));
  }
}
