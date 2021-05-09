import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

// check why const in constructor
//as all fields are final so nothing can change

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
