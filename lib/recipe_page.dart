import 'package:cached_network_image/cached_network_image.dart';
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

  List<Widget> buildSection(dynamic section) {
    List<Widget> items = new List();

    var contentData = section["content"];

    if (contentData is String) {
      items.add(new Text(contentData,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.0,
              height: 2,
              fontFamily: "Montserrat Regular")));
    } else if (contentData is List<dynamic>) {
      switch (section["bullet-type"]) {
        case "bullets":
          contentData.asMap().forEach((index, line) {
            items.add(Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 14.5),
                          child: SizedBox(
                            width: 5,
                            height: 5,
                            child: MyBullet(),
                          )),
                      SizedBox(width: 10),
                      Flexible(
                          child: Text(line,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  height: 2,
                                  fontSize: 14.0,
                                  fontFamily: "Montserrat Regular")))
                    ])));
          });
          break;
        case "numbered":
          contentData.asMap().forEach((index, line) {
            items.add(
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text((index + 1).toString() + ".",
                  style: TextStyle(
                      color: Colors.grey[700],
                      height: 2,
                      fontSize: 14.0,
                      fontFamily: "Montserrat Regular")),
              SizedBox(width: 10),
              Flexible(
                  child: Text(line,
                      style: TextStyle(
                          color: Colors.grey[700],
                          height: 2,
                          fontSize: 14.0,
                          fontFamily: "Montserrat Regular")))
            ]));
          });
          break;
        default:
          items.add(Text("Invalid bullet type",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14.0,
                  fontFamily: "Montserrat Regular")));
          break;
      }
    }

    return [
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 0),
          color: Colors.grey[100],
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section["title"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 22.0,
                            fontFamily: "Truckin")),
                    ...items
                  ]))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = new List();

    (slide["sections"] as List<dynamic>).forEach((section) {
      sections.addAll(buildSection(section));
    });

    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Icon(Icons.arrow_back),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                          transitionOnUserGestures: true,
                          tag: slide["title"],
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(3.0, 6.0),
                                      blurRadius: 8.0,
                                    ),
                                  ]),
                              child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  clipBehavior: Clip.antiAlias,
                                  child: AspectRatio(
                                      aspectRatio: cardAspectRatio,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl: slide["img"],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => SizedBox(
                                                width: 30,
                                                height: 30,
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 6,
                                                          bottom: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                              8.0)),
                                                          gradient: LinearGradient(colors: [
                                                            Colors.red,
                                                            Colors.orange,
                                                            Colors.yellow
                                                          ])),
                                                      child: new Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: Text(slide["title"],
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 25.0,
                                                                  fontFamily: "Truckin")))),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ))))),
                      SizedBox(height: 1000, child: PageView(
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: sections),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: sections)
                        ],
                      ))
                    ]))));
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.grey[700],
        shape: BoxShape.circle,
      ),
    );
  }
}
