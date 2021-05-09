import 'package:flutter/material.dart';

import 'eventList.dart';
import 'mydrawer.dart';

//initialize this route in home
// Stack is necessary for back button/fallback
class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        MyDrawer(),
        EventList(),
      ]),
    );
  }
}
