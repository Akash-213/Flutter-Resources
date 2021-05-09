import 'package:flutter/material.dart';
import 'package:weather_app/services/WeatherMap.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/pages/dialogs.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};
  void getweather() async {
    String city = data['city'];

    WeatherFind obj = WeatherFind(city: city);
    await obj.sendWeather();
    print(data);
    print(obj.cod);

    if (obj.cod == "404") {
      await Dialogs.tryagainDialog(context);
    } else {
      Navigator.pushReplacementNamed(context, '/weather', arguments: {
        'city': obj.city,
        'country': obj.country,
        'temp': obj.temp,
        'temp_min': obj.temp_min,
        'temp_max': obj.temp_max,
        'weather_main': obj.weather_main,
        'weather_des': obj.weather_des,
        'sunrisetime': obj.sunrisetime,
        'sunsettime': obj.sunsettime,
        'nowtime': obj.nowtime,
        'nowdate': obj.nowdate,
        'pressure': obj.pressure,
        'humidity': obj.humidity,
        'icon': obj.icon,
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    getweather();

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.purple,
          size: 100.0,
        ),
      ),
    );
  }
}
