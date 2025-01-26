import 'package:flutter/material.dart';
import 'package:xpens/components/bar_chart.dart';
import 'package:xpens/components/custom_button_group_selection_month_week_etc.dart';
import 'package:xpens/components/line_chart.dart';
import 'package:xpens/components/pie_chart.dart';
import 'package:xpens/variables.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

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
                DropdownButton<String>(
                    value: "Savings",
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white70,
                    ),
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w700),
                    underline: SizedBox.shrink(),
                    onChanged: (String? newValue) {},
                    items: [
                      DropdownMenuItem(
                          value: "Savings", child: Text("Savings")),
                      DropdownMenuItem(
                          value: "UPI Lite", child: Text("UPI Lite"))
                    ]),
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
                        balance_amount,
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
                SelectionButton(label: "Week"),
                SelectionButton(
                  label: "Month",
                  isSelected: true,
                ),
                SelectionButton(label: "6 Months"),
                SelectionButton(label: "Year"),
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
                    value: "line",
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white70,
                    ),
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w700),
                    underline: SizedBox.shrink(),
                    onChanged: (String? newValue) {},
                    items: [
                      DropdownMenuItem(value: "bar", child: Text("Bar Graph")),
                      DropdownMenuItem(
                          value: "line", child: Text("Line Graph")),
                      DropdownMenuItem(value: "pie", child: Text("Pie Graph"))
                    ]),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 12),
                height: 300,
                child: LineChartComponent())
          ],
        ),
      ),
    );
  }
}
