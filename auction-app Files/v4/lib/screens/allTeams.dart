import 'package:Auction_App/widgets/appDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllTeams extends StatefulWidget {
  static const routeName = '/allTeams';

  @override
  _AllTeamsState createState() => _AllTeamsState();
}

class _AllTeamsState extends State<AllTeams> {
  Widget teamsList(String teamId) {
    return Container(
      height: 300,
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .collection('myTeam')
            .get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final teamDataDocs = snapshot.data.docs;
          if (teamDataDocs.length == 0) {
            return Center(child: Text('No players in the team yet'));
          }
          return ListView.builder(
            itemCount: teamDataDocs.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Text(teamDataDocs[index]['playerName']),
                  trailing: Text(
                    teamDataDocs[index]['bidAmt'].toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showTeams(String teamId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Text('Team '),
            content: teamsList(teamId),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Teams'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.6,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('/teams').snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              final teamsDocs = snapshot.data.docs;
              return ListView.builder(
                itemCount: teamsDocs.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(teamsDocs[index]['teamName']),
                        subtitle:
                            Text('Wallet : ${teamsDocs[index]['walletAmt']}'),
                        trailing: RaisedButton(
                          child: Text('View Team'),
                          onPressed: () {
                            _showTeams(teamsDocs[index].id);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
