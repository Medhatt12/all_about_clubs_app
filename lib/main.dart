import 'package:all_about_clubs_app/screens/club_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/clubs_data.dart';
import '../screens/clubs_overview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MaterialColor hauptFarbe = MaterialColor(
      0xFF01C13B,
      <int, Color>{
        50: Color(0xFF01C13B),
        100: Color(0xFF01C13B),
        200: Color(0xFF01C13B),
        300: Color(0xFF01C13B),
        400: Color(0xFF01C13B),
        500: Color(0xFF01C13B),
        600: Color(0xFF01C13B),
        700: Color(0xFF01C13B),
        800: Color(0xFF01C13B),
        900: Color(0xFF01C13B),
      },
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ClubsData(),
        )
      ],
      child: MaterialApp(
        title: 'All About Clubs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: hauptFarbe,
        ),
        home: ClubsOverview(),
        routes: {
          ClubDetailsScreen.routeName: (ctx) => ClubDetailsScreen(),
        },
      ),
    );
  }
}
