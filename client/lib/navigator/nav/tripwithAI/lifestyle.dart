import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'dart:convert';

import 'package:se_app2/Home/Attraction/tourism_result.dart';

import '../blog/blogpost/add_post_detail.dart';

class lifestyle extends StatefulWidget {
  @override
  State<lifestyle> createState() => _lifestyleState();
}

class _lifestyleState extends State<lifestyle> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weather',
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
                      'Adventure',
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
                        print(rating);
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
                      'Environmet',
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
                        print(rating);
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
                      'Confidence',
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
                        print(rating);
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
                      'Backpack',
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
                          'สายวันเดียว',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'สายหลายวัน',
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
                        print(rating);
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
                      'Budget',
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
                        print(rating);
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
                      'Confidence',
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
                        print(rating);
                      },
                    ),
                  ],
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
