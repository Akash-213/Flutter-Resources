import 'package:flutter/material.dart';

import '../Widgets/answers.dart';
import '../Widgets/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function nextQuestion;
  final Function prevQuestion;
  final Function saveAnswer;

  //for random question traversal
  final Function openGoToQuestion;

  //for radio answers
  final String selectedRadio;
  final Function setSelectedRadio;

  //for bookmarks
  final Color bookMarkColor;
  final Function setBookMark;

  Quiz({
    @required this.questions,
    @required this.questionIndex,
    @required this.nextQuestion,
    @required this.prevQuestion,
    @required this.saveAnswer,
    @required this.openGoToQuestion,
    @required this.selectedRadio,
    @required this.setSelectedRadio,
    @required this.bookMarkColor,
    @required this.setBookMark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                    'Question ${questionIndex + 1} of ${questions.length}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () => {setBookMark(questionIndex)},
                color: bookMarkColor,
                iconSize: 35,
              ),
              // SizedBox(width: 20),
              // CircleAvatar(
              //   backgroundColor: Colors.green,
              //   foregroundColor: Colors.white,
              //   child: Text("+1"),
              //   radius: 15,
              // ),
              // SizedBox(width: 10),
              // CircleAvatar(
              //   backgroundColor: Colors.red,
              //   foregroundColor: Colors.white,
              //   child: Text("-0"),
              //   radius: 15,
              // ),
            ],
          ),
          Question(
            questions[questionIndex]['questiontext'],
            questionIndex,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Answers(
              answer['text'],
              selectedRadio,
              setSelectedRadio,
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text("Previous"),
                onPressed: () => prevQuestion(),
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () => saveAnswer(selectedRadio),
              ),
              RaisedButton(
                child: Text("Next"),
                onPressed: () => nextQuestion(selectedRadio),
              ),
            ],
          ),
          FloatingActionButton(
            child: Text("Go To"),
            onPressed: () => openGoToQuestion(context, questionIndex),
          ),
        ],
      ),
    );
  }
}
