import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照、相册"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: _images.length == 0
          ? Center(
              child: Text(
                "当前没有选中照片",
                style: TextStyle(fontSize: 26),
              ),
            )
          : Wrap(
              spacing: 5,
              runSpacing: 5,
              children: _genImages(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _photoPickPop();
        },
        tooltip: "Pick Image",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future _getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      _images.add(image);
    });
  }

  _photoPickPop() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 120,
              child: Column(
                children: <Widget>[
                  _popItem("拍照", Icons.camera_alt, true),
                  _popItem("相册", Icons.photo_library, false),
                ],
              ),
            ));
  }

  _popItem(String name, IconData icon, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(icon),
        title: Text(name),
        onTap: () {
          _getImage(isTakePhoto);
        },
      ),
    );
  }

  ///照片item
  _genImages() {
    return _images.map((file) {
      return Container(
        height: 90,
        width: 120,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Center(
                child: Image.file(file),
              ),
            ),
            Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _images.remove(file);
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black38),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      );
    }).toList();
  }
}
