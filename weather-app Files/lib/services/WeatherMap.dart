import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WeatherFind {
  String city;
  String check = "Working";
  String country;
  String weather_main;
  String weather_des;
  String temp;
  String temp_max;
  String temp_min;
  String cod;
  String icon;
  String humidity;
  String pressure;
  String sunrisetime;
  String sunsettime;
  String nowtime;
  String nowdate;

  WeatherFind({this.city});

  Future<void> sendWeather() async {
    try {
      Response response = await get(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=0977a691482f71660eea89cd421f8126');
      Map data = jsonDecode(response.body);
      print(data);

      country = data["sys"]["country"];
      temp = ((data["main"]["feels_like"] - 273).roundToDouble()).toString();
      temp_min = ((data["main"]["temp_min"] - 273).roundToDouble()).toString();
      temp_max = ((data["main"]["temp_max"] - 273).roundToDouble()).toString();
      cod = data["cod"].toString();

      int sunrise = (data["sys"]["sunrise"]);
      int sunset = (data["sys"]["sunset"]);
      humidity = (data['main']['humidity']).toString();
      pressure = (data['main']['pressure']).toString();

      DateTime sunrise1 =
          new DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
      sunrisetime = (DateFormat.jm().format(sunrise1)).toString();
      print(sunrisetime);

      DateTime sunset1 = new DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
      sunsettime = (DateFormat.jm().format(sunset1)).toString();
      print(sunsettime);

      DateTime now = new DateTime.now();
      nowdate = (DateFormat.yMEd().format(now)).toString();
      nowtime = (DateFormat.jm().format(now)).toString();

      weather_main = data['weather'][0]["main"];
      weather_des = data['weather'][0]['description'];
      icon = data['weather'][0]['icon'];

      print(check);
    } catch (error) {
      // city = "Some Error!";
      // country = "Error";
      // weather_main = "N.A";
      // weather_des = "N.A";
      // temp = "N.A";
      // temp_max = "N.A";
      // temp_min = "N.A";
      // sunrise = "N.A";
      // sunset = "N.A";
      // pressure = "N.A";
      // humidity = "N.A";
      cod = "404";

      print("Caught Error : $error");
    }
  }
}
