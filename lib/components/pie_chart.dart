import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xpens/variables.dart';

class PieChartComponent extends StatelessWidget {
  PieChartComponent({super.key, required this.data});

  final Map<String, double> data;
  List<String> percentageTitles = [];

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var val in data.values) {
      total += val;
    }
    for (var val in data.values) {
      double percent = val / total * 100;
      String perct = percent.toString();
      percentageTitles
          .add("${perct.substring(0, perct.length > 5 ? 5 : perct.length)}%");
    }
    return PieChart(PieChartData(
        centerSpaceRadius: 0,
        sectionsSpace: 5,
        sections: favourite_components
            .map((item) => PieChartSectionData(
                value: data[item] ?? 0,
                radius: 100 + favourite_components.indexOf(item) + 1,
                title: percentageTitles.length == favourite_components.length
                    ? percentageTitles[favourite_components.indexOf(item)]
                    : "",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                badgeWidget: CustomBadge(icon: iconsWithLabels[item]),
                badgePositionPercentageOffset: 0.98))
            .toList()));
  }
}

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black, width: 5)),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
