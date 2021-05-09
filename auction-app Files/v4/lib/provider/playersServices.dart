import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Player {
  String section;
  String name;
  int basePrice;
  String imageUrl;
  bool isBidding;
  int lastBid;
  String lastBidBy;

  Player({
    this.section,
    this.basePrice,
    this.isBidding,
    this.lastBid,
    this.lastBidBy,
    this.name,
    this.imageUrl,
  });
}

class PlayersServices extends ChangeNotifier {
  final url =
      'https://script.google.com/macros/s/AKfycbw185YwBaNehPX5sSj5728EqoiwUiKVZ5rQGbf1p7apBhIwMB_cDK09bw/exec';

  Future<void> getPlayersFromSheet() async {
    var playersData = await http.get(url);

    var jsonPlayersData = await jsonDecode(playersData.body);

    jsonPlayersData.forEach((element) async {
      Player player = new Player(
        section: element['section'],
        name: element['name'],
        basePrice: element['baseprice'],
        imageUrl: element['imageUrl'],
        // isBidding: element['isBidding'],
        // lastBid: element['lastBid'],
        // lastBidBy: element['lastBidBy'],
      );

      await FirebaseFirestore.instance.collection('/players').add({
        'section': player.section,
        'name': player.name,
        'basePrice': player.basePrice,
        'imageUrl': player.imageUrl,
      });
    });

    print("Done Importing");
    return;
  }

  Future<void> sortAndSetData(String listType, String sectionString) async {
    final playersData =
        await FirebaseFirestore.instance.collection('/players').get();

    playersData.docs.forEach((player) async {
      if (player['section'] == listType) {
        await FirebaseFirestore.instance
            .collection('auction/1Ga1i4GKRHk8nLT49zGz/$sectionString')
            .add({
          'name': player['name'],
          'playerId': player.id,
          'basePrice': player['basePrice'],
          'isBidding': true,
          'lastBid': player['basePrice'],
          'lastBidBy': 'None',
          'lastBidById': 'none',
        });
      }
    });
    print("Done Sorting and Setting");
  }

  Future<DocumentSnapshot> getPlayer(String playerId) async {
    var playerData =
        FirebaseFirestore.instance.collection('/players').doc(playerId).get();

    print(playerData);
    return playerData;
  }

  // void getUser(String userId) {
  //   var user =
  //       FirebaseFirestore.instance.collection('/teams').doc(userId).get();

  //   return user;
  // }
}
