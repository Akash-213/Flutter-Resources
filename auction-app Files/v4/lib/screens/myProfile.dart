import 'package:Auction_App/screens/myTeam_screen.dart';
import 'package:Auction_App/screens/myWallet_screen.dart';
import 'package:Auction_App/widgets/appDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  static const routeName = '/myProfile';

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // drawer: AppDrawer(),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 120,
                      ),
                      radius: 75),
                ),
                SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Team Name',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Text('Team Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Id',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(user.email,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('View Team'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, MyTeam.routeName);
                      },
                    ),
                    RaisedButton(
                      child: Text('Check Wallet'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, MyWallet.routeName);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
