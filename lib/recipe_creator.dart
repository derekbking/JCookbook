import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeCreator extends StatefulWidget {
  RecipeCreator({Key key}) : super(key: key);

  _RecipeCreatorState createState() => _RecipeCreatorState();
}

class _RecipeCreatorState extends State<RecipeCreator> {
  TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 150.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/no_image.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Text('Add a picture...', style: TextStyle(
              color: Colors.white))
          ),
          SizedBox(height: 15,),
          CupertinoButton(child: Text('Add step'), onPressed: () {}, color: Colors.blue,),
          Container(
            color: Colors.white,
            child: CupertinoTextField(controller: _textController)
          ),
        ],
      ),
    );
  }
}