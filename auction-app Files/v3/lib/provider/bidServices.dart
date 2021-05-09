import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/widgets/adminForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Auction_App/widgets/bidForm.dart';
import 'package:provider/provider.dart';

class BidServices with ChangeNotifier {
  DocumentSnapshot playerDocSnap;
  int _lastBid = 0;

  Future<int> getLastBid(String playerId, String collectionPath) async {
    playerDocSnap = await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .get();

    _lastBid = playerDocSnap['lastBid'];
    return playerDocSnap['lastBid'];
  }

  void _updateLastBid(String playerId, String collectionPath, int bidValue,
      String bidBy, String lastBidByID) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .update({
      'lastBid': bidValue,
      'lastBidBy': bidBy,
      'lastBidById': lastBidByID
    });
  }

  Future<void> addNewBid(String playerId, int bidValue, String collectionPath,
      BuildContext ctx) async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('teams')
        .doc(user.uid)
        .get();

    // bool isBiddingStatus = await getBiddingStatus(playerId, collectionPath);
    if (bidValue > _lastBid) {
      _updateLastBid(playerId, collectionPath, bidValue, userData['teamName'],
          userData.id);
      FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(playerId)
          .collection('bids')
          .add({
        'bidValue': bidValue,
        'bidAt': Timestamp.now(),
        'bidBy': userData['teamName'],
        'bidById': userData.id,
      });
      _updateLastBid(playerId, collectionPath, bidValue, userData['teamName'],
          userData.id);
    } else {
      print("Error");
    }
  }

  Future<void> showErrorDialog(BuildContext ctx, String msg1, String msg2) {
    return showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(msg1),
        content: Text(msg2),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void openBidSheet(BuildContext ctx, String playerId, String collectionPath) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Provider.of<AdminServices>(ctx, listen: false).isAdmin
              ? AdminForm()
              : BidForm(playerId, collectionPath),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<bool> getBiddingStatus(String playerId, String collectionPath) async {
    playerDocSnap = await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .get();

    // _isBiddingStatus = playerDocSnap['isBidding'];
    notifyListeners();
    // print("From Function Button: " + playerDocSnap['isBidding'].toString());
    return playerDocSnap['isBidding'];
  }
}
