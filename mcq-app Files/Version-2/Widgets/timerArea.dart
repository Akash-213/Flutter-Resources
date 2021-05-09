import 'package:flutter/material.dart';

class TimerArea extends StatelessWidget {
  final int time;

  TimerArea(this.time);

  @override
  Widget build(BuildContext context) {
    int minutes = (time / 60).truncate();
    String minutesS = (minutes % 60).toString().padLeft(2, '0');
    int seconds = time - minutes * 60;
    String secondsS = (seconds % 60).toString().padLeft(2, '0');
    Color timerAreaColor;
    if (time > 30) {
      timerAreaColor = Colors.amber[300];
    } else {
      timerAreaColor = Colors.red[400];
    }
    return Container(
      width: double.infinity,
      color: timerAreaColor,
      child: Text(
        "Time Left : $minutesS : $secondsS ",
        // "Time Left : $minutesS minutes $secondsS seconds",
        textAlign: TextAlign.center,
      ),
    );
  }
}
