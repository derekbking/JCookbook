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
  List<Map<String, dynamic>> sections = new List();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var renderSections = sections
        .asMap()
        .map((index, section) {
          return MapEntry(
              index,
              Column(children: [
                TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Section Title'))
              ]));
        })
        .values
        .toList();

    return Material(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Create a New Recipe",
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Card(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Title')))),
              Card(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Image')))),
              Text("Sections", style: TextStyle(fontSize: 18.0)),
              Card(child: new Column(children: <Widget>[
                ...renderSections
              ],)),
              RaisedButton(
                child: Text("Add Section"),
                onPressed: () {
                  setState(() {
                    sections.add(Map());
                  });
                },
              )
            ],
          ),
        ));
  }
}
