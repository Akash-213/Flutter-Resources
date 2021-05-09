import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Input the city
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  //get city name
  void get_city() {
    Navigator.pushNamed(context, '/loading', arguments: {
      'city': myController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text("Weather"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: [
              Text(
                'Type a City Name',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: myController,
                decoration: InputDecoration(
                    hintText: 'Enter the city name',
                    prefixIcon: Icon(Icons.local_airport),
                    suffixIcon: Icon(Icons.location_searching),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.purple[500]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.purple[500]),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100]),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some city name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () {
                  get_city();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Search',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                ),
                color: Colors.purple[900],
              ),
              SizedBox(height: 60.0),
              Text(
                "Search Popular cities",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // OutlineButton.icon(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //     style: BorderStyle.solid, //Style of the border
                        //     width: 3.5, //width of the border
                        //     ),
                        //     onPressed: (){
                        //       Navigator.pushNamed(context, '/loading',arguments: {
                        //         'city' : 'Pune' ,
                        //       });
                        //     },
                        //     icon:  Icon(
                        //         Icons.location_city,
                        //         color: Colors.yellow[800]
                        //     ),
                        //   label: Text(
                        //     "Pune" ,
                        //     style: TextStyle(
                        //         color: Colors.deepPurple,
                        //         fontSize: 20.0,
                        //         letterSpacing: 1.5
                        //     ),
                        //   ),
                        // ),
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Pune',
                                });
                          },
                          icon: Icon(Icons.location_city,
                              color: Colors.yellow[800]),
                          label: Text(
                            "Pune",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Mumbai',
                                });
                          },
                          icon: Icon(Icons.location_city,
                              color: Colors.yellow[800]),
                          label: Text(
                            "Mumbai",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Bengaluru',
                                });
                          },
                          icon: Icon(Icons.location_city,
                              color: Colors.yellow[800]),
                          label: Text(
                            "Bengaluru",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Delhi',
                                });
                          },
                          icon: Icon(Icons.location_city,
                              color: Colors.yellow[800]),
                          label: Text(
                            "Delhi",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Kolkata',
                                });
                          },
                          icon: Icon(Icons.location_city,
                              color: Colors.yellow[800]),
                          label: Text(
                            "Kolkata",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loading',
                                arguments: {
                                  'city': 'Srinagar',
                                });
                          },
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.yellow[800],
                          ),
                          label: Text(
                            "Srinagar",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20.0,
                                letterSpacing: 1.5),
                          ),
                        )
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
