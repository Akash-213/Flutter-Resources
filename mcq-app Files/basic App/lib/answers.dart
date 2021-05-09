import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answers(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, //takes whole ow area,
      child: RaisedButton(
        child: Text(
          answerText,
        ),
        onPressed: selectHandler,
        color: Colors.blue[200],
        textColor: Colors.black87,
      ),
    );
  }
}
