import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/screens/admin_screen.dart';
import 'package:Auction_App/screens/myTeam_screen.dart';
import 'package:Auction_App/screens/section_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminServicesData = Provider.of<AdminServices>(context);
    adminServicesData.getAdminStatus();
    return Drawer(
      child: Column(
        children: [
          AppBar(
              title: Text('Hello Team!!'),
              automaticallyImplyLeading: false,
              //never adds a back button
              backgroundColor: Theme.of(context).accentColor),
          SizedBox(height: 30),
          ListTile(
            leading: Icon(
              Icons.person_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('My Profile', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SectionScreen.routeName);
            },
          ),
          Divider(thickness: 2, indent: 20, endIndent: 20),
          ListTile(
            leading: Icon(Icons.people_alt_outlined,
                color: Theme.of(context).primaryColor),
            title: Text('My Team', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MyTeam.routeName);
            },
          ),
          Divider(thickness: 2, indent: 20, endIndent: 20),
          if (adminServicesData.isAdmin)
            ListTile(
              leading:
                  Icon(Icons.admin_panel_settings_outlined, color: Colors.blue),
              title: Text('Admin', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pushNamed(AdminScreen.routeName);
              },
            ),
          if (adminServicesData.isAdmin)
            Divider(thickness: 2, indent: 20, endIndent: 20),
          Spacer(),
          Divider(thickness: 2, indent: 20, endIndent: 20),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Logout', style: TextStyle(fontSize: 20)),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          Divider(thickness: 2, indent: 20, endIndent: 20),
        ],
      ),
    );
  }
}
