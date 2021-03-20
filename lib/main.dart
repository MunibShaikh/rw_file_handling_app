import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title: "I/O",
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var myData = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("I/O File Handling"),
      ),
      body: Column(children: [
        new ListTile(
          title: TextField(
            controller: myData,
            decoration: InputDecoration(hintText: "Enter Data"),
          ),
          subtitle: FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              writeData(myData.text);
            },
            child: Text(
              "Save Data",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          child: FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot<String> data) {
                if (data.hasData != null) {
                  return Text(data.data.toString());
                } else {
                  return Text("No data found");
                }
              }),
        )
      ]),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('$path/My data.txt======Data');
    return File('$path/My data.txt');
  }

  Future<File> writeData(String myInfo) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('$myInfo');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0.
      return "No Data found here...";
    }
  }
}
