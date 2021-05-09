import 'package:flutter/material.dart';
import 'package:Auction_App/widgets/playerTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListsScreen extends StatelessWidget {
  static const routeName = '/lists';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;

    final titleName = routeArgs['titleName'];
    final collectionPath = routeArgs['collectionPath'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titleName),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(collectionPath).snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final bidDocs = snapShot.data.docs;

          return ListView.builder(
            itemCount: bidDocs.length,
            itemBuilder: (ctx, index) => PlayerTile(
              bidDocs[index]['name'],
              bidDocs[index]['basePrice'].toString(),
              bidDocs[index]['lastBid'].toString(),
              bidDocs[index].id,
              collectionPath,
            ),
          );
        },
      ),
    );
  }
}
