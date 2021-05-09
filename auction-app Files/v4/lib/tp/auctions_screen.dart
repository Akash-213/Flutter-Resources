import 'package:Auction_App/provider/playersServices.dart';
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

    PageController pageController = PageController(initialPage: 1);

    Future<void> buttonControl() async {
      bool biddingStatus =
          await bidsServiceData.getBiddingStatus(playerBidId, collectionPath);

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

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: adminData.isAdmin ? Text('Admin') : Text('Auction Screen '),
        actions: [
          if (adminData.isAdmin)
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (val) {
                if (val == 'Start') {
                  adminData.controlBidding(playerBidId, collectionPath);
                  buttonControl();
                }
                if (val == 'Stop') {
                  adminData.controlBidding(playerBidId, collectionPath);
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
          return PageView(
            controller: pageController,
            children: [
              // Info Page
              // statsPage(screenSize, playerInfoDoc),

              //Main Page
              // playerPage(
              //     screenSize, playerInfoDoc, collectionPath, playerBidId),

              // Bidding Page
              // biddingPage(screenSize, collectionPath, playerBidId),
              Stack(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: Image.network(
                        playerInfoDoc['imageUrl'],
                        width: double.infinity,
                        // height: screenSize.height * 0.35,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // print(await bidsServiceData.getBiddingStatus(
            //     playerId, collectionPath));
            await bidsServiceData.getBiddingStatus(playerBidId, collectionPath)
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

// Widget statsPage(screenSize, playerInfoDoc) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 20),
//     child: Container(
//       decoration: BoxDecoration(
//           color: Colors.blue[50],
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(45), topRight: Radius.circular(45))),
//       height: screenSize.height * 0.6,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Player Statistics',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
//           ),
//           CircleAvatar(
//             radius: 100,
//             backgroundImage: NetworkImage(playerInfoDoc['imageUrl']),
//           ),
//           Text(playerInfoDoc['name'],
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
//         ],
//       ),
//     ),
//   );
// }

//Player Page
Widget playerPage(screenSize, playerInfoDoc, collectionPath, playerBidId) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Image.network(playerInfoDoc['imageUrl']),
      ),
      Positioned(
        top: screenSize.height * 0.35,
        child: Container(
          width: screenSize.width,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Player Info',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28))),
              Text('Name : ' + playerInfoDoc['name'],
                  style: TextStyle(fontSize: 18)),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(collectionPath)
                      .doc(playerBidId)
                      .snapshots(),
                  builder: (bctx, playerBidSnapshot) {
                    if (playerBidSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (playerBidSnapshot.hasError) {
                      return Container(
                        child: Text("Error ${playerBidSnapshot.error}"),
                      );
                    }
                    final playerBidDoc = playerBidSnapshot.data;

                    return Column(
                      children: [
                        Text(
                            'Base Price : ' +
                                playerBidDoc['basePrice'].toString(),
                            style: TextStyle(fontSize: 18)),
                        Text(
                            'Current Price : ' +
                                playerBidDoc['lastBid'].toString(),
                            style: TextStyle(fontSize: 18)),
                        Text('Last Bid By : ' + playerBidDoc['lastBidBy'],
                            style: TextStyle(fontSize: 18)),
                        Text(
                            'Bidding Status : ' +
                                playerBidDoc['isBidding']
                                    .toString()
                                    .toUpperCase(),
                            style: TextStyle(fontSize: 18)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// bidding Page
Widget biddingPage(screenSize, collectionPath, playerBidId) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45))),
      height: screenSize.height * 0.6,
      child: Column(
        children: [
          Text(
            'Bidding Section',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collectionPath)
                    .doc(playerBidId)
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
                    itemBuilder: (ctx, index) => Padding(
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
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
