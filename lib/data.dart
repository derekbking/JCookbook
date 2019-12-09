import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<MenuItem> options = [
  MenuItem(Icons.wb_sunny, 'Breakfast'),
  MenuItem(Icons.local_cafe, 'Drinks'),
  MenuItem(Icons.local_dining, 'Meals'),
  MenuItem(Icons.cake, 'Desserts'),
  MenuItem(Icons.cake, 'Snacks'),
];

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
