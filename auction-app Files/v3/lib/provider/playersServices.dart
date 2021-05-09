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

  List<Player> allPlayers = [];
  List<Player> players_A = [];
  List<Player> players_B = [];
  List<Player> players_C = [];
  List<Player> players_D = [];

  Future<void> getPlayersFromSheet() async {
    var playersData = await http.get(url);

    var jsonPlayersData = await jsonDecode(playersData.body);

    jsonPlayersData.forEach((element) {
      Player player = new Player(
        section: element['section'],
        name: element['name'],
        basePrice: element['baseprice'],
        imageUrl: element['imageUrl'],
        // isBidding: element['isBidding'],
        // lastBid: element['lastBid'],
        // lastBidBy: element['lastBidBy'],
      );

      allPlayers.add(player);
    });
    // add all Players to players collection in Firestore
    allPlayers.forEach((player) async {
      await FirebaseFirestore.instance.collection('/players').add({
        'section': player.section,
        'name': player.name,
        'basePrice': player.basePrice,
        'imageUrl': player.imageUrl,
      });
    });

    // players_A = allPlayers.where((player) => player.section == 'A').toList();
    // players_B = allPlayers.where((player) => player.section == 'B').toList();
    // players_C = allPlayers.where((player) => player.section == 'C').toList();
    // players_D = allPlayers.where((player) => player.section == 'D').toList();
    print("Done");
    return;
  }

  Future<void> sortAndSetData(String listType, String sectionString) async {
    final playersData =
        await FirebaseFirestore.instance.collection('/players').get();

    playersData.docs.forEach((player) async {
      if (player['section'] == listType) {
        await FirebaseFirestore.instance
            .collection('auction/6ryNb4f7PPUsrOrNBWqR/$sectionString')
            .add({
          'name': player['name'],
          'playerId': player.id,
          'basePrice': player['basePrice'],
          'isBidding': true,
          'lastBid': null,
          'lastBidBy': null,
        });
      }
    });

    print("Done Importing");
  }

  Future<void> addDatatoFireStore(String listType, String sectionString) {
    List<Player> list = allPlayers;

    switch (listType) {
      case 'A':
        list = players_A;
        break;
      case 'B':
        list = players_B;
        break;
      case 'C':
        list = players_C;
        break;
      case 'D':
        list = players_D;
        break;
    }

    list.forEach((player) async {
      await FirebaseFirestore.instance
          .collection('auction/6ryNb4f7PPUsrOrNBWqR/$sectionString')
          .add({
        'name': player.name,
        'basePrice': player.basePrice,
        'imageUrl': player.imageUrl,
        'isBidding': player.isBidding,
        'lastBid': player.lastBid,
        'lastBidBy': player.lastBidBy,
      });
      // print(player.name);
      // print(player.isBidding);
    });

    print("Successfully Added Data in FireStore");
    // return;
  }

  void deleteActiveData() {
    allPlayers = [];
  }

  Future<Player> getPlayer(String playerId, String collectionPath) async {
    var playerData = await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(playerId)
        .get();

    Player player = new Player(
      name: playerData['name'],
      basePrice: playerData['basePrice'],
      imageUrl: playerData['imageUrl'],
      isBidding: playerData['isBidding'],
      lastBid: playerData['lastBid'],
      lastBidBy: playerData['lastBidBy'],
    );

    return player;
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    var user =
        FirebaseFirestore.instance.collection('/teams').doc(userId).get();

    return user;
  }
}
