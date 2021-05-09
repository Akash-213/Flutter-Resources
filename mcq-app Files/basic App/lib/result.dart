import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;

  Result(this.resultScore, this.resetQuiz);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 6) {
      resultText = "You are awesome!!";
    } else if (resultScore >= 3) {
      resultText = "You are good !!";
    } else {
      resultText = "You are worse !!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Your Score is $resultScore",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.pink[700],
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Text(
            resultPhrase,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.purple[900],
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          FlatButton(
            child: Text("Restart the Quiz !"),
            color: Colors.blue[100],
            onPressed: resetQuiz,
          )
        ],
      ),
    );
  }
}
