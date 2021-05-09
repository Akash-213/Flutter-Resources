import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;
  final int questionIndex;

  Question(this.questionText, this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
          child: Text(
            (questionIndex + 1).toString() + ")",
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
          child: Text(
            questionText,
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
