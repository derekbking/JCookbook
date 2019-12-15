import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeCard1 extends StatelessWidget {
  final String title;
  final String image;

  const RecipeCard1({this.title, this.image, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: this.title,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(this.image, fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.black87,
                        ),
                        child: Text(this.title,
                            style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "Cairo-SemiBold"))),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
