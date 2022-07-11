import 'package:flutter/material.dart';
import 'package:multi_vendor_project/colors.dart';

class ImageShow extends StatefulWidget {
  var imageUrl;

   ImageShow({Key? key,required this.imageUrl}) : super(key: key);

  @override
  State<ImageShow> createState() => _ImageShowState(imageUrl);
}

class _ImageShowState extends State<ImageShow> {
  var imageUrl;

  _ImageShowState(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
