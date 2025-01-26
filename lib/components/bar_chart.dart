import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartComponent extends StatelessWidget {
  const BarChartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (meta.formattedValue == "0") {
                  return Text("Food");
                } else {
                  return Text("Sports");
                }
              },
            )),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 400,
                width: 15,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: 400,
                width: 15,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
                toY: 400,
                width: 15,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(
                toY: 400,
                width: 15,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ]),
        ]));
  }
}
