import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

// this is EventList Screen;

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;

  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          xoffset = 0;
          yoffset = 0;
          scalefactor = 1;
          isDrawerOpen = false;
        });
      },
      child: SwipeDetector(
        onSwipeRight: () {
          // print('Swiped Right');
          setState(() {
            xoffset = 250;
            yoffset = 150;
            scalefactor = 0.7;
            isDrawerOpen = true;
          });
        },
        onSwipeLeft: () {
          // print('Swiped Left');
          setState(() {
            xoffset = 0;
            yoffset = 0;
            scalefactor = 1;
            isDrawerOpen = false;
          });
        },
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xoffset, yoffset, 0)
            ..scale(scalefactor),
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.backspace_outlined),
                          onPressed: () {
                            setState(() {
                              xoffset = 0;
                              yoffset = 0;
                              scalefactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xoffset = 250;
                              yoffset = 150;
                              scalefactor = 0.7;
                              isDrawerOpen = true;
                            });
                          },
                        ),
                  Container(
                    child: Text('Some Title'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
