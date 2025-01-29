import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xpens/variables.dart';

class TypeWritter extends StatefulWidget {
  const TypeWritter({super.key, required this.actualText});

  final String actualText;

  @override
  State<TypeWritter> createState() => _TypeWritterState();
}

class _TypeWritterState extends State<TypeWritter> {
  late int _length;
  late bool _isForward;
  late Timer timer;
  String text = "";
  @override
  void initState() {
    _length = 0;
    _isForward = true;
    timer = Timer.periodic(Duration(milliseconds: 150), (_) {
      if (_isForward) {
        if (_length < widget.actualText.length) {
          _length += 1;
        } else {
          _isForward = false;
        }
      } else {
        if (_length > 0) {
          _length -= 1;
        } else {
          _isForward = true;
        }
      }
      setState(() {
        text = widget.actualText.substring(0, _length);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    //Cancelling the timer
    timer.cancel();

    // Creating the JSON file and writing it
    jsonData = {
      "name": userName,
      "email": email,
      "profile_url":
          profile_url.isNotEmpty ? "${directoryPath}profile.jpg" : "",
    };

    fileManager.writeJsonFile(jsonData, directoryPath!, "profile.json");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text|",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }
}
