import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton(
      {super.key, required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [Colors.blueAccent, Colors.deepPurpleAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)
                : null,
            border: !isSelected
                ? Border.all(
                    color: Colors.white70.withValues(alpha: 0.3), width: 2)
                : null,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
