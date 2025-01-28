import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xpens/variables.dart';

class LineChartComponent extends StatelessWidget {
  const LineChartComponent({super.key, required this.data});

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: LineChart(LineChartData(
          minY: 0,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                      favourite_components[int.parse(meta.formattedValue)]);
                },
              )),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false))),
          lineBarsData: [
            LineChartBarData(
                isCurved: true,
                gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.deepPurpleAccent]),
                barWidth: 2.5,
                belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                            colors: [Colors.lightBlue, Colors.deepPurpleAccent])
                        .withOpacity(0.4)),
                spots: favourite_components
                    .map((item) => FlSpot(
                        favourite_components.indexOf(item) * 1.0,
                        data[item] ?? 0))
                    .toList())
          ])),
    );
  }
}
