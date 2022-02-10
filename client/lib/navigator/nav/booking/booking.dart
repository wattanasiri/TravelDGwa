import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import '../booking/booking_body_none.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

import 'booking_item.dart';

class Booking extends StatefulWidget {

  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  var bookingStatus = 0; // 0, 1, 2
  var bookingSort = 0; // 0 to 5
  var itemFound = false;
  var connectionFailed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          title: Container(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(size.width * 0.25, 70),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    setState(() => {
                      bookingStatus = 0,
                      ResultItem(bookingStatus: bookingStatus)
                    });
                  },
                  child: Text('เร็วๆ นี้',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: bookingStatus == 0 ? orangeColor : Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(size.width * 0.4, 70),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    setState(() => {
                      bookingStatus = 1,
                      ResultItem(bookingStatus: bookingStatus)
                    });
                  },
                  child: Text('เรียบร้อยแล้ว',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: bookingStatus == 1 ? orangeColor : Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(size.width * 0.25, 70),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    setState(() => {
                      bookingStatus = 2,
                      ResultItem(bookingStatus: bookingStatus)
                    });
                  },
                  child: Text('ที่ยกเลิก',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: bookingStatus == 2 ? orangeColor : Colors.white,
                    ),
                  ),
                ),
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 0,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.copy,
                            color: bookingSort == 0 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('ทั้งหมด', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 1,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.business,
                            color: bookingSort == 1 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('ที่พัก', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 2,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.flight,
                            color: bookingSort == 2 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('เที่ยวบิน', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 3,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.directions_car,
                            color: bookingSort == 3 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('รถรับ-ส่ง', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 4,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.car_rental,
                            color: bookingSort == 4 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('เช่ารถ', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    setState(() => {
                      bookingSort = 5,
                      ResultItem(bookingStatus: bookingSort)
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.star,
                            color: bookingSort == 5 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('กิจกรรม', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            const Divider(
                height: 5,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Color(0xff827E7E),
            ),
            const SizedBox(height: 5,),

            // If no booking found
            // SizedBox(height: size.height *0.12,),
            // Container(
            //   alignment: Alignment.center,
            //   child: BookingBodyNone(),
            // ),

            // If booking found
            Container(
              alignment: Alignment.center,
              child: ResultItem(bookingStatus: bookingStatus, bookingSort: bookingSort,),
            ),

          ],
        ),
      ),
    );
  }
}