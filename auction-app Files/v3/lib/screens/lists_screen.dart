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
          final playerDocs = snapShot.data.docs;

          return ListView.builder(
            itemCount: playerDocs.length,
            itemBuilder: (ctx, index) => PlayerTile(
              name: playerDocs[index]['name'],
              basePrice: playerDocs[index]['basePrice'],
              currentPrice: playerDocs[index]['lastBid'],
              imageUrl: playerDocs[index]['imageUrl'],
              isBidding: playerDocs[index]['isBidding'],
              playerId: playerDocs[index].id,
              collectionPath: collectionPath,
            ),
          );
        },
      ),
    );
  }
}
