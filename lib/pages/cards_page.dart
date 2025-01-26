import 'package:flutter/material.dart';
import 'package:xpens/components/accounts.dart';
import 'package:xpens/components/primary_account_card.dart';
import 'package:xpens/variables.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

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
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Your Selected Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          PrimaryAccountCard(amount: balance_amount, account: "SBI"),
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
                Container(
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
                )
              ],
            ),
          ),
          Accounts(title: "SBI", isPrimary: true),
          Accounts(title: "UPI Lite"),
        ],
      ),
    ));
  }
}
