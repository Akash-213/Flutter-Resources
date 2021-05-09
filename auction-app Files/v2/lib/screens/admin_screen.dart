import 'package:Auction_App/provider/playersServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/adminScreen';
  @override
  Widget build(BuildContext context) {
    final playerServices = Provider.of<PlayersServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen"),
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text("Fetch Data from Google Sheet"),
              onPressed: () {
                playerServices.getPlayersFromSheet();
              },
            ),
            RaisedButton(
              child: Text("Add Data to FireStore"),
              onPressed: () {
                playerServices.addDatatoFireStore();
                playerServices.deleteDataFromFireStore();
              },
            ),
          ],
        ),
      ),
    );
  }
}
