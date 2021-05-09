import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bids extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              'auction/6ryNb4f7PPUsrOrNBWqR/List_A/tI6rQMP45gIqhjPIXEC9/players_A')
          // .collection('auctions/VIJZ17NhBTr5AapeXctd/bids')
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
          itemBuilder: (ctx, index) => Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(bidDocs[index]['name']),
                SizedBox(width: 20),
                Text(bidDocs[index]['bidValue'].toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
