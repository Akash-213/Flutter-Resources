import 'package:Auction_App/screens/myTeam_screen.dart';
import 'package:Auction_App/widgets/appDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words/number_to_words.dart';

class MyWallet extends StatelessWidget {
  static const routeName = '/myWallet';
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Wallet ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.people_alt_outlined),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MyTeam.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/wallet.png')),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('teams')
                      .doc(user.uid)
                      .get(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '₹ ${snapshot.data['walletAmt'].toString()}',
                                style: TextStyle(fontSize: 50),
                              ),
                              SizedBox(height: 40),
                              Text(
                                NumberToWord()
                                    .convert(
                                        'en-in', snapshot.data['walletAmt'])
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(fontSize: 20),
                                softWrap: true,
                              ),
                            ],
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
}
