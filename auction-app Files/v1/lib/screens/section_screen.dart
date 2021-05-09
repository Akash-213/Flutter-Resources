import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Auction_App/screens/lists_screen.dart';

class SectionScreen extends StatelessWidget {
  static const routeName = '/sections';

  _buildInkWellCard(String title, Color color, Function selectHandler) {
    return InkWell(
      onTap: () => selectHandler(),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text(title),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.6),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players Section"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: GridView.count(
          crossAxisSpacing: 20,
          mainAxisSpacing: 40,
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          crossAxisCount: 2,
          children: [
            _buildInkWellCard("A List PLayers", Colors.purple, () {
              Navigator.of(context)
                  .pushNamed(ListsScreen.routeName, arguments: {
                'titleName': "A List Players",
                'collectionPath':
                    'auction/6ryNb4f7PPUsrOrNBWqR/List_A/tI6rQMP45gIqhjPIXEC9/players_A',
              });
            }),
            _buildInkWellCard("B List PLayers", Colors.orange, () {
              Navigator.of(context)
                  .pushNamed(ListsScreen.routeName, arguments: {
                'titleName': "B List Players",
                'collectionPath':
                    'auction/6ryNb4f7PPUsrOrNBWqR/List_B/8aFpxi6QSXpDscyzbkYY/players_B',
              });
            }),
            _buildInkWellCard("C List PLayers", Colors.red, () {
              Navigator.of(context)
                  .pushNamed(ListsScreen.routeName, arguments: {
                'titleName': "C List Players",
                'collectionPath':
                    'auction/6ryNb4f7PPUsrOrNBWqR/List_C/eGTKmhz8y1xF8uo3tek0/players_C',
              });
            }),
            _buildInkWellCard("Foreign PLayers", Colors.pink, () {
              Navigator.of(context)
                  .pushNamed(ListsScreen.routeName, arguments: {
                'titleName': "D List Players",
                'collectionPath':
                    'auction/6ryNb4f7PPUsrOrNBWqR/List_D/7cD8GOk0O5QPkNzIhmPR/players_D',
              });
            }),
          ],
        ),
      ),
    );
  }
}
