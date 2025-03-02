import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpens/components/bottom_navigation_bar.dart';
import 'package:xpens/variables.dart';

class WelcomeDataComponent extends StatefulWidget {
  const WelcomeDataComponent({super.key});

  @override
  State<WelcomeDataComponent> createState() => _WelcomeDataComponentState();
}

class _WelcomeDataComponentState extends State<WelcomeDataComponent> {
  int _counter = 0;
  TextEditingController _controller = TextEditingController();
  File? _selectedImage = null;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _counter < 2
              ? EntryField(_counter == 0 ? "name" : "email")
              : ProfileImage(),
        ),
        _counter == 2
            ? Text("Add your profile picture by cliking above.")
            : SizedBox(),
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_counter == 0) {
                      userName = _controller.text;
                    }
                    if (_counter == 1) {
                      email = _controller.text;
                    }
                    if (_counter == 2) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomBottomNavigationBar(
                                    pageIndex: 1,
                                  )));
                    }
                    if (userName.isNotEmpty || email.isNotEmpty) {
                      _controller.clear();
                      _counter++;
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.deepPurpleAccent,
                        Colors.lightBlueAccent
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Next",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  TextField EntryField(String label) {
    return TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter your $label here',
          hintStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          errorStyle: TextStyle(fontSize: 12.0, color: Colors.red),
        ));
  }

  ProfileImage() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.white70),
      child: InkWell(
        onTap: () async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image != null) {
            fileManager.copyFile(image.path, "${directoryPath}profile.jpg");
            setState(() {
              _selectedImage = File(image.path);
              profile_url = "${directoryPath}profile.jpg";
            });
          }
        },
        child: Center(
          child: _selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    width: 200,
                    height: 200,
                    _selectedImage!,
                    fit: BoxFit.fill,
                  ),
                )
              : Text(
                  userName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 100),
                ),
        ),
      ),
    );
  }
}
