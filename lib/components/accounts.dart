import 'package:flutter/material.dart';
import 'package:xpens/utils/database.dart';

class Accounts extends StatelessWidget {
  Accounts(
      {super.key,
      required this.title,
      required this.card_no,
      required this.onUpdate,
      required this.oldPrimaryCardNo,
      this.isPrimary = false});

  final String title;
  final bool isPrimary;
  final String card_no;
  final Function onUpdate;
  final String oldPrimaryCardNo;

  final DatabaseService db = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                colors: [Colors.white, const Color.fromARGB(173, 124, 71, 135)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Row(
          children: [
            Icon(
              Icons.assured_workload_outlined,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      "xxxxxxxx$card_no",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    if (isPrimary)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Primary",
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      )
                  ],
                )
              ],
            ),
            Spacer(),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz, size: 30, color: Colors.black),
              onSelected: (value) {
                if (value == 'make_primary') {
                  db.updatePrimaryAccount(oldPrimaryCardNo, card_no);
                  onUpdate();
                } else if (value == 'delete') {
                  if (isPrimary) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Can't delete when the account is Primary. In order to delete, make other account primary and then delete this account.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        duration: Duration(seconds: 4),
                      ),
                    );
                  } else {
                    db.deleteAccount(card_no);
                    onUpdate();
                  }
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'make_primary',
                  child: Text("Make Primary"),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
