import 'package:Auction_App/screens/auctions_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:number_to_words/number_to_words.dart';

class PlayerTile extends StatelessWidget {
  final String playerInfoId;
  final bool isBidding;
  final int lastBidAmt;
  final String lastBidBy;
  final String playerBidId;
  final String collectionPath;

  PlayerTile({
    this.isBidding,
    this.lastBidAmt,
    this.lastBidBy,
    this.playerBidId,
    this.playerInfoId,
    this.collectionPath,
  });

  @override
  Widget build(BuildContext context) {
    // print('Player Info Id : ' + playerInfoId);
    // print('Player Bid Id : ' + playerBidId);

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('/players')
          .doc(playerInfoId)
          .get(),
      builder: (bctx, playerSnapshot) {
        if (playerSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (playerSnapshot.hasError) {
          return Container(
            child: Text("Error ${playerSnapshot.error}"),
          );
        }
        final playerInfoDoc = playerSnapshot.data;

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 10,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(playerInfoDoc['imageUrl']),
              ),
              title: Text(playerInfoDoc['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BP : ' +
                      NumberToWord()
                          .convert('en-in', playerInfoDoc['basePrice'])
                          .toString()
                          .toUpperCase()),
                  Text('CP : ' +
                      NumberToWord()
                          .convert('en-in', lastBidAmt)
                          .toString()
                          .toUpperCase()),
                ],
              ),
              trailing: FlatButton(
                color: Colors.purple,
                child: Text('BID NOW'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AuctionScreen.routeName, arguments: {
                    'playerInfoId': playerInfoId,
                    'playerBidId': playerBidId,
                    'collectionPath': collectionPath,
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
