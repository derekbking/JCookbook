import 'package:cookbook/recipe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  var slide;

  RecipePage({this.slide});

  @override
  _RecipePageState createState() => _RecipePageState(this.slide);
}

var cardAspectRatio = 12.0 / 16.0;

class _RecipePageState extends State<RecipePage> {
  var slide;

  _RecipePageState(this.slide);

  @override
  Widget build(BuildContext context) {
    print(slide);

    var steps = (slide["steps"] as List<dynamic>)
        .asMap()
        .map((index, step) {
          return MapEntry(
              index,
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: RichText(
                      text: TextSpan(
                          text: "Step ${index + 1}\n",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 22.0,
                              fontFamily: "Cairo-SemiBold",
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: step,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.0,
                                fontFamily: "Cairo-SemiBold"))
                      ]))));
        })
        .values
        .toList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Hero(
                  transitionOnUserGestures: true,
                  tag: slide["title"],
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(3.0, 6.0),
                                    blurRadius: 10.0)
                              ]),
                          child: AspectRatio(
                              aspectRatio: cardAspectRatio,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.network(slide["img"],
                                      fit: BoxFit.cover),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                                color: Colors.black87,
                                              ),
                                              child: new Material(
                                                  color: Colors.transparent,
                                                  child: Text(slide["title"],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25.0,
                                                          fontFamily:
                                                              "Cairo-SemiBold")))),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))))),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: RichText(
                      text: TextSpan(
                          text: "Ingredients",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 22.0,
                              fontFamily: "Cairo-SemiBold",
                              fontWeight: FontWeight.bold),
                          children: [
                        ...(slide["ingredients"]).map((ingredient) => TextSpan(
                                text: "\n•",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14.0,
                                    fontFamily: "Roboto Mono"),
                                children: [
                                  TextSpan(
                                    text: "$ingredient",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14.0,
                                          fontFamily: "Cairo-SemiBold"))
                                ]))
                      ]))),
              ...steps
            ])));
  }
}
