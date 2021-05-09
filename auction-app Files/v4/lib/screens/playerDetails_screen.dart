import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerDetails extends StatelessWidget {
  static const routeName = '/playerDetails';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final playerId = routeArgs['playerId'];
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('/players').doc(playerId).get(),
      builder: (ctx, playerSnapshot) {
        if (playerSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // print(playerId);
        final playerData = playerSnapshot.data;
        // print(playerData);
        return Scaffold(
          appBar: AppBar(
            title: Text('Player Stats',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Center(
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      child: Image.network(playerData['imageUrl'])),
                  Text(
                    playerData['name'],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
