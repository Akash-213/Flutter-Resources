import 'package:MCQ_APP/Widgets/timerArea.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  //for using the correct and user Answers array
  List data;
  var correctAnswers = [];
  var userAnswers = [];
  int time = 0;

  int _unattempted = 0;
  int _attemptedCorrect = 0;
  int _attemptedWrong = 0;
  int j = 0;

  void calculateScore() {
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == correctAnswers[j]) {
        setState(() {
          _attemptedCorrect += 1;
        });
      } else if (userAnswers[i] == null) {
        setState(() {
          _unattempted += 1;
        });
      } else {
        setState(() {
          _attemptedWrong += 1;
        });
      }
      j++;
    }
    print("Correct Answers : " + (_attemptedCorrect).toString());
    print("Wrong Answers : " + (_attemptedWrong).toString());
    print("Unattempted Answers : " + (_unattempted).toString());
  }

  // void _returnHome() {
  //   setState(() {
  //     _questionIndex = -1;
  //     _attemptedCorrect = 0;
  //     _attemptedWrong = 0;
  //     _unattempted = 0;
  //     _userAnswers = [];
  //     j = 0;
  //   });
  //   print("Total has been refreshed!");
  // }

  // void _resetQuiz() {
  //   setState(() {
  //     _questionIndex = 0;
  //     _selectedRadioTile = "null";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    correctAnswers = data[0];
    userAnswers = data[1];
    time = data[2];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "QUIZ APP",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TimerArea(time),
          Text(
            "Total Questions: " +
                (_unattempted + _attemptedCorrect + _attemptedWrong).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Unattempted :  $_unattempted",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Correct Answers :  $_attemptedCorrect",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Wrong Answers :  $_attemptedWrong",
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
            onPressed: () => calculateScore(),
          ),
          // SizedBox(height: 100),
          // FlatButton(
          //   child: Text("Restart the Quiz !"),
          //   color: Colors.blue[100],
          //   onPressed: returnHome,
          // )
        ],
      ),
    );
  }
}
