import 'dart:async';
import 'package:flutter/material.dart';

import '../Widgets/QuestionAvatar.dart';
import '../Widgets/quiz.dart';
import '../Widgets/timerArea.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _questions = const [
    {
      'questiontext': 'Question 1',
      'answers': [
        {'text': 'Correct1'},
        {'text': 'Wrong1-1'},
        {'text': 'Wrong1-2'},
        {'text': 'Wrong1-3'},
      ]
    },
    {
      'questiontext': 'Question 2',
      'answers': [
        {'text': 'Correct2'},
        {'text': 'Wrong2-1'},
        {'text': 'Wrong2-2'},
        {'text': 'Wrong2-3'},
      ]
    },
    {
      'questiontext': 'Question 3',
      'answers': [
        {'text': 'Correct3'},
        {'text': 'Wrong3-1'},
        {'text': 'Wrong3-2'},
        {'text': 'Wrong3-3'},
      ]
    },
  ];

  final _correctAnswers = ['Correct1', 'Correct2', 'Correct3'];
  var _userAnswers = new List(3);
  // var _isbookMarked = [false, false, false];
  // var _isanswered = [false, false, false];
  // var _questionAvatarColor = [Colors.red, Colors.red, Colors.red];

  var _data = [
    {
      'isbookMarked': false,
      'isanswered': false,
      'questionAvatarColor': Colors.red,
    },
    {
      'isbookMarked': false,
      'isanswered': false,
      'questionAvatarColor': Colors.red,
    },
    {
      'isbookMarked': false,
      'isanswered': false,
      'questionAvatarColor': Colors.red,
    },
  ];
  var _questionIndex = 0;
  String _selectedRadioTile;
  Color _bookMarkColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedRadioTile = null;
    _bookMarkColor = Colors.blue;
    _startTimer();
  }

//for radio buttons selection
  void _setSelectedRadioTile(String ans) {
    setState(() {
      _selectedRadioTile = ans;
    });
  }

//to show earlier saved answer from userAnswer Array
  void _showSavedAnswer(int index) {
    setState(() {
      _selectedRadioTile = _userAnswers[_questionIndex];
    });
  }

//save answer in userAnswer Array
  void _saveAnswer(String ans) {
    if (ans == null) {
      setState(() {
        _data[_questionIndex]['isAnswered'] = false;
        // _isanswered[_questionIndex] = false;
      });
    } else {
      setState(() {
        _data[_questionIndex]['isAnswered'] = true;
        // _isanswered[_questionIndex] = true;
      });
    }
    _userAnswers[_questionIndex] = ans;
    _showbookMark(_questionIndex);
    _setCircleAvatarColor(_questionIndex);
    // print("Answer : " + (ans).toString());
  }

//save and move to next question
  void _nextQuestion(String ans) {
    _saveAnswer(ans);
    setState(() {
      _questionIndex += 1;
    });
    _showSavedAnswer(_questionIndex);
    _showbookMark(_questionIndex);
    // print("Index : " + (_questionIndex).toString());
    // print("Answers Array : " + (_userAnswers).toString());
  }

//moves to previous question and shows earlier answer
  void _prevQuestion() {
    setState(() {
      if (_questionIndex > 0) {
        _questionIndex -= 1;
      }
    });
    _showSavedAnswer(_questionIndex);
    _showbookMark(_questionIndex);
    // print("Index : " + (_questionIndex).toString());
    // print("Answers Array : " + (_userAnswers).toString());
  }

// go to a particular question (random)
  void _gotoQuestion(int index) {
    setState(() {
      _questionIndex = index;
    });
    _showSavedAnswer(_questionIndex);
    _showbookMark(_questionIndex);
    // print("Index : " + (_questionIndex).toString());
    // print("Answers Array : " + (_userAnswers).toString());
  }

  void _showbookMark(int index) {
    if (_data[_questionIndex]['isbookMarked'] == true)
      setState(() {
        _bookMarkColor = Colors.amber;
      });
    else {
      setState(() {
        _bookMarkColor = Colors.blue;
      });
    }
    // print("Show BookMark : " + (_isbookMarked[index]).toString());
  }

  void _setBookMark(int index) {
    _showbookMark(index);
    if (_data[_questionIndex]['isbookMarked'] == false) {
      setState(() {
        _bookMarkColor = Colors.amber;
        _data[_questionIndex]['isbookMarked'] = true;
        // _isbookMarked[index] = true;
      });
    } else {
      setState(() {
        _bookMarkColor = Colors.blue;
        _data[_questionIndex]['isbookMarked'] = false;
        // _isbookMarked[index] = false;
      });
    }
    _setCircleAvatarColor(index);
    // print("Index of bookmark : " + (index).toString());
    // print("Bookmark at Index : " + (_isbookMarked[index]).toString());
  }

  void _setCircleAvatarColor(int index) {
    if (_data[_questionIndex]['isanswered'] == true &&
        _data[_questionIndex]['isbookMarked'] == true) {
      setState(() {
        _data[_questionIndex]['questionAvatarColor'] = Colors.deepPurple;
      });
    } else if (_data[_questionIndex]['isanswered'] == true &&
        _data[_questionIndex]['isbookMarked'] == false) {
      setState(() {
        _data[_questionIndex]['questionAvatarColor'] = Colors.green;
      });
    } else if (_data[_questionIndex]['isanswered'] == false &&
        _data[_questionIndex]['isbookMarked'] == true) {
      setState(() {
        _data[_questionIndex]['questionAvatarColor'] = Colors.amber;
      });
    } else {
      setState(() {
        _data[_questionIndex]['questionAvatarColor'] = Colors.red;
      });
    }
    // print("Index : " + (index).toString());
    // print("Answered : " + (_isanswered[index]).toString());
    // print("Bookmark : " + (_isbookMarked[index]).toString());
    // print("Color : " + (_questionAvatarColor).toString());
    // print('Data : ' + (_data[_questionIndex]).toString());
  }

//for modal sheet opening
  void _openGoToQuestion(BuildContext ctx, int index) {
    _setCircleAvatarColor(index);
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext bctx) {
          return Container(
            child: Column(
              children: [
                Center(child: Text("All Questions")),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    for (int i = 0; i < _questions.length; i++)
                      GestureDetector(
                        onTap: () {},
                        child: QuestionAvatar(i, _gotoQuestion,
                            _data[_questionIndex]['questionAvatarColor']),
                        behavior: HitTestBehavior.opaque,
                      )
                  ],
                ),
                RaisedButton(
                  child: Text("Done"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
        });
  }

  int _time = 30;
  void _startTimer() {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();
            _questionIndex = 100;
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          TimerArea(_time),
          (_questionIndex < _questions.length)
              ? Quiz(
                  questions: _questions,
                  questionIndex: _questionIndex,
                  nextQuestion: _nextQuestion,
                  saveAnswer: _saveAnswer,
                  prevQuestion: _prevQuestion,
                  //for radio answers
                  selectedRadio: _selectedRadioTile,
                  setSelectedRadio: _setSelectedRadioTile,
                  //go to random questions transversal
                  openGoToQuestion: _openGoToQuestion,
                  //bookmark
                  bookMarkColor: _bookMarkColor,
                  setBookMark: _setBookMark,
                )
              : Column(
                  children: [
                    Text("You reached end of questions!!"),
                    RaisedButton(
                      child: Text("Previous"),
                      onPressed: () => _prevQuestion(),
                    ),
                    RaisedButton(
                      child: Text("Finish Exam"),
                      onPressed: () => Navigator.popAndPushNamed(
                        context,
                        '/resultPage',
                        arguments: [_correctAnswers, _userAnswers, _time],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
