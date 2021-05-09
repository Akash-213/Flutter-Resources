import 'package:Auction_App/screens/auctions_screen.dart';
import 'package:flutter/material.dart';

import 'package:number_to_words/number_to_words.dart';

class PlayerTile extends StatelessWidget {
  final String name;
  final int basePrice;
  final int currentPrice;
  final String playerId;
  final String collectionPath;
  final String imageUrl;
  final bool isBidding;

  PlayerTile({
    this.name,
    this.basePrice,
    this.currentPrice,
    this.playerId,
    this.collectionPath,
    this.imageUrl,
    this.isBidding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BP : ' +
                  NumberToWord()
                      .convert('en-in', basePrice)
                      .toString()
                      .toUpperCase()),
              Text('CP : ' +
                  NumberToWord()
                      .convert('en-in', currentPrice)
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
                'id': playerId,
                'collectionPath': collectionPath,
              });
            },
          ),
        ),
      ),
    );
  }
}
