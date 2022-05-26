import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:se_app2/navigator/nav/booking/booking.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/maincreditcard.dart';
import 'package:se_app2/navigator/nav/profile/partnership/mainpartnership.dart';
import 'package:se_app2/navigator/nav/profile/profile_edit.dart';
import 'package:se_app2/navigator/nav/profile/logout_confirm.dart';
import 'package:se_app2/navigator/nav/profile/favourite/mainfavourite.dart';
import 'package:se_app2/screen/login_register/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/constants.dart';

import 'helpcenter/mainhelpcenter.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map data;
  List info;


  Future getUserInfo() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    http.Response res =
    await http.get(Uri.parse("$SERVER_URL/user/userinfo"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    data = json.decode(res.body);
    info = data['founduser'];
    setState(() {
      info = info;
    });
    print(info);
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : const Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 50.0, right: 20, left: 20, bottom: 30),
            decoration: const BoxDecoration(
                color : Color(0xFF1d3557),
                borderRadius : BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFECFAFF),
                  radius: 48,
                  child: Text(
                    "SC",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF1d3557)
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/icons/notibell.png',width: 25, height: 25,),
                          const SizedBox(width: 5,),
                          Image.asset('assets/icons/chat.png',width: 25, height: 25,),
                          const SizedBox(width: 5,),
                          Image.asset('assets/icons/setting.png',width: 25, height: 25,),
                          //Icon(Icons.house, color: Color(0xFFECFAFF), size: 25,),
                        ],
                      ),
                      //ชื่อ
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => editpro()
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "Sedtawut Chalothornnarumit",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Color(0xFFECFAFF)),
                            ),
                            Text("ดูโปรไฟล์ของฉัน", style: TextStyle(fontSize: 10, color: Color(0xFFFF9A62)),textAlign: TextAlign.left,),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(1, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  animationDuration: const Duration(milliseconds: 1000),
                  padding: const EdgeInsets.all(20),
                  primary: const Color(0xffECFAFF),
                  onPrimary: const Color(0xff1D3557),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => partnership())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: const [
                          Icon(Icons.group_rounded, color: Color(0xff1D3557), size: 40,),
                          SizedBox(width: 20),
                          Text("สมัครเป็นพาร์ทเนอร์", style: TextStyle(fontSize: 16, color: Color(0xff1D3557)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557), size: 30,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => maincreditcard())
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(1, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/creditcard.png', width: 40, height: 40,),
                          const SizedBox(width: 20,),
                          const Text("บัตรเครดิตที่บันทึกไว้", style: TextStyle(fontSize: 16, color: Color(0xFF1D3557)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557), size: 30,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => mainfavourite())
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(1, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/favourite.png',width: 40, height: 40,),
                          const SizedBox(width: 20,),
                          const Text("รายการโปรด", style: TextStyle(fontSize: 16, color: Color(0xFF1D3557)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557), size: 30,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => mainhelp())
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(1, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/help.png',width: 40, height: 40,),
                          const SizedBox(width: 20,),
                          const Text('ศูนย์ช่วยเหลือ', style: TextStyle(fontSize: 16, color: Color(0xFF1D3557)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557), size: 30,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Log out!');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return confirmLogoutBox();
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(1, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/logout.png',width: 40, height: 40,),
                          const SizedBox(width: 20,),
                          const Text('ออกจากระบบ', style: TextStyle(fontSize: 16, color: Color(0xffF25B52)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xffF25B52), size: 30,)
                  ],
                ),
              ),
            ),
        ],),
      ),
    );
  }
}