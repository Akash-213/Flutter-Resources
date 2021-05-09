import 'package:Auction_App/provider/playersServices.dart';
import 'package:Auction_App/widgets/adminList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/adminScreen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AdminList('A', 'List_A/tI6rQMP45gIqhjPIXEC9/players_A'),
            AdminList('B', 'List_B/8aFpxi6QSXpDscyzbkYY/players_B'),
            AdminList('C', 'List_C/eGTKmhz8y1xF8uo3tek0/players_C'),
            AdminList('D', 'List_D/7cD8GOk0O5QPkNzIhmPR/players_D'),
          ],
        ),
      ),
    );
  }
}
