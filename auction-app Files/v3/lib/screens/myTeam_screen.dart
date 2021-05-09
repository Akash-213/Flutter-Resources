import 'package:Auction_App/provider/playersServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTeam extends StatelessWidget {
  static const routeName = '/myTeam';

  // String collectionPath;

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    // print(user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Team Name ${user.displayName}'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('/teams')
            .doc(user.uid)
            .collection('myTeam')
            .get(),
        builder: (bctx, myTeamData) {
          if (myTeamData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final myTeamDataDocs = myTeamData.data.docs;

          return ListView.builder(
              itemCount: myTeamDataDocs.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('imageUrl'),
                      ),
                      title: Text(myTeamDataDocs[index]['playerName']),
                      subtitle:
                          Text(myTeamDataDocs[index]['bidAmt'].toString()),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
