import 'package:Auction_App/screens/auctions_screen.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:number_to_words/number_to_words.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a player',
                  prefixIcon: Icon(Icons.sports_cricket),
                  suffixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.purple[600]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collectionPath)
                    .snapshots(),
                builder: (ctx, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final playerDocs = snapShot.data.docs;

                  //playerInfoId -> extra Info  players Collection
                  //playerBidId -> Bid info auction Collection

                  return GridView.builder(
                    itemCount: playerDocs.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (ctx, index) {
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('/players')
                            .doc(playerDocs[index]['playerId'])
                            .get(),
                        builder: (ctx, playerSnapshot) {
                          if (playerSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final playerData = playerSnapshot.data;
                          // print(playerData['name']);
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AuctionScreen.routeName,
                                  arguments: {
                                    'playerInfoId': playerDocs[index]
                                        ['playerId'],
                                    'playerBidId': playerDocs[index].id,
                                    'collectionPath': collectionPath,
                                  });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 4,
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                            playerData['imageUrl'],
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 3,
                                        child: Container(
                                          color: Colors.black54,
                                          child: Text(playerData['name'],
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 3,
                                        child: Container(
                                            color: Colors.black54,
                                            child: FaIcon(
                                              FontAwesomeIcons.gavel,
                                              color: Colors.amber,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'BP : ' +
                                          NumberToWord()
                                              .convert('en-in',
                                                  playerData['basePrice'])
                                              .toString()
                                              .toUpperCase(),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'CP : ' +
                                          NumberToWord()
                                              .convert('en-in',
                                                  playerDocs[index]['lastBid'])
                                              .toString()
                                              .toUpperCase(),
                                      // softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
