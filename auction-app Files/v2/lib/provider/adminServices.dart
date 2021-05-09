import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminServices extends ChangeNotifier {
  bool isAdmin = false;

  bool startButton = true;
  bool stopButton = false;

  Future<void> changetoAdmin() {
    isAdmin = true;
    notifyListeners();
  }

  Future<void> adminSignout() {
    isAdmin = false;
    notifyListeners();
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
}
