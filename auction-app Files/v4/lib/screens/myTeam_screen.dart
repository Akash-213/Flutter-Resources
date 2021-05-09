import 'package:Auction_App/screens/myWallet_screen.dart';
import 'package:Auction_App/screens/playerDetails_screen.dart';
import 'package:Auction_App/widgets/appDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTeam extends StatelessWidget {
  static const routeName = '/myTeam';

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    // print(user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Team',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: Icon(Icons.account_balance_wallet_outlined),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(MyWallet.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/images/cricket.png')),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('/teams')
                    .doc(user.uid)
                    .collection('myTeam')
                    .get(),
                builder: (bctx, myTeamData) {
                  if (myTeamData.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final myTeamDataDocs = myTeamData.data.docs;
                  if (myTeamDataDocs.length == 0) {
                    return Center(child: Text('No players in your Team yet'));
                  }
                  return ListView.builder(
                      itemCount: myTeamDataDocs.length,
                      itemBuilder: (ctx, index) {
                        return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('players')
                              .doc(myTeamDataDocs[index]['playerId'])
                              .get(),
                          builder: (ctx, playerSnapshot) {
                            if (playerSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            final playerData = playerSnapshot.data;

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlayerDetails.routeName,
                                      arguments: {
                                        'playerId': myTeamDataDocs[index]
                                            ['playerId'],
                                      });
                                },
                                child: Card(
                                  elevation: 10,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(playerData['imageUrl']),
                                    ),
                                    title: Text(playerData['name']),
                                    subtitle: Text('Bought At : ' +
                                        myTeamDataDocs[index]['bidAmt']
                                            .toString()),
                                    trailing: FaIcon(
                                      FontAwesomeIcons.solidEye,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
