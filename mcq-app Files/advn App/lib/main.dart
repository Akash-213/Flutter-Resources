import 'package:flutter/material.dart';

import './Pages/instructionsPage.dart';
import './Pages/quizPage.dart';
import './Pages/resultPage.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => InstructionsStart(),
        '/quizPage': (context) => QuizPage(),
        '/resultPage': (context) => ResultPage(),
      },
    ));
