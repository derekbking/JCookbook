import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_icons_icons.dart';

final List<MenuItem> options = [
  MenuItem(Icons.wb_sunny, 'Breakfast'),
  MenuItem(Icons.local_cafe, 'Drinks'),
  MenuItem(Icons.local_dining, 'Meals'),
  MenuItem(MenuIcons.cup_cake, 'Desserts'),
  MenuItem(MenuIcons.avocado, 'Snacks'),
];

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
