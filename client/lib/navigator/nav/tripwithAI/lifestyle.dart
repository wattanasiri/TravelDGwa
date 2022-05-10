import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../../../Data/data_currentuser.dart';
import 'mapmain.dart';

class lifestyle extends StatefulWidget {
  Map dataquerymap;
  bool statussuccess,statusunsuccess;
  lifestyle({this.dataquerymap,this.statusunsuccess,this.statussuccess});

  @override
  State<lifestyle> createState() => _lifestyleState();
}

class _lifestyleState extends State<lifestyle> {
  String weather, adventure, sea, confidence, bagpack, budget, social = '0';
  Map dataafterquery;
  Datauser datauser = Datauser();

  // Future readdata() async{
  //   http.Response res2 =
  //       await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/infolifestyleuser'));
  //   dataafterquery = json.decode(res2.body);
  //   print('dataafterquery');
  //   print(dataafterquery);
  //
  // }
  Future savedata() async {
    print('save data');
    print('id');
    print(datauser.id);
    var res = await http.post(
        Uri.parse('http://10.0.2.2:8080/map/register_mapinfo'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "usernameID": datauser.id,
          "weather": weather,
          "adventure": adventure,
          "sea": sea,
          "confidence": confidence,
          "bagpack": bagpack,
          "budget": budget,
          "social": social,
        });
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.pushNamed(
              context,
              '/Navi',
            ),
          ),
          title: const Text(
            'ไลฟ์ไสตล์การเที่ยว',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //weather
            Column(
              children: [
                Text(
                  'เก็บข้อมูล lifestyle ของคุณเพื่อทำการคำนวนว่าคุณชอบสถานที่แบบใดในการท่องเที่ยว Ex คุณชอบอากาศที่อบอุ่นไม่ร้อนหนาวเกินไปคุณสามารถเลือกสภาพอากาศเป็นระดับ 3 ได้',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: Colors.black38),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'สภาพอากาศ',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Boxicons.bxs_cloud,
                        color: const Color(0xff2E81FF), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Boxicons.bxs_sun,
                            color: const Color(0xffFF5823), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ร้อน',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'หนาว',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Ionicons.snow,
                            color: const Color(0xff178AF4), size: 30),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return
                              Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                      },
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),*/
                    //Rate bar
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff1BC3FF),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff1960C5),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        weather = rating.toInt().toString();
                        print(rating);
                      },
                    ),
                  ],
                ),
              ],
            ),
            //weather
            SizedBox(
              height: 30,
            ),
            //adventure
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'กิจกรรม',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Ionicons.bicycle,
                        color: const Color(0xff1D3557), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Ionicons.camera,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'สายชิลล์',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'สายกิจกรรม',
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Ionicons.football,
                            color: const Color(0xff1D3557), size: 30),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        adventure = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            //adventure
            SizedBox(
              height: 30,
            ),
            //Environment
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ธรรมชาติ',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Ionicons.leaf_sharp,
                        color: const Color(0xff03711F), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Boxicons.bxs_building_house,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'สิ่งก่อสร้าง',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ธรรมชาติ',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Boxicons.bxs_tree,
                              color: const Color(0xff03711F), size: 30),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        sea = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            //Environment
            SizedBox(
              height: 30,
            ),
            //Confidence
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ความสะดวกสบาย',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Boxicons.bxs_happy_alt,
                        color: const Color(0xff1D3557), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Boxicons.bxs_cool,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Introvert',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Extrovert',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Boxicons.bxs_laugh,
                              color: const Color(0xff1D3557), size: 30),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        confidence = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            //Confidence
            SizedBox(
              height: 30,
            ),
            //Backpack
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'เที่ยวคนเดียว',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Boxicons.bxs_backpack,
                        color: const Color(0xff1D3557), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Boxicons.bxs_calendar_plus,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'เที่ยวเป็นกลุ่ม',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'เที่ยวคนเดียว',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Boxicons.bxs_calendar,
                              color: const Color(0xff1D3557), size: 30),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        bagpack = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            //Backpack
            SizedBox(
              height: 30,
            ),
            //Budget
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'งบประมาณ',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Boxicons.bxs_wallet,
                        color: const Color(0xff1D3557), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.monetization_on_rounded,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'งบน้อย',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'งบเยอะ',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Ionicons.cash_outline,
                              color: const Color(0xff1D3557), size: 30),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        budget = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            //Budget
            SizedBox(
              height: 30,
            ),
            //Social media addiction
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'โซเชียล ',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Ionicons.people_circle,
                        color: const Color(0xff1D3557), size: 30),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Ionicons.person,
                            color: const Color(0xff1D3557), size: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ไม่ติดโซเชียล',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ติดโซเชียล',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Ionicons.people,
                              color: const Color(0xff1D3557), size: 30),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Rate bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.circle,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFF6D1D),
                            );
                          case 2:
                            return Icon(
                              Icons.circle,
                              color: Color(0xffFBBC05),
                            );
                          case 3:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff29C250),
                            );
                          case 4:
                            return Icon(
                              Icons.circle,
                              color: Color(0xff03711F),
                            );
                        }
                      },
                      //function
                      onRatingUpdate: (rating) {
                        social = rating.toInt().toString();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 25,
                  endIndent: 25,
                  color: Color(0xFF757575),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RaisedButton(
                          onPressed: () {
                            savedata();
                            // readdata();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mapmain(
                                          statussuccess: widget.statussuccess,
                                          statusunsuccess: widget.statusunsuccess,
                                          dataquerymap: widget.dataquerymap,
                                          weather: weather.toString(),
                                          adventure: adventure.toString(),
                                          sea: sea.toString(),
                                          confidence: confidence.toString(),
                                          bagpack: bagpack.toString(),
                                          budget: budget.toString(),
                                          social: social.toString(),
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'บันทึก',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffFFF4DC)),
                            ),
                          ),
                          color: Color(0xff1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //Social media addiction
          ],
        ),
      ),
    );
  }
}
