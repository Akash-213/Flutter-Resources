import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Map weatherdata = {};
  @override
  Widget build(BuildContext context) {
    weatherdata = ModalRoute.of(context).settings.arguments;
    print(weatherdata);

    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text("Weather Forecast"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherdata["city"],
                    style: TextStyle(
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherdata['nowdate'],
                    style: TextStyle(fontSize: 20.0, color: Colors.cyan[900]),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    weatherdata['nowtime'],
                    style: TextStyle(fontSize: 20.0, color: Colors.cyan[900]),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    weatherdata["country"],
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    // weatherdata['iconimiage'],
                    'http://openweathermap.org/img/wn/${weatherdata['icon']}@2x.png',
                    height: 80.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        weatherdata['weather_main'],
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),
                      Text(
                        weatherdata['weather_des'],
                        style:
                            TextStyle(fontSize: 25.0, color: Colors.grey[600]),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                "Temperature",
                style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 5.0),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Minimum",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['temp_min'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.purple[300],
                    ),
                    Column(
                      children: [
                        Text(
                          "Feels Like",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['temp'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.purple[300],
                    ),
                    Column(
                      children: [
                        Text(
                          "Maximum",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['temp_max'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              //---Humidity and Pressure
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Humidity",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['humidity'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.purple[300],
                    ),
                    Column(
                      children: [
                        Text(
                          "Pressure",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['pressure'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //------Humidity and Pressure---
              SizedBox(height: 30.0),
              //------SUNRISE__SUNSET----
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Sunrise",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 23.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['sunrisetime'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.purple[300],
                    ),
                    Column(
                      children: [
                        Text(
                          "Sunset",
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 23.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          weatherdata['sunsettime'],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //------SUNRISE__SUNSET----
              SizedBox(height: 50.0),
              RaisedButton(
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: Text('Return Home'),
                color: Colors.purple[900],
              )
            ],
          ),
        ),
      ),
    );
  }
}
