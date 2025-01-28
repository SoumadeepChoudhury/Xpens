import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:xpens/variables.dart';

class BarChartComponent extends StatelessWidget {
  const BarChartComponent({super.key, required this.data});

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  favourite_components[int.parse(meta.formattedValue)],
                  overflow: TextOverflow.ellipsis,
                );
              },
            )),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: favourite_components
            .map((item) => BarChartGroupData(
                    x: favourite_components.indexOf(item),
                    barRods: [
                      BarChartRodData(
                          toY: data[item] ?? 0,
                          width: 30,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6)))
                    ]))
            .toList()));
  }
}
