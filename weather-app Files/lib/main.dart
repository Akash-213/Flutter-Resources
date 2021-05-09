import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/loading.dart';
import 'package:weather_app/pages/weather.dart';

void main() => runApp(MaterialApp(

  routes: {
    '/' : (context) => Home() ,
    '/loading' : (context) => Loading(),
    '/weather' : (context) => Weather(),

  },
));
