import 'package:Auction_App/widgets/adminForm.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminServices extends ChangeNotifier {
  bool isAdmin;
  bool startButton;
  bool stopButton;
  DocumentSnapshot playerDocSnap;

  Future<void> getAdminStatus() async {
    var currentUserId = FirebaseAuth.instance.currentUser.uid;

    print(currentUserId);

    playerDocSnap = await FirebaseFirestore.instance
        .collection('teams')
        .doc(currentUserId)
        .get();

    isAdmin = await playerDocSnap['isAdmin'];
    print(playerDocSnap['isAdmin']);
  }

  Future<void> buttonControl() {
    startButton = !startButton;
    stopButton = !stopButton;
  }

  Future<void> controlBidding(String playerId, String collectionPath) async {
    var isBiddingPath =
        FirebaseFirestore.instance.collection(collectionPath).doc(playerId);

    var isBiddingData = await isBiddingPath.get();
    if (isBiddingData['isBidding'] == true) {
      isBiddingPath.update({'isBidding': false});
    } else {
      isBiddingPath.update({'isBidding': true});
    }

    notifyListeners();
  }

  Future<void> stopAllBidding(String collectionPath) async {
    String finalCollection = '/auction/6ryNb4f7PPUsrOrNBWqR/$collectionPath';

    // print(finalCollection);

    var dataSnapshots =
        FirebaseFirestore.instance.collection(finalCollection).get();

    print(dataSnapshots);

    dataSnapshots.then((data) {
      print(data.docs.length);

      for (int i = 0; i < data.docs.length; i++) {
        FirebaseFirestore.instance
            .collection(finalCollection)
            .doc(data.docs[i].id)
            .update({'isBidding': false});
      }
    });
  }

  Future<void> startAllBidding(String collectionPath) async {
    String finalCollection = '/auction/6ryNb4f7PPUsrOrNBWqR/$collectionPath';

    // print(finalCollection);

    var dataSnapshots =
        FirebaseFirestore.instance.collection(finalCollection).get();

    // print(dataSnapshots);

    dataSnapshots.then((data) {
      // print(data.docs.length);

      for (int i = 0; i < data.docs.length; i++) {
        FirebaseFirestore.instance
            .collection(finalCollection)
            .doc(data.docs[i].id)
            .update({'isBidding': true});
      }
    });
  }

  Future<void> allocateToTeams(collectionPath) async {
    final finalcollection = '/auction/6ryNb4f7PPUsrOrNBWqR/$collectionPath/';

    try {
      var bidDataSnapshots =
          FirebaseFirestore.instance.collection(finalcollection).get();

      bidDataSnapshots.then((data) async {
        // print(data.docs[0]['lastBidById']);
        for (int i = 0; i < data.docs.length; i++) {
          var bidByID = data.docs[i]['lastBidById'];

          // print('Id : ' + bidByID);

          await FirebaseFirestore.instance
              .collection('teams')
              .doc(bidByID)
              .collection('myTeam')
              .add({
            'playerName': data.docs[i]['name'],
            'bidAmt': data.docs[i]['lastBid'],
            'playerId': data.docs[i]['playerId'],
          });
        }
      });
    } catch (e) {
      print("Error : " + e);
    }
  }

  void openAdminSheet(BuildContext ctx, String playerInfoId) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AdminForm(playerInfoId),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> addAdminMsg(String playerInfoId, String msg) async {
    await FirebaseFirestore.instance
        .collection('players')
        .doc(playerInfoId)
        .collection('messages')
        .add({
      'text': msg,
      'timeStamp': Timestamp.now(),
    });
  }
}
