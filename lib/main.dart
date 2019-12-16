import 'package:cookbook/recipe_slides.dart';
import 'package:cookbook/zoom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu_page.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jordyn\'s Cookbook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Cookbook(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Cookbook extends StatefulWidget {
  Cookbook({Key key}) : super(key: key);

  _CookbookState createState() => _CookbookState();
}

class _CookbookState extends State<Cookbook> with TickerProviderStateMixin {
  MenuController menuController;
  SlideController slideController;

  Widget contentScreen;

  var key = GlobalKey<_CookbookState>();

  _CookbookState() {
    menuController = new MenuController(
      vsync: this,
    );

    slideController = new SlideController();

    doWhile();
  }

  void doWhile() async {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 3));

      menuController.animationController.notifyListeners();

      return true;
    });
  }

  @override
  void initState() {
    super.initState();

    print('INIT STATE: Cookbook');

    contentScreen = AppWindow(slideController.category, key: key);

    slideController.addListener(() {
      setState(() {
        print('Setting state');
        key = GlobalKey<_CookbookState>();
        contentScreen = AppWindow(slideController.category, key: key);
      });
    });
  }

  @override
  void dispose() {
    slideController.dispose();
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => menuController),
        ChangeNotifierProvider(builder: (context) => slideController)
      ],
      child: ZoomScaffold(
        menuScreen: MenuScreen(),
        contentScreen: contentScreen,
      ),
    );
  }
}

class AppWindow extends StatelessWidget {
  final String title;

  const AppWindow(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Provider.of<MenuController>(context, listen: true)
                              .open();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 46.0,
                            fontFamily: "Cairo-SemiBold",
                            letterSpacing: 1.0,
                          )),
                    ],
                  ),
                ),
                RecipeSlides(tag: title.toLowerCase())
              ],
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String category;
  final Map<String, Widget> pages = new Map();

  MyHomePage(this.category, {Key key}) : super(key: key) {
    print('CONSTRUCTOR: MyHomePage');
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    print('INIT STATE: _MyHomePageState');
    for (var menuOption in options) {
      widget.pages[menuOption.title] = new RecipeSlides(tag: menuOption.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Provider.of<MenuController>(context, listen: true)
                              .open();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget.category,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 46.0,
                            fontFamily: "Cairo-SemiBold",
                            letterSpacing: 1.0,
                          )),
                    ],
                  ),
                ),
                widget.pages[widget.category.toLowerCase()]
              ],
            ),
          )),
    );
  }
}
