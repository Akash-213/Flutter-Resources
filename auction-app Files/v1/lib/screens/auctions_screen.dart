import 'package:Auction_App/widgets/bidForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';

class AuctionScreen extends StatelessWidget {
  static const routeName = '/auction';

  DocumentSnapshot playerDocSnap;
  int _lastBid = 0;

  void _showErrorDialog(BuildContext ctx) {
    print('working - 1');
    // showDialog(
    //   context: ctx,
    //   builder: (_) => AlertDialog(
    //     title: Text("An Error Occured!"),
    //     content: Text("You were slow !!.Check the current Bid Price"),
    //     actions: [
    //       FlatButton(
    //         child: Text('Okay'),
    //         onPressed: () {
    //           Navigator.of(ctx).pop();
    //         },
    //       )
    //     ],
    //   ),
    // );
    // Scaffold.of(ctx).showSnackBar(SnackBar(
    //   content: Text(
    //     'Error Check Current Price!',
    //     textAlign: TextAlign.center,
    //   ),
    // ));
    print('working - 2');
  }

  void _addNewBid(String playerId, int bidValue, String collectionPath,
      BuildContext ctx) async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('teams')
        .doc(user.uid)
        .get();

    if (bidValue > _lastBid) {
      _updateLastBid(playerId, bidValue, userData['teamName'], collectionPath);
      FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(playerId)
          .collection('bids')
          .add({
        'bidValue': bidValue,
        'bidAt': Timestamp.now(),
        'bidBy': userData['teamName'],
      });
      _updateLastBid(playerId, bidValue, userData['teamName'], collectionPath);
    } else {
      print("Error");

      // _showErrorDialog(ctx);
      // Navigator.of(ctx).pop();
    }

    // _updateLastBid(playerId, bidValue, userData['teamName'], collectionPath);
  }

  void _updateLastBid(
    String playerId,
    int bidValue,
    String bidBy,
    String collectionPath,
  ) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .update({'lastBid': bidValue, 'lastBidBy': bidBy});
  }

  void _getLastBid(String playerId, String collectionPath) async {
    playerDocSnap = await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .get();

    _lastBid = playerDocSnap['lastBid'];
  }

  int get lastBid {
    return _lastBid;
  }

  void _openBidSheet(BuildContext ctx, String playerId, String collectionPath) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: BidForm(
            playerId,
            collectionPath,
            _addNewBid,
            lastBid,
            _getLastBid,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;

    final playerId = routeArgs['id'];
    final collectionPath = routeArgs['collectionPath'];
    // print(routeArgs);

    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Screen '),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(collectionPath)
              .doc(playerId)
              .collection('bids')
              .orderBy('bidValue', descending: true)
              .snapshots(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final bidDocs = snapShot.data.docs;
            return ListView.builder(
              itemCount: bidDocs.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  // Text(playerDocSnap[index]['name']),
                  // Text(playerDocSnap[index]['basePrice']),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(bidDocs[index]['bidValue'].toString()),
                            Text(NumberToWord()
                                .convert('en-in', bidDocs[index]['bidValue'])
                                .toString()
                                .toUpperCase()),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(bidDocs[index]['bidBy']),
                            Text(DateFormat.jms().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    bidDocs[index]['bidAt'].seconds * 1000))),
                            Text(DateFormat.MEd()
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    bidDocs[index]['bidAt'].seconds * 1000))
                                .toString()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _openBidSheet(context, playerId, collectionPath);
            // _getLastBid(playerId, collectionPath);
          }),
    );
  }
}
