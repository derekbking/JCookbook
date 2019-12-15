import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeCreator extends StatefulWidget {
  RecipeCreator({Key key}) : super(key: key);

  _RecipeCreatorState createState() => _RecipeCreatorState();
}

class _RecipeCreatorState extends State<RecipeCreator> {
  TextEditingController _textController;
  File _image;

  Future getImage() async {
        var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text("Add an image", style: TextStyle(color: Colors.black, fontStyle: null, decorationStyle: null, decoration: null))),
          GestureDetector(
              onTap: () => {
                getImage()
              },
              child: Container(
                  constraints: BoxConstraints.expand(height: 150.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _image == null ? AssetImage("assets/no_image.jpg") : FileImage(_image),
                      fit: BoxFit.fitWidth,
                    ),
                  ))),
        ],
      ),
    );
  }
}
