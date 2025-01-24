import 'package:flutter/material.dart';

class FavouriteCategory extends StatelessWidget {
  const FavouriteCategory(
      {super.key,
      required this.icon,
      required this.label,
      this.isAddButton = false});

  final IconData icon;
  final String label;
  final bool isAddButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: !isAddButton
                ? BoxDecoration(
                    color: Color.fromARGB(255, 241, 178, 255),
                    shape: BoxShape.circle,
                    boxShadow: [
                        BoxShadow(
                            color:
                                Colors.deepPurpleAccent.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 0.1,
                            offset: Offset(6.5, 12))
                      ])
                : BoxDecoration(),
            child: Icon(
              icon,
              size: 35,
              color: !isAddButton
                  ? Color.fromARGB(255, 209, 0, 251)
                  : Colors.white70,
            ),
          ),
          SizedBox(height: 8), // Space between the icon and text
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: !isAddButton ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
