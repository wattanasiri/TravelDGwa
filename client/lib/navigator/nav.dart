import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:se_app2/navigator/nav/home/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Data/data_currentuser.dart';
import 'nav/tripwithAI/lifestyle.dart';
import 'nav/tripwithAI/mapmain.dart';
import '/navigator/nav/blog/blog.dart';
import '/navigator/nav/booking/booking.dart';
import '/navigator/nav/mainhome/mainhome.dart';
import '/navigator/nav/profile/profile.dart';
import '/navigator/nav/tripwithAI/tripwithAI.dart';

class Nav extends StatefulWidget {

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  bool checklifestyleis;
  Map dataafterquery,dataquerymap;
  String weather,adventure,sea,confidence,bagpack,budget,social = '0';
  int _selectedIndex = 0;
  bool isLeft = true;
  Datauser datauser = Datauser();

  Future getdataid() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('getuserid');
    http.Response res =
    await http.get(Uri.parse('http://10.0.2.2:8080/map/getuserid'), headers: {
      'Content-Type': 'application/json;charSet=UTF-8',
      'Accept': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
    },);
    print(json.decode(res.body));
    datauser.id = json.decode(res.body);
  }
  Future checklifestyle() async {


    try{
      print('check');
      Datauser datauser = Datauser();
      print(datauser.id);
      http.Response res =
      await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/infolifestyleuser'));
      dataafterquery = json.decode(res.body);
      print(dataafterquery['foundinfo'].length);
      print(dataafterquery['foundinfo']);
      if(dataafterquery['foundinfo'].length != 0){
        weather = dataafterquery['foundinfo'][0]['Weather'].toString();
        adventure = dataafterquery['foundinfo'][0]['Adventure'].toString();
        sea = dataafterquery['foundinfo'][0]['Sea'].toString();
        confidence = dataafterquery['foundinfo'][0]['Confidence'].toString();
        bagpack = dataafterquery['foundinfo'][0]['BagPack'].toString();
        budget = dataafterquery['foundinfo'][0]['Budget'].toString();
        social = dataafterquery['foundinfo'][0]['social'].toString();
        checklifestyleis = true;
        print('true');

        // model();
      }else{
        checklifestyleis = false;
        print('false');
        // savedata();
      }
    }catch(e){
      print(e);
      checklifestyleis = false;
    }
  }
  Future querydata() async{
    print('querydata');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydatamap'));
    dataquerymap = json.decode(res.body);
    print(dataquerymap);
  }
  final List<Widget> _pageList = <Widget>[
    const HomeBody(),
    const Booking(),
    const TripWithAI(),
    const Blog(),
    const ProfilePage()
  ];

  void _onItemTap(int index) {
    setState(()  async {
      if (_selectedIndex >= index){
        isLeft = true;
      } else {
        isLeft = false;
      }
      print(index);
      if(index == 2){
        await getdataid();
        await checklifestyle();
        print(checklifestyleis);
        await querydata();
        if(checklifestyleis){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Mapmain(
                    dataquerymap: dataquerymap,
                    weather : weather,
                    adventure :  adventure,
                    sea : sea,
                    confidence: confidence,
                    bagpack: bagpack,
                    budget: budget,
                    social : social,
                  )
              )
          );
        }else{
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => lifestyle(
                    dataquerymap: dataquerymap,
                  )
              )
          );
        }
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: PageTransitionSwitcher(transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
        SharedAxisTransition(
          fillColor: const Color(0xffFFF4DC),
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child
        ),
        reverse: isLeft,
        duration: const Duration(milliseconds: 300),
        child: _pageList[_selectedIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
        onTap: _onItemTap,
        height: 80,
        curveSize: 80,
        style: TabStyle.fixed,
        initialActiveIndex: 0,
        activeColor: const Color(0xffFF9A62),
        backgroundColor: const Color(0xff1D3557),
        items: const [
          TabItem(
            title: 'หน้าหลัก',
            icon: Icon(Icons.home_rounded, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Icons.home_rounded, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'การจอง',
            icon: Icon(Ionicons.ticket, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Ionicons.ticket, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'จัดทริป',
            icon: Icon(Boxicons.bx_trip, color: Color(0xffFFF4DC), size: 32),
            activeIcon: Icon(Boxicons.bx_trip, color: Color(0xffFF9A62), size: 32),
          ),
          TabItem(
            title: 'บล็อค',
            icon: Icon(Ionicons.newspaper, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Ionicons.newspaper, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'โปรไฟล์',
            icon: Icon(Icons.account_circle, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Icons.account_circle, color: Color(0xffFF9A62)),
          ),
        ],
      ),
    );
  }
}