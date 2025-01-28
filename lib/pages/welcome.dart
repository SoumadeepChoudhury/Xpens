import 'package:flutter/material.dart';
import 'package:xpens/components/data_entry_component_welcome.dart';
import 'package:xpens/components/type_writter.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepPurpleAccent,
              Colors.lightBlueAccent,
              Colors.transparent
            ], begin: Alignment.topRight, end: Alignment.bottomLeft)
                .withOpacity(0.5),
            image: DecorationImage(
                image: AssetImage("assets/img/background.jpg"),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Xpens",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                TypeWritter(
                  actualText: "Spend Wisely, Save Smartly.",
                ),
                SizedBox(height: 150),
                WelcomeDataComponent(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
