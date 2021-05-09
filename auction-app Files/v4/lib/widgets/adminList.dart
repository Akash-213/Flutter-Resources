import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/provider/playersServices.dart';

class AdminList extends StatefulWidget {
  final String sectionName;
  final String sectionPath;

  AdminList(this.sectionName, this.sectionPath);
  @override
  _AdminListState createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  bool expanded = false;

  Widget snackBar(String title) {
    return SnackBar(
      content: Text(title),
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerServices = Provider.of<PlayersServices>(context, listen: false);
    final adminServices = Provider.of<AdminServices>(context, listen: false);
    return Container(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(widget.sectionName + ' List Players'),
                subtitle: Text("Operations"),
                trailing: IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                ),
              ),
            ),
            if (expanded)
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Divider(thickness: 1, indent: 10, endIndent: 10),
                      InkWell(
                        onTap: () async {
                          await playerServices.sortAndSetData(
                              widget.sectionName, widget.sectionPath);

                          Scaffold.of(context)
                              .showSnackBar(snackBar('Sucessfully Added Data'));
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              children: [
                                Text('Add the Data'),
                                Spacer(),
                                Icon(
                                  Icons.add_chart,
                                  color: Colors.purple,
                                ),
                              ],
                            )),
                      ),
                      Divider(thickness: 1, indent: 10, endIndent: 10),
                      InkWell(
                        onTap: () async {
                          await adminServices
                              .stopAllBidding(widget.sectionPath);

                          Scaffold.of(context).showSnackBar(
                              snackBar('Section Bidding Stopped'));
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              children: [
                                Text('Stop Bidding'),
                                Spacer(),
                                Icon(Icons.pause_circle_filled,
                                    color: Colors.red),
                              ],
                            )),
                      ),
                      Divider(thickness: 1, indent: 10, endIndent: 10),
                      InkWell(
                        onTap: () async {
                          await adminServices
                              .startAllBidding(widget.sectionPath);
                          Scaffold.of(context).showSnackBar(
                              snackBar('Section Bidding Started'));
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              children: [
                                Text('Start Bidding'),
                                Spacer(),
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.green,
                                ),
                              ],
                            )),
                      ),
                      Divider(thickness: 1, indent: 10, endIndent: 10),
                      InkWell(
                        onTap: () async {
                          print("Working");
                          await adminServices
                              .allocateToTeams(widget.sectionPath);
                          Scaffold.of(context).showSnackBar(
                              snackBar('Allocation of players to Teams Done'));
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              children: [
                                Text('Allot to Teams'),
                                Spacer(),
                                Icon(
                                  Icons.people_outline_outlined,
                                  color: Colors.blue,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
