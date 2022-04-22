import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
//import http package manually
final picker = ImagePicker();
late Future<PickedFile?> pickedFile = Future.value(null);
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blueGrey,
    body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 25,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.download_rounded),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    pickedFile = picker.getImage(source: ImageSource.camera).whenComplete(() => {});
                  },
                  icon:Icon(Icons.add)
              ),
              SizedBox(
                width: 100,
              ),
              IconButton(
                onPressed: () async {
                  pickedFile = picker
                      .getImage(
                    source: ImageSource.gallery,
                  )
                      .whenComplete(() => {});
                },
                icon:Icon(Icons.photo_camera_back),
              ),
            ],
          ),
          FutureBuilder<PickedFile?>(
            future: pickedFile,
            builder: (context, snap) {
              if (snap.hasData) {
                return Container(
                  child: Image.file(
                    File(snap.data!.path),
                    fit: BoxFit.contain,
                  ),
                  color: Colors.blue,
                );
              }
              return Container(
                height: 200.0,
                color: Colors.blue,
              );
            },
          ),
        ],
      ),
    ),
  );
}