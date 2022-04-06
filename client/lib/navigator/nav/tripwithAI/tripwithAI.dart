import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/data_currentuser.dart';
import 'lifestyle.dart';
import 'mapmain.dart';

class TripWithAI extends StatefulWidget {
  const TripWithAI({Key key}) : super(key: key);

  @override
  _TripWithAIState createState() => _TripWithAIState();
}

class _TripWithAIState extends State<TripWithAI> {
  bool checklifestyleis;
  Map dataafterquery, dataquerymap;
  String weather, adventure, sea, confidence, bagpack, budget, social = '0';
  Datauser datauser = Datauser();
  Future querydata() async {
    print('querydata');
    http.Response res = await http.get(
        Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydatamap'));
    dataquerymap = json.decode(res.body);
    print(dataquerymap);
  }

  Future getdataid() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('getuserid');
    http.Response res = await http.get(
      Uri.parse('http://10.0.2.2:8080/map/getuserid'),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(json.decode(res.body));
    datauser.id = json.decode(res.body);
  }

  Future checklifestyle() async {
    try {
      print('check');
      Datauser datauser = Datauser();
      print(datauser.id);
      http.Response res = await http.get(Uri.parse(
          "http://10.0.2.2:8080/map/" + datauser.id + '/infolifestyleuser'));
      dataafterquery = json.decode(res.body);
      print(dataafterquery['foundinfo'].length);
      print(dataafterquery['foundinfo']);
      if (dataafterquery['foundinfo'].length != 0) {
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
      } else {
        checklifestyleis = false;
        print('false');
        // savedata();
      }
    } catch (e) {
      print(e);
      checklifestyleis = false;
    }
  }

  Future check(int index) async {
    bool echeck = false;
    if (index == 2) {
      echeck = true;
      await getdataid();
      await checklifestyle();
      print(checklifestyleis);
      await querydata();
      if (checklifestyleis) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Mapmain(
                      dataquerymap: dataquerymap,
                      weather: weather,
                      adventure: adventure,
                      sea: sea,
                      confidence: confidence,
                      bagpack: bagpack,
                      budget: budget,
                      social: social,
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => lifestyle(
                      dataquerymap: dataquerymap,
                    )));
      }
    }
    return echeck;
  }

  void initState() {
    check(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D3557),
      body: Center(
        child: Text(
          'Loading ...',
          style: TextStyle(
              color: Color(0xffECFAFF),
              fontSize: 24,
              fontWeight: FontWeight.bold),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => triplog()));
              },
              child: Text(
                'บันทึกทริป',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFF9A62),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //กำลังดำเนินการ
            //ไม่มีทริปที่กำลัง
            //เอาให้ส่วนนี้หายไปเลย
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'กำลังดำเนินการ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => tripdetail()));
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff1D3557),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffECFAFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff1D3557),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(
                              child: Text(
                                'ไปไหนก็ได้ทริป',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffECFAFF),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(
                                  child: Text(
                                    'เขาเขียว',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffECFAFF),
                                    ),
                                  ),
                                ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62), size: 30),
                                //ปลายทาง
                                Flexible(
                                  child: Text(
                                    'บางแสน',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffECFAFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //ทริปล่าสุด
            //ไม่มรทริปล่าสุด
            /*Text(
                  'ไม่มีทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => tripdetail()));
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(
                              child: Text(
                                'ไปไหนก็ได้ทริป',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(
                                  child: Text(
                                    'เขาเขียว',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62), size: 30),
                                //ปลายทาง
                                Flexible(
                                  child: Text(
                                    'บางแสน',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => triplog()));
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(
                              child: Text(
                                'ไปไหนก็ได้ทริป',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(
                                  child: Text(
                                    'เขาเขียว',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62), size: 30),
                                //ปลายทาง
                                Flexible(
                                  child: Text(
                                    'บางแสน',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openEditNameDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              'ชื่อทริป',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextFormField(
              autofocus: true,
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    setState(() {
                      //word = nameEdit.text;
                    });
                    //ดึงข้อมูล
                    //get....();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => tripdetail()));
                  },
                  child: const Text('ตกลง'))
            ],
          ));
}
