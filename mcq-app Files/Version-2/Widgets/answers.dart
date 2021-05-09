import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final String answerText;
  final String fselectedRadio;
  final Function setSelectedRadio;

  Answers(
    this.answerText,
    this.fselectedRadio,
    this.setSelectedRadio,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RadioListTile(
        value: answerText,
        groupValue: fselectedRadio,
        onChanged: (val) {
          print("Radio $val");
          setSelectedRadio(val);
        },
        title: Text(answerText),
      ),
    );
  }
}
