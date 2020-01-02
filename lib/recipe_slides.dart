import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/recipe_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeSlides extends StatefulWidget {
  final String tag;
  _RecipeSlidesState state;

  RecipeSlides({this.tag, Key key}) : super(key: key) {
    state = _RecipeSlidesState(tag);
  }

  _RecipeSlidesState createState() => state;
}

class _RecipeSlidesState extends State<RecipeSlides> {
  PageController controller;
  final Firestore db = Firestore.instance;
  final String tag;

  var currentPage = 0.0;
  var currentLength = 0;
  var loading;
  StreamSubscription sub;

  Stream slides;

  _RecipeSlidesState(this.tag);

  @override
  void initState() {
    super.initState();

    loading = true;

    controller = PageController(initialPage: 0, keepPage: true);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    _queryDb();
  }

  void _queryDb() async {
    Query query =
        db.collection('recipes').where('categories', arrayContains: tag);

    var snapshots = query.snapshots();

    slides = snapshots.map((list) => list.documents.map((doc) => doc.data));

    sub = query.snapshots().listen((data) {
      Future.delayed(Duration(milliseconds: 50), () {
        if (sub == null) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            controller.animateToPage(data.documents.length - 1,
                duration: Duration(milliseconds: 600), curve: Curves.easeOut);
          });
        });
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    sub = null;

    super.dispose();
  }

  openCurrentPage() {
    Navigator.push(
        context,
        SlideRightRoute(
            page: RecipePage(slide: lastSlideList[currentPage.round()])));
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }

    return Stack(
      children: <Widget>[
        _buildSlides(),
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
              openCurrentPage();
          },
          child: PageView.builder(
            itemCount: currentLength,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ))
      ],
    );
  }

  var lastSlideList;

  Widget _buildSlides() {
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();
          lastSlideList = slideList;

          currentLength = slideList.length;

          return CardScrollWidget(currentPage, slideList);
        });
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CardScrollWidget extends StatelessWidget {
  var padding = 20.0;
  var verticalInset = 20.0;

  var slides;
  var currentPage;

  CardScrollWidget(this.currentPage, this.slides);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < slides.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Hero(
              transitionOnUserGestures: true,
              tag: slides[i]["title"],
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
                            imageUrl: slides[i]["img"],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                                width: 30,
                                height: 30,
                                child: Container(color: Colors.grey)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 6,
                                          bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        gradient: LinearGradient(colors: [
                                          Colors.red,
                                          Colors.orange,
                                          Colors.yellow
                                        ]),
                                      ),
                                      child: new Material(
                                          color: Colors.transparent,
                                          child: Text(slides[i]["title"],
                                              style: TextStyle(
                                                  decoration: null,
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
                      ),
                    ),
                  )),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}

class SlideController extends ChangeNotifier {
  String category = 'Breakfast';

  SlideController() {
    notifyListeners();
  }

  void updateCategory(String category) {
    this.category = category;
    this.notifyListeners();
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                )),
                child: child,
              );
            });
  @override
  bool get opaque => false;
}
