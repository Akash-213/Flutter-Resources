import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/screens/lists_screen.dart';

import 'package:Auction_App/widgets/appDrawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class PlayersBucket extends StatelessWidget {
  static const routeName = '/playersBucket';

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
    final adminServicesData = Provider.of<AdminServices>(context);
    adminServicesData.getAdminStatus();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Players Bucket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Welcome to Auction App', style: TextStyle(fontSize: 24)),
            Container(
                height: 150,
                child: LottieBuilder.asset('assets/animations/auction.json')),
            Center(
              child: Text('Choose Your Bucket and Start Bidding',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Monteserrat',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  _buildInkWellCard("A List PLayers", Colors.purple, () {
                    Navigator.of(context)
                        .pushNamed(ListsScreen.routeName, arguments: {
                      'titleName': "A List Players",
                      'collectionPath':
                          '/auction/1Ga1i4GKRHk8nLT49zGz/List_A/tI6rQMP45gIqhjPIXEC9/players_A',
                    });
                  }),
                  _buildInkWellCard("B List PLayers", Colors.orange, () {
                    Navigator.of(context)
                        .pushNamed(ListsScreen.routeName, arguments: {
                      'titleName': "B List Players",
                      'collectionPath':
                          '/auction/1Ga1i4GKRHk8nLT49zGz/List_B/8aFpxi6QSXpDscyzbkYY/players_B',
                    });
                  }),
                  _buildInkWellCard("C List PLayers", Colors.red, () {
                    Navigator.of(context)
                        .pushNamed(ListsScreen.routeName, arguments: {
                      'titleName': "C List Players",
                      'collectionPath':
                          '/auction/1Ga1i4GKRHk8nLT49zGz/List_C/mc3n3z1oZD3CQiblNpyF/players_C',
                    });
                  }),
                  _buildInkWellCard("Foreign PLayers", Colors.pink, () {
                    Navigator.of(context)
                        .pushNamed(ListsScreen.routeName, arguments: {
                      'titleName': "D List Players",
                      'collectionPath':
                          '/auction/1Ga1i4GKRHk8nLT49zGz/List_D/NBynlZIfBChJOqr4Tnnp/players_D',
                    });
                  }),
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Center(
                  child: Text(
                'Developed By Akash',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

// Expanded(
//   child: FutureBuilder(
//     future: FirebaseFirestore.instance.collection('/players').get(),
//     builder: (ctx, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }
//       final snapshotData = snapshot.data.docs;

//       return ListView.builder(
//         itemCount: snapshotData.length,
//         itemBuilder: (ctx, index) {
//           return Card(
//             elevation: 10,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundImage:
//                     NetworkImage(snapshotData[index]['imageUrl']),
//               ),
//               title: Text(snapshotData[index]['name']),
//               trailing: IconButton(
//                 icon: Icon(
//                   Icons.remove_red_eye,
//                   color: Colors.purple,
//                 ),
//                 onPressed: () => Navigator.of(context)
//                     .pushNamed(PlayerDetails.routeName, arguments: {
//                   'playerId': snapshotData[index].id,
//                 }),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   ),
// ),
