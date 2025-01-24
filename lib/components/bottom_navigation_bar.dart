import 'package:flutter/material.dart';
import 'package:xpens/pages/analysis_page.dart';
import 'package:xpens/pages/cards_page.dart';
import 'package:xpens/pages/home_page.dart';
import 'package:xpens/pages/profile_page.dart';
import 'package:xpens/variables.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final List<Widget> _pages = [
    HomePage(),
    CardsPage(),
    AnalysisPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 1000) {
            setState(() {
              if (currentPageIndex > 0) {
                currentPageIndex -= 1;
              }
            });
          } else if (details.velocity.pixelsPerSecond.dx < -1000) {
            setState(() {
              if (currentPageIndex != _pages.length - 1) {
                currentPageIndex += 1;
              }
            });
          }
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          // transitionBuilder: (child, animation) => SlideTransition(
          //   position: animation.drive(
          //     Tween<Offset>(
          //       begin: Offset(-1.0, 0.0),
          //       end: Offset.zero,
          //     ).chain(CurveTween(curve: Curves.easeInToLinear)),
          //   ),
          //   child: child,
          // ),
          child: _pages[currentPageIndex],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: bottomNavigationBar_height,
          margin: EdgeInsets.only(
              left: bottomNavigationBar_hmargin,
              right: bottomNavigationBar_hmargin,
              bottom: 10),
          decoration: BoxDecoration(
              color: Color(bottomNavigationBar_color).withValues(alpha: 0.8),
              borderRadius: BorderRadius.all(
                  Radius.circular(bottomNavigationBar_hmargin)),
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
                index: 0,
              ),
              NavigationItem(
                icon: Icons.attach_money_outlined,
                label: "Wallet",
                index: 1,
              ),
              NavigationItem(
                icon: Icons.analytics_outlined,
                label: "Analysis",
                index: 2,
              ),
              NavigationItem(
                icon: Icons.person_outline_outlined,
                label: "Profile",
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget NavigationItem(
      {required IconData icon, required String label, required int index}) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentPageIndex == index ? Colors.white : Colors.white70,
            size: currentPageIndex == index ? 30 : 25,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: currentPageIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          )
        ],
      ),
      onTap: () {
        setState(() {
          currentPageIndex = index;
        });
      },
    );
  }
}
