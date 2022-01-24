import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home/Accommodation/accommodation.dart';
import 'navigator/nav/profile/profile.dart';
import 'navigator/nav.dart';
import 'Home/shuttle/shuttle.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'traveldgwa',
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexSansThaiTextTheme()
        // textTheme: GoogleFonts.notoSansThaiTextTheme()
      ),
      home: const AccommodationSearch(),
      routes: <String, WidgetBuilder>{
        '/Navi': (BuildContext context) => Nav(),
        '/airport_shuttle': (BuildContext context) => shuttle(),
        // '/hotel ': (BuildContext context) => hotel(),
        '/profile': (BuildContext context) => profile(),
      },
    );
  }
}
