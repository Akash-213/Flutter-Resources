import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';
import '../screens/category_meals_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function selectHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 26,
            fontWeight: FontWeight.w500),
      ),
      onTap: selectHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile("Meals", Icons.restaurant_menu, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile("Filters", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
