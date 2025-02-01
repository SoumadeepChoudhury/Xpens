import 'package:flutter/material.dart';
import 'package:xpens/components/bar_chart.dart';
import 'package:xpens/components/line_chart.dart';
import 'package:xpens/components/pie_chart.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/variables.dart';

class Graph extends StatefulWidget {
  Graph(
      {super.key,
      required this.selectedGraphType,
      required this.tableName,
      required this.selectedlabel});

  final String selectedGraphType;
  final String tableName;
  final String selectedlabel;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  Map<String, double> transactionRecords = {};

  @override
  void initState() {
    super.initState();

    for (var category in favourite_components) {
      DatabaseService db = DatabaseService.instance;
      db
          .getSpecificTransactions(widget.tableName, category)
          .then((accountsList) {
        Map<String, String> filterDate =
            getDateRange(widget.selectedlabel.toString());
        final accounts =
            getFilteredList(accountsList, filterDate["start"] ?? "");
        transactionRecords[category] = 0;
        for (var account in accounts) {
          transactionRecords[category] =
              transactionRecords[category]! + account.amount;
        }
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (transactionRecords.isNotEmpty) {
      return widget.selectedGraphType == 'line'
          ? LineChartComponent(
              data: transactionRecords,
            )
          : (widget.selectedGraphType == 'bar'
              ? BarChartComponent(
                  data: transactionRecords,
                )
              : PieChartComponent(data: transactionRecords));
    }
    return CircularProgressIndicator.adaptive();
  }
}
