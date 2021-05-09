import 'package:Auction_App/provider/adminServices.dart';
import 'package:Auction_App/provider/bidServices.dart';
import 'package:Auction_App/provider/playersServices.dart';
import 'package:Auction_App/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Auction_App/screens/auctions_screen.dart';
import 'package:Auction_App/screens/lists_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Auction_App/screens/auth_screen.dart';
import 'package:Auction_App/screens/section_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BidServices(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AdminServices(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PlayersServices(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Auction',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          backgroundColor: Colors.purple,
          accentColor: Colors.amber,
          accentColorBrightness: Brightness.light,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.amber,
            textTheme: ButtonTextTheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return SectionScreen();
              }
              return AuthScreen();
            }),
        routes: {
          ListsScreen.routeName: (ctx) => ListsScreen(),
          AuctionScreen.routeName: (ctx) => AuctionScreen(),
          AdminScreen.routeName: (ctx) => AdminScreen(),
        },
      ),
    );
  }
}
