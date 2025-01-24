import 'package:flutter/material.dart';

class RecentTransactionDate extends StatelessWidget {
  const RecentTransactionDate({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(color: Colors.white70),
    );
  }
}
