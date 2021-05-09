import 'package:Auction_App/provider/playersServices.dart';
import 'package:Auction_App/screens/myWallet_screen.dart';
import 'package:Auction_App/screens/playerDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    final playerInfoId = routeArgs['playerInfoId'];
    final playerBidId = routeArgs['playerBidId'];
    final collectionPath = routeArgs['collectionPath'];
    // print(routeArgs);

    final bidsServiceData = Provider.of<BidServices>(context, listen: false);
    final adminData = Provider.of<AdminServices>(context, listen: false);
    final playerData = Provider.of<PlayersServices>(context, listen: false);
    // print(adminData.isAdmin);

    bool startButtonStatus;
    bool stopButtonStatus;

    Future<void> buttonControl() async {
      bool biddingStatus =
          await bidsServiceData.getBiddingStatus(playerBidId, collectionPath);

      if (biddingStatus == true) {
        startButtonStatus = false;
        stopButtonStatus = true;
        // setState(() {});
      } else {
        startButtonStatus = true;
        stopButtonStatus = false;
        // setState(() {});
      }
      // print("Data from button : " + biddingStatus.toString());
    }

    buttonControl();

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: adminData.isAdmin
            ? Text('Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))
            : Text('Auction Screen ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
        actions: [
          if (!adminData.isAdmin)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.wallet),
                onPressed: () =>
                    Navigator.of(context).pushNamed(MyWallet.routeName),
              ),
            ),
          if (adminData.isAdmin)
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (val) async {
                if (val == 'Start') {
                  adminData.controlBidding(playerBidId, collectionPath);
                  await buttonControl();
                  setState(() {});
                }
                if (val == 'Stop') {
                  adminData.controlBidding(playerBidId, collectionPath);
                  await buttonControl();
                  setState(() {});
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
                      Text('Start bidding')
                    ],
                  )),
                  value: 'Start',
                  enabled: startButtonStatus,
                ),
              ],
            ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('/players')
            .doc(playerInfoId)
            .get(),
        builder: (bctx, playerInfoSnapshot) {
          final playerInfoDoc = playerInfoSnapshot.data;
          if (playerInfoSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (playerInfoSnapshot.hasError) {
            return Container(
              child: Text("Error ${playerInfoSnapshot.error}"),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Image.network(
                        playerInfoDoc['imageUrl'],
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: screenSize.height * 0.30,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 0,
                    child: RaisedButton(
                      color: Colors.black54,
                      child: Row(
                        children: [
                          Icon(Icons.graphic_eq, size: 18),
                          SizedBox(width: 4),
                          Text(
                            'View Stats',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PlayerDetails.routeName, arguments: {
                          'playerId': playerInfoId,
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: RaisedButton(
                        color: Colors.black54,
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.gavel, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Bid Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          await bidsServiceData.getBiddingStatus(
                                  playerBidId, collectionPath)
                              ? bidsServiceData.openBidSheet(
                                  context, playerBidId, collectionPath)
                              : bidsServiceData.showErrorDialog(
                                  context,
                                  "An Error Occured !!",
                                  "Bidding has been Stopped By the Admin.\nFor further query contact Admin");
                        }),
                  ),
                ],
              ),
              adminMessageSection(screenSize, playerInfoId),
              biddingPage(screenSize, collectionPath, playerBidId),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: adminData.isAdmin
              ? Icon(Icons.admin_panel_settings_outlined)
              : Icon(Icons.add),
          onPressed: () async {
            // print(await bidsServiceData.getBiddingStatus(
            //     playerId, collectionPath));
            adminData.isAdmin
                ? adminData.openAdminSheet(context, playerInfoId)
                : await bidsServiceData.getBiddingStatus(
                        playerBidId, collectionPath)
                    ? bidsServiceData.openBidSheet(
                        context, playerBidId, collectionPath)
                    : bidsServiceData.showErrorDialog(
                        context,
                        "An Error Occured !!",
                        "Bidding has been Stopped By the Admin.\nFor further query contact Admin");
          }),
    );
  }
}

Widget adminMessageSection(screenSize, String playerInfoId) {
  return Container(
    height: screenSize.height * 0.03,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('players')
            .doc(playerInfoId)
            .collection('messages')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: Text('Admin Message Here')),
              width: double.infinity,
              color: Colors.red,
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Container(
              child: Center(child: Text('Admin Message Here')),
              width: double.infinity,
              color: Colors.red,
            );
          }
          print('Admin Msg here');
          // print(snapshot.data.docs[0]['text']);
          return Container(
            child: Center(
              child: Text(snapshot.data.docs[0]['text']),
            ),
            width: double.infinity,
            color: Colors.red,
          );
        }),
  );
}

// bidding Page
Widget biddingPage(screenSize, collectionPath, playerBidId) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45))),
    height: screenSize.height * 0.55,
    child: Column(
      children: [
        Text('Bidding Section',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(collectionPath)
                  .doc(playerBidId)
                  .collection('bids')
                  .orderBy('bidValue', descending: true)
                  .orderBy('bidAt')
                  .snapshots(),
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapShot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(snapShot.data);
                final bidDocs = snapShot.data.docs;
                // print(bidDocs[0]['bidAt']);
                return ListView.builder(
                  itemCount: bidDocs.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
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
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
