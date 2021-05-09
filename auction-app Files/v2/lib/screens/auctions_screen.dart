import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';

import 'package:Auction_App/provider/bidServices.dart';
import 'package:Auction_App/provider/adminServices.dart';

class AuctionScreen extends StatefulWidget {
  static const routeName = '/auction';

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;

    final playerId = routeArgs['id'];
    final collectionPath = routeArgs['collectionPath'];
    // print(routeArgs);
    final bidsServiceData = Provider.of<BidServices>(context, listen: false);
    final adminData = Provider.of<AdminServices>(context);
    // print(adminData.isAdmin);

    bool startButtonStatus;
    bool stopButtonStatus;

    Future<void> buttonControl() async {
      bool biddingStatus =
          await bidsServiceData.getBiddingStatus(playerId, collectionPath);

      if (biddingStatus == true) {
        startButtonStatus = false;
        stopButtonStatus = true;
      } else {
        startButtonStatus = true;
        stopButtonStatus = false;
      }
      // print("Data from button : " + biddingStatus.toString());
    }

    buttonControl();

    return Scaffold(
      appBar: AppBar(
        title: adminData.isAdmin ? Text('Admin') : Text('Auction Screen '),
        actions: [
          if (adminData.isAdmin)
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (val) {
                if (val == 'Start') {
                  adminData.controlBidding(playerId, collectionPath);
                  buttonControl();
                }
                if (val == 'Stop') {
                  adminData.controlBidding(playerId, collectionPath);
                  buttonControl();
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.pause_circle_filled, color: Colors.red),
                      Text('Stop bidding'),
                    ],
                  )),
                  value: 'Stop',
                  enabled: stopButtonStatus,
                ),
                PopupMenuItem(
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.play_arrow_rounded, color: Colors.green),
                      Text('Start bidding'),
                    ],
                  )),
                  value: 'Start',
                  enabled: startButtonStatus,
                ),
              ],
            ),
        ],
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
          onPressed: () async {
            // print(await bidsServiceData.getBiddingStatus(
            //     playerId, collectionPath));
            await bidsServiceData.getBiddingStatus(playerId, collectionPath)
                ? bidsServiceData.openBidSheet(
                    context, playerId, collectionPath)
                : bidsServiceData.showErrorDialog(context, "An Error Occured!",
                    "You were slow !!.\nCheck the current Bid Price");
          }),
    );
  }
}
