import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Auction_App/widgets/bidForm.dart';

class BidServices with ChangeNotifier {
  DocumentSnapshot playerDocSnap;
  int _lastBid = 0;
  int _walletAmt = 0;
  int _amtDiff = 0;

  Future<int> getwalletAmt(String teamId) async {
    var playerDocSnap2 =
        await FirebaseFirestore.instance.collection('teams').doc(teamId).get();
    _walletAmt = playerDocSnap2['walletAmt'];
    return playerDocSnap2['walletAmt'];
  }

  Future<void> updateWallet(int amt, String teamId) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .update({'walletAmt': amt});
  }

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

    if (await getwalletAmt(userData.id) > bidValue) {
      _amtDiff = bidValue - _lastBid;
      // print("Before  : " + _lastBid.toString());
      // print('Bid value : ' + bidValue.toString());
      // print('Amount Diff : ' + _amtDiff.toString());
      // first Adding the Bid

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
        print("TimeStamp : " + Timestamp.now().toString());
      } else {
        print("Error");
      }

      //updating the wallet
      _walletAmt = _walletAmt - _amtDiff;
      await updateWallet(_walletAmt, userData.id);

      // print("Wallet Amount  : " + _walletAmt.toString());
    } else {
      print('No enough amount in wallet');
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
          child: BidForm(playerId, collectionPath),
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
