import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartComponent extends StatelessWidget {
  const LineChartComponent({super.key});

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
                  if (meta.formattedValue == "1") {
                    return Text("Food");
                  } else if (meta.formattedValue == "2") {
                    return Text("Grocery");
                  } else if (meta.formattedValue == "3") {
                    return Text("Education");
                  } else if (meta.formattedValue == "4") {
                    return Text("Sports");
                  } else {
                    return Text("");
                  }
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
                spots: [
                  FlSpot(1, 1000),
                  FlSpot(2, 2000),
                  FlSpot(3, 400),
                  FlSpot(4, 700),
                ])
          ])),
    );
  }
}
