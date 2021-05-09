import 'package:flutter/material.dart';

class QuestionAvatar extends StatelessWidget {
  final int questionIndex;
  final Function gotoQuestion;
  // final List data;
  final Color questionAvatarColor;

  QuestionAvatar(
    this.questionIndex,
    this.gotoQuestion,
    // this.data,
    this.questionAvatarColor,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: IconButton(
          icon: CircleAvatar(
            child: Text((questionIndex + 1).toString()),
            backgroundColor: questionAvatarColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            gotoQuestion(questionIndex);
            Navigator.of(context).pop();
          }),
    );
  }
}
