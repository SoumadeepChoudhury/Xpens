import 'package:flutter/material.dart';

class PrimaryAccountCard extends StatelessWidget {
  const PrimaryAccountCard(
      {super.key, required this.amount, required this.account});

  final String amount;
  final String account;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.currency_rupee,
                    size: 40,
                  ),
                  Text(
                    amount,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [Text(account), Spacer(), Text("Primary")],
            )
          ],
        ),
      ),
    );
  }
}
