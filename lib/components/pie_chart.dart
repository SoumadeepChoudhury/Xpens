import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartComponent extends StatelessWidget {
  const PieChartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(centerSpaceRadius: 0, sectionsSpace: 5, sections: [
      PieChartSectionData(
          value: 1000,
          radius: 101.0,
          title: "25%",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          badgeWidget: CustomBadge(icon: Icons.fastfood),
          badgePositionPercentageOffset: 0.98),
      PieChartSectionData(
          value: 2000,
          radius: 106.0,
          title: "50%",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          badgeWidget: CustomBadge(icon: Icons.sports_tennis),
          badgePositionPercentageOffset: 0.98),
      PieChartSectionData(
          value: 400,
          radius: 111.0,
          title: "10%",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          badgeWidget: CustomBadge(icon: Icons.book),
          badgePositionPercentageOffset: 0.98),
      PieChartSectionData(
          value: 600,
          radius: 116.0,
          title: "15%",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          badgeWidget: CustomBadge(icon: Icons.local_grocery_store),
          badgePositionPercentageOffset: 0.98),
    ]));
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
