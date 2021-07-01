import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:permission_handler/permission_handler.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  PickedFile imageFile;
  final ImagePicker picker = ImagePicker();
  //PermissionStatus _status;

  Future _openGallary() async {
    //askPermission();
    final pictur = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = pictur;
    });
  }

  Widget test() {
    if (imageFile == null) {
      return Text("null");
    } else {
      return Image.file(
        File(imageFile.path),
        width: 400,
        height: 400,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: RaisedButton(onPressed: _openGallary),
            ),
          ),
          test()
        ],
      ),
    );
  }
}
