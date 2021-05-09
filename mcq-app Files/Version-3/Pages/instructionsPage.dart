import 'package:flutter/material.dart';

class InstructionsStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "QUIZ APP",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Instructions Page"),
            Text("These are the instructions"),
            RaisedButton(
              child: Text('I am ready!'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/quizPage');
              },
            ),
            SizedBox(height: 50),
            Container(
              child: Text("Colors Schema"),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 10,
                  ),
                  SizedBox(width: 40),
                  Text("Attempted & Bookmarked"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 10,
                  ),
                  SizedBox(width: 40),
                  Text("Attempted"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 10,
                  ),
                  SizedBox(width: 40),
                  Text("Unattempted & Bookmarked"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                  ),
                  SizedBox(width: 40),
                  Text("Unattempted"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Icon(
                    (Icons.bookmark),
                    color: Colors.amber,
                    size: 30,
                  ),
                  SizedBox(width: 40),
                  Text("Bookmarked"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Icon(
                    (Icons.bookmark),
                    color: Colors.blue,
                    size: 30,
                  ),
                  SizedBox(width: 40),
                  Text("Unbookmarked"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
