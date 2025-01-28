import 'package:flutter/material.dart';
import 'package:xpens/variables.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction(
      {super.key,
      required this.icon,
      required this.title,
      required this.category,
      required this.amount,
      required this.isReceived});

  final IconData icon;
  final String title;
  final String category;
  final String amount;
  final bool isReceived;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Row(
        children: [
          //Icon
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),

          //Column -> title / Category
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  category,
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          //Spacer
          Spacer(),

          //Amount
          Row(
            children: [
              Text(
                isReceived ? "+" : "-",
                style: TextStyle(
                    color:
                        isReceived ? amount_added_color : amount_deducted_color,
                    fontSize: 20),
              ),
              Icon(
                Icons.currency_rupee,
                color: isReceived ? amount_added_color : amount_deducted_color,
              ),
              Text(
                amount,
                style: TextStyle(
                    color:
                        isReceived ? amount_added_color : amount_deducted_color,
                    fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
