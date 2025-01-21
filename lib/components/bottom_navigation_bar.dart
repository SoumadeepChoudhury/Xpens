import 'package:flutter/material.dart';
import 'package:xpens/variables.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
          child: Container(
        height: bottomNavigationBar_height,
        margin: EdgeInsets.symmetric(
            horizontal: bottomNavigationBar_hmargin, vertical: 5),
        decoration: BoxDecoration(
            color: Color(bottomNavigationBar_color).withValues(alpha: 0.8),
            borderRadius:
                BorderRadius.all(Radius.circular(bottomNavigationBar_hmargin)),
            boxShadow: [
              BoxShadow(
                  color:
                      Color(bottomNavigationBar_color).withValues(alpha: 0.3),
                  offset: Offset(-10, 20),
                  blurRadius: bottomNavigationBar_hmargin)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationItem(
              icon: Icons.home_outlined,
              label: "Home",
            ),
            NavigationItem(
              icon: Icons.attach_money_outlined,
              label: "Wallet",
            ),
            NavigationItem(
              icon: Icons.add,
              label: "Add",
            ),
            NavigationItem(
              icon: Icons.analytics_outlined,
              label: "Analysis",
            ),
            NavigationItem(
              icon: Icons.person_outline_outlined,
              label: "Profile",
            ),
          ],
        ),
      )),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
