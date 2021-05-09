import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questiontext': 'What is your favourite color ?',
      'answers': [
        {'text': 'White', 'score': 4},
        {'text': 'Yellow', 'score': 3},
        {'text': 'Red', 'score': 2},
        {'text': 'Black', 'score': 1},
      ],
    },
    {
      'questiontext': 'What\'s your favourite dish ?',
      'answers': [
        {'text': 'Vadapav', 'score': 4},
        {'text': 'Dabeli', 'score': 2},
        {'text': 'ShevPav', 'score': 3},
        {'text': 'Samosa', 'score': 1},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print("We have more questions!!");
    } else {
      print("No more questions!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "QUIZ APP",
          textAlign: TextAlign.center,
        ),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questions: _questions,
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
            )
          : Result(_totalScore, _resetQuiz),
    ));
  }
}
