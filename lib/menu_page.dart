import 'package:cookbook/recipe_creator.dart';
import 'package:cookbook/recipe_slides.dart';
import 'package:cookbook/zoom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                ),
                Text(
                  'Jordyn\'s Cookbook',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Spacer(),
            Column(
              children: options.map((item) {
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      size: 20,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Provider.of<SlideController>(context, listen: true).updateCategory(item.title);
                      Future.delayed(Duration(milliseconds: 500), () => Provider.of<MenuController>(context, listen: true).close());
                    }
                ));
              }).toList(),
            ),
            Spacer(),
            Material(
              color: Colors.transparent,
              child:  ListTile(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => RecipeCreator()));
              },
              leading: Icon(
                Icons.settings,
                size: 20,
              ),
              title: Text('Manage Recipes', style: TextStyle(fontSize: 14)),
            )),
          ],
        ),
      ),
    );
  }
}
