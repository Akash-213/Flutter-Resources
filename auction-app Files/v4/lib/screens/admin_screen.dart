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
  // Widget snackBar(String title) {
  //   return SnackBar(
  //     content: Text(title),
  //     duration: Duration(seconds: 2),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final playerServices = Provider.of<PlayersServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (val) async {
              if (val == 'Import') {
                await playerServices.getPlayersFromSheet();
                print("done in admin screen");

                snackBar('Sucessfully Added Data');
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.import_export, color: Colors.red),
                    Text('Import'),
                  ],
                )),
                value: 'Import',
              ),
            ],
          ),
        ],
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

  Widget snackBar(String title) {
    return Builder(
      builder: (ctx) {
        return SnackBar(
          content: Text(title),
          duration: Duration(seconds: 2),
        );
      },
    );
  }
}
