import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:xpens/variables.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal();

  factory FileManager() {
    _instance ??= FileManager._internal();
    return _instance!;
  }

  static FileManager get instance => _instance!;

  //Get Storage Directory
  Future<String?> getDirectoryPath() {
    return getExternalStorageDirectory().then((resp) => resp?.path.toString());
  }

  //Read Json File
  Future<void> readJsonFile(String path, String fileName) async {
    File file = File("$path$fileName");
    try {
      if (await file.exists()) {
        final String jsonString = await file.readAsString();

        Map<String, dynamic> data = jsonDecode(jsonString);
        jsonData = data.map((key, value) => MapEntry(key, value.toString()));
        if (jsonData["name"] != null ||
            jsonData["email"] != null ||
            jsonData["profile_url"] != null) {
          userName = jsonData["name"]!;
          email = jsonData["email"]!;
          profile_url = jsonData["profile_url"]!;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //Write Json File
  Future<void> writeJsonFile(
      Map<String, dynamic> jsonData, String path, String fileName) async {
    File file = File("$path$fileName");

    String jsonString = jsonEncode(jsonData);
    try {
      await file.writeAsString(jsonString);
    } catch (e) {
      print(e);
    }
  }

  //Update Json File
  Future<void> updateJsonFile(String _keytobeChanged, String newvalue,
      String path, String fileName) async {
    //make the jsondata from old fetched values
    if (jsonData.isNotEmpty) {
      jsonData[_keytobeChanged] = newvalue;
    }

    //write the file
    String jsonString = jsonEncode(jsonData);

    File file = File(path + fileName);
    try {
      await file.writeAsString(jsonString);
    } catch (e) {
      print(e);
    }
  }

  //Copy File
  Future<void> copyFile(String sourcePath, String destinationPath) async {
    File sourceFile = File(sourcePath);

    if (await sourceFile.exists()) {
      try {
        sourceFile.copy(destinationPath);
      } catch (e) {
        print(e);
      }
    }
  }
}
