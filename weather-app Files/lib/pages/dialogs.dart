import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction { tryagain }

class Dialogs {
  static Future<void> tryagainDialog(
    BuildContext context,
  ) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 30.0,
                ),
                Text(
                  "OOPS !!",
                  style: TextStyle(fontSize: 30.0),
                ),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 30.0,
                ),
              ],
            ),
            content: Text(
              "City not Found !!!"
              "\nCheck your spelling !!"
              "\nCheck Internet Connection !",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.purple[800],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.purple[900],
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false),
                  child: Text(
                    "Try Again",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
              )
            ],
          );
        });
  }
}
