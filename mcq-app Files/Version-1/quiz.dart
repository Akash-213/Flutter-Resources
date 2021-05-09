import 'package:flutter/material.dart';

import 'question.dart';
import 'answers.dart';

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

  Quiz({
    @required this.questions,
    @required this.questionIndex,
    @required this.nextQuestion,
    @required this.prevQuestion,
    @required this.saveAnswer,
    @required this.openGoToQuestion,
    @required this.selectedRadio,
    @required this.setSelectedRadio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
                onPressed: () => prevQuestion(selectedRadio),
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
            onPressed: () => openGoToQuestion(context),
          ),
        ],
      ),
    );
  }
}
