import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/provider/playersServices.dart';
import 'package:Auction_App/screens/admin_screen.dart';
import 'package:Auction_App/screens/allTeams.dart';

import 'package:Auction_App/screens/bucket_screen.dart';
import 'package:Auction_App/screens/myProfile.dart';
import 'package:Auction_App/screens/myTeam_screen.dart';
import 'package:Auction_App/screens/myWallet_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminServicesData = Provider.of<AdminServices>(context);
    adminServicesData.getAdminStatus();
    return Drawer(
      child: Column(
        children: [
          AppBar(
              title: Text(
                'Hello Team',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              //never adds a back button
              backgroundColor: Theme.of(context).accentColor),
          SizedBox(height: 30),
          //players
          if (!adminServicesData.isAdmin)
            Column(
              children: [
                ListTile(
                    leading: Icon(Icons.person, color: Colors.purple),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Monteserrat',
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(MyProfile.routeName);
                    }),
                ListTile(
                    leading: Icon(Icons.people, color: Colors.purple),
                    title: Text('My Team',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Monteserrat',
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(MyTeam.routeName);
                    }),
                ListTile(
                    leading:
                        FaIcon(FontAwesomeIcons.wallet, color: Colors.purple),
                    title: Text('My Wallet',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Monteserrat',
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(MyWallet.routeName);
                    }),
                Divider(thickness: 2, indent: 20, endIndent: 20),
                ListTile(
                  leading:
                      FaIcon(FontAwesomeIcons.bitbucket, color: Colors.purple),
                  title: Text('Players Bucket',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Monteserrat',
                        // fontWeight: FontWeight.bold,
                      )),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(PlayersBucket.routeName),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.gavel, color: Colors.purple),
                  title: Text('Bidding Section',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Monteserrat',
                      )),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(PlayersBucket.routeName),
                ),
                Divider(thickness: 2, indent: 20, endIndent: 20),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text('Logout',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Monteserrat',
                      )),
                  onTap: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),

          //players

          if (adminServicesData.isAdmin)
            Column(
              children: [
                ListTile(
                  leading:
                      FaIcon(FontAwesomeIcons.userShield, color: Colors.purple),
                  title: Text('Admin', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).pushNamed(AdminScreen.routeName);
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.gavel, color: Colors.purple),
                  title:
                      Text('Bidding Section', style: TextStyle(fontSize: 20)),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(PlayersBucket.routeName),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.users, color: Colors.purple),
                  title: Text('All Teams', style: TextStyle(fontSize: 20)),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AllTeams.routeName),
                ),
                Divider(thickness: 2, indent: 20, endIndent: 20),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text('Logout', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),

          Spacer(),

          Divider(thickness: 2, indent: 20, endIndent: 20),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Developed By',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('Akash Kulkarni',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.linkedin,
                            color: Colors.black87),
                        onPressed: () => _launchURL(
                            'https://www.linkedin.com/in/akash213kulkarni'),
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.github,
                            color: Colors.black87),
                        onPressed: () =>
                            _launchURL('https://github.com/Akash-213'),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.mail, color: Colors.black87),
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.instagramSquare,
                            color: Colors.black87),
                        onPressed: () =>
                            _launchURL('https://www.instagram.com/akas_h213/'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
