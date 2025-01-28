import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpens/variables.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _selectedImage = File(profile_url);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header -> Profile Image, Name, Email
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      fileManager.copyFile(
                          image.path, "${directoryPath}profile.jpg");
                      setState(() {
                        _selectedImage = File(image.path);
                        profile_url = "${directoryPath}profile.jpg";
                      });
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(50)),
                    child: profile_url.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _selectedImage,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person_2_outlined,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.065),
                      ),
                      Text(
                        email,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            //App Settings
            Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white70.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  settingsMenuItem("Theme", "Dark"),
                  SizedBox(height: 20),
                  settingsMenuItem("Language", "English"),
                  SizedBox(height: 20),
                  settingsMenuItem("Default Currency", "INR"),
                  SizedBox(height: 20),
                ],
              ),
            ),

            //Support
            SizedBox(height: 25),
            //App Settings
            Text(
              "Support",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white70.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  supportMenuItem("FAQ"),
                  SizedBox(height: 20),
                  supportMenuItem("Contact Us"),
                  SizedBox(height: 20),
                  supportMenuItem("Feedback"),
                  SizedBox(height: 20),
                  supportMenuItem("Report Issue"),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 25),
            //App Settings
            Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white70.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  settingsMenuItem("Version", "v1.0.0"),
                  SizedBox(height: 20),
                  supportMenuItem("Terms & Condition"),
                  SizedBox(height: 20),
                  supportMenuItem("Privary Policy"),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Row supportMenuItem(String label) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        Spacer(),
        GestureDetector(onTap: () {}, child: Icon(Icons.arrow_forward))
      ],
    );
  }

  Row settingsMenuItem(String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: TextStyle(fontSize: 17),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white70.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white60, width: 1),
          ),
          child: Text(value),
        )
      ],
    );
  }
}
