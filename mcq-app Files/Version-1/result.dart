import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int unattempted;
  final int attemptedCorrect;
  final int attemptedWrong;
  final Function calculateScore;
  final Function returnHome;

  Result({
    @required this.unattempted,
    @required this.attemptedCorrect,
    @required this.attemptedWrong,
    @required this.calculateScore,
    @required this.returnHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total Questions: " +
                (unattempted + attemptedCorrect + attemptedWrong).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Unattempted :  $unattempted",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Correct Answers :  $attemptedCorrect",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Wrong Answers :  $attemptedWrong",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          FlatButton(
            child: Text("Show Score !"),
            color: Colors.blue[100],
            onPressed: calculateScore,
          ),
          SizedBox(height: 50),
          FlatButton(
            child: Text("Restart the Quiz !"),
            color: Colors.blue[100],
            onPressed: returnHome,
          )
        ],
      ),
    );
    ;
  }
}
