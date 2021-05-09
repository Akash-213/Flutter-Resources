// import 'package:flutter/material.dart';
// import './result.dart';
// import './quiz.dart';
// // import 'Widgets/QuestionAvatar.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter App',
//       home: MyQuizPage(),
//     );
//   }
// }

// class MyQuizPage extends StatefulWidget {
//   @override
//   _MyQuizPageState createState() => _MyQuizPageState();
// }

// class _MyQuizPageState extends State<MyQuizPage> {
//   final _questions = const [
//     {
//       'questiontext': 'Question 1',
//       'answers': [
//         {'text': 'Correct1'},
//         {'text': 'Wrong1-1'},
//         {'text': 'Wrong1-2'},
//         {'text': 'Wrong1-3'},
//       ]
//     },
//     {
//       'questiontext': 'Question 2',
//       'answers': [
//         {'text': 'Correct2'},
//         {'text': 'Wrong2-1'},
//         {'text': 'Wrong2-2'},
//         {'text': 'Wrong2-3'},
//       ]
//     },
//     {
//       'questiontext': 'Question 3',
//       'answers': [
//         {'text': 'Correct3'},
//         {'text': 'Wrong3-1'},
//         {'text': 'Wrong3-2'},
//         {'text': 'Wrong3-3'},
//       ]
//     },
//   ];

//   final _correctAnswers = ['Correct1', 'Correct2', 'Correct3'];
//   var _userAnswers = new List(3);

//   var _questionIndex = 0;

//   String _selectedRadioTile;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _selectedRadioTile = "null";
//   }

//   void _setSelectedRadioTile(String ans) {
//     setState(() {
//       _selectedRadioTile = ans;
//     });
//   }

//   void _showSavedAnswer(int index) {
//     setState(() {
//       _selectedRadioTile = _userAnswers[index];
//     });
//   }

//   void _saveAnswer(String ans) {
//     _userAnswers[_questionIndex] = ans;
//   }

//   void _nextQuestion(String ans) {
//     _saveAnswer(ans);
//     setState(() {
//       _questionIndex += 1;
//     });
//     _showSavedAnswer(_questionIndex);
//     print("Index : " + (_questionIndex).toString());
//     // print("Answer selected : " + _selectedRadioTile);
//     print("Answers Array : " + (_userAnswers).toString());
//   }

//   void _prevQuestion(String ans) {
//     setState(() {
//       _questionIndex -= 1;
//     });
//     _showSavedAnswer(_questionIndex);
//     print("Index : " + (_questionIndex).toString());
//     // print("Answer selected : " + _selectedRadioTile);
//     print("Answers Array : " + (_userAnswers).toString());
//   }

//   void _gotoQuestion(int index) {
//     setState(() {
//       _questionIndex = index;
//     });
//     _showSavedAnswer(_questionIndex);
//     print("Index : " + (_questionIndex).toString());
//     // print("Answer selected : " + _selectedRadioTile);
//     print("Answers Array : " + (_userAnswers).toString());
//   }

//   void _openGoToQuestion(BuildContext ctx) {
//     showModalBottomSheet(
//         context: ctx,
//         builder: (BuildContext bctx) {
//           return Container(
//               child: Column(
//             children: [
//               Center(child: Text("All Questions")),
//               Wrap(
//                 alignment: WrapAlignment.spaceBetween,
//                 direction: Axis.horizontal,
//                 children: [
//                   for (int i = 0; i < 30; i++)
//                     GestureDetector(
//                       onTap: () {},
//                       child: QuestionAvatar(i, _gotoQuestion),
//                       behavior: HitTestBehavior.opaque,
//                     )
//                 ],
//               ),
//               RaisedButton(
//                 child: Text("Done"),
//                 onPressed: () => Navigator.of(context).pop(),
//               )
//             ],
//           ));
//         });
//   }

//   int _unattempted = 0;
//   int _attemptedCorrect = 0;
//   int _attemptedWrong = 0;
//   int j = 0;
//   void _calculateScore() {
//     for (int i = 0; i < _userAnswers.length; i++) {
//       if (_userAnswers[i] == _correctAnswers[j]) {
//         setState(() {
//           _attemptedCorrect += 1;
//         });
//       } else if (_userAnswers[i] == "null") {
//         setState(() {
//           _unattempted += 1;
//         });
//       } else {
//         setState(() {
//           _attemptedWrong += 1;
//         });
//       }
//       j++;
//     }
//     print("Correct Answers : " + (_attemptedCorrect).toString());
//     print("Wrong Answers : " + (_attemptedWrong).toString());
//     print("Unattempted Answers : " + (_unattempted).toString());
//   }

//   void _returnHome() {
//     setState(() {
//       _questionIndex = -1;
//       _attemptedCorrect = 0;
//       _attemptedWrong = 0;
//       _unattempted = 0;
//       _userAnswers = [];
//       j = 0;
//     });
//     print("Total has been refreshed!");
//   }

//   void _resetQuiz() {
//     setState(() {
//       _questionIndex = 0;
//       _selectedRadioTile = "dummy";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         title: Text(
//           "QUIZ APP",
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: _questionIndex < 0
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("Main Screen"),
//                 RaisedButton(
//                   onPressed: () => _resetQuiz(),
//                   child: Text("Start Quiz"),
//                 ),
//               ],
//             )
//           : _questionIndex < _questions.length
//               ? Quiz(
//                   questions: _questions,
//                   questionIndex: _questionIndex,
//                   nextQuestion: _nextQuestion,
//                   saveAnswer: _saveAnswer,
//                   prevQuestion: _prevQuestion,
//                   //for radio answers
//                   selectedRadio: _selectedRadioTile,
//                   setSelectedRadio: _setSelectedRadioTile,
//                   //go to transversal
//                   openGoToQuestion: _openGoToQuestion,
//                 )
//               : Result(
//                   unattempted: _unattempted,
//                   attemptedCorrect: _attemptedCorrect,
//                   attemptedWrong: _attemptedWrong,
//                   calculateScore: _calculateScore,
//                   returnHome: _returnHome,
//                 ),
//     );
//   }
// }
