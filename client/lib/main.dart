import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Accommodation/accommodation.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:se_app2/Home/Attraction/tourist_attraction.dart';
import 'package:se_app2/Home/Restaurant/restaurant.dart';
import 'package:se_app2/constants.dart';

import 'Home/Airport_Transfer/Airport_Transfer_driver_input.dart';
import 'navigator/nav/home/components/body.dart';
import 'screen/login_register/login.dart';
import 'screen/login_register/password_recovery.dart';
import 'screen/login_register/register.dart';
import 'navigator/nav/profile/profile.dart';
import 'navigator/nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


void main() async {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
        textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: textColor)
        ),
        // textTheme: GoogleFonts.notoSansThaiTextTheme(),
        scaffoldBackgroundColor: secondaryColor
      ),
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegisterScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/password': (BuildContext context) => PasswordScreen(),
        '/Navi': (BuildContext context) => Nav(),
        '/home': (BuildContext context) => HomeBody(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/home/accommodation' : (BuildContext context) => AccommodationPage(),
        '/home/airport_shuttle': (BuildContext context) => ShuttlePage(),
        '/home/restaurant': (BuildContext context) => Restaurantpage(),
        '/home/Attraction': (BuildContext context) => Attractionpage(),
        '/home/Attraction/detail': (BuildContext context) => Attractiondetail(),
      },
    );
  }
}
