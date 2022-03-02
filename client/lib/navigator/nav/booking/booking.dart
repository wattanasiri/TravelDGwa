import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'booking_item.dart';
import 'package:se_app2/Widgets/notif_ok.dart';

class Booking extends StatefulWidget {

  const Booking({Key key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  var bookingStatus = 0; // 0, 1, 2
  var bookingType = 0; // 0 to 5
  var itemFound = false;
  var connectionFailed = false;
  var done = false;

  var bookingData;
  var filteredData;
  Map data;

  Future getBookingData() async {

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(Uri.parse("http://10.0.2.2:8080/booking"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
      onTimeout: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return notifBox(
              title: 'Error',
              text: 'Request timeout.',
              fontSize: 14.0,
            );
          },
        );
        return http.Response('Error', 408);
      },)
    ;
    data = json.decode(res.body);
    bookingData = data['booking'];
    print(bookingData);


    if (res.statusCode == 200) {
      var itemCount = data.length;
      if (itemCount > 0) {
        setState((){
          done = true;
          itemFound = true;
          connectionFailed = false;
        });
      } else {
        setState((){
          done = true;
          itemFound = false;
          connectionFailed = false;
        });
      }
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
      setState((){
        done = true;
        connectionFailed = true;
      });
    }
  }

  void filterStatusData(statusIndex) {
    // TODO
    setState(() => {
      bookingStatus = statusIndex,
      ResultItem(bookingData: bookingData),
    });
  }

  void filterTypeData(typeIndex) {
    filteredData = [...bookingData].where((row) => (row['bookingType'] == 'transferrecipt'));
    setState(() => {
      ResultItem(bookingData: filteredData),
      bookingType = typeIndex,
    });
    // print(filteredData);
  }

  @override
  void initState() {
    super.initState();
    getBookingData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondaryColor,
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
                    filterTypeData(0);
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
                            color: bookingType == 0 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('ทั้งหมด', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    filterTypeData(1);
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
                            color: bookingType == 1 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('ที่พัก', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    filterTypeData(2);
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
                            color: bookingType == 2 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('เที่ยวบิน', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    filterTypeData(3);
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
                            color: bookingType == 3 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('รถรับ-ส่ง', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    filterTypeData(4);
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
                            color: bookingType == 4 ? orangeColor : Colors.white,
                            size: 20),
                      ),
                      const Text('เช่ารถ', style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    filterTypeData(5);
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
                            color: bookingType == 5 ? orangeColor : Colors.white,
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
                color: grayColor,
            ),
            const SizedBox(height: 5,),

            if (done)
                Container(
                alignment: Alignment.center,
                child: ResultItem(bookingData: bookingData),
              )
            else
              Center(child: CircularProgressIndicator())
            ,

          ],
        ),
      ),
    );
  }
}