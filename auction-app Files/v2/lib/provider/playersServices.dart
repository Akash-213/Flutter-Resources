import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Player {
  String name;
  int basePrice;
  String imageUrl;
  bool isBidding;
  int lastBid;
  String lastBidBy;

  Player({
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
  getPlayersFromSheet() async {
    var playersData = await http.get(url);

    var jsonPlayersData = jsonDecode(playersData.body);

    jsonPlayersData.forEach((element) {
      Player player = new Player(
        name: element['name'],
        basePrice: element['baseprice'],
        imageUrl: element['imageUrl'],
        isBidding: element['isBidding'],
        lastBid: element['lastBid'],
        lastBidBy: element['lastBidBy'],
      );

      // print("Name : ${player.name}");
      // print("Is Bidding : ${player.isBidding}");
      // print(player.basePrice);

      allPlayers.add(player);
    });
    print("Done");
  }

  addDatatoFireStore() {
    allPlayers.forEach((player) async {
      await FirebaseFirestore.instance
          .collection(
              'auction/6ryNb4f7PPUsrOrNBWqR/List_A/tI6rQMP45gIqhjPIXEC9/players_A')
          .add({
        'name': player.name,
        'basePrice': player.basePrice,
        'imageUrl': player.imageUrl,
        'isBidding': player.isBidding,
        'lastBid': player.lastBid,
        'lastBidBy': player.lastBidBy,
      });
      print(player.name);
      print(player.isBidding);
    });

    print("Successfully Added Data in FireStore");
  }

  deleteDataFromFireStore() {
    allPlayers = [];
  }
}
