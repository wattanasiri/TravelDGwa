import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:se_app2/constants.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/functions.dart';

import 'package:se_app2/Widgets/notif_ok.dart';
import 'booking_detail_hotel.dart';
import 'booking_detail_ticket.dart';
import 'booking_detail_transfer.dart';
import 'booking_detail_rentcar.dart';
import 'booking_detail_activity.dart';
import 'components/booking_type_icon.dart';

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
  var currentData;
  var filteredData;

  String filteringStatus = 'soon'; // soon, completed, canceled
  String filteringType = 'any';

  Map data; // changes based on filter

  String formatCheckIn(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
        getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
        convertYearToBE(parsedDate.year).toString();
    return text;
  }
  String formatCheckOut(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
        getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
        convertYearToBE(parsedDate.year).toString();
    return text;
  }

  String getBookingTitle(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return dataIndex['acc_name'];
    } else if (dataIndex['bookingType'] == 'transfer') {
      return 'นายสมปอง ดองงาน';
    } else if (dataIndex['bookingType'] == 'rentcar') {
      return dataIndex['car_name'];
    } else if (dataIndex['bookingType'] == 'activity') {
      return dataIndex['name'];
    }
    else {
      return 'text error';
    }
  }

  String getBookingSubtitle(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return 'ห้อง ' + dataIndex['room'];
    } else if (dataIndex['bookingType'] == 'transfer') {
      return 'Honda City : ฟฟ 6207';
    } else if (dataIndex['bookingType'] == 'rentcar') {
      return dataIndex['partnername'];
    } else if (dataIndex['bookingType'] == 'activity') {
      return '';
    }
    else {
      return 'text error';
    }
  }

  String getDateText1(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return formatCheckIn(dataIndex['checkIn']);
    } else if (dataIndex['bookingType'] == 'transfer') {
      var inputFormat = DateFormat('dd-MM-yyyy');
      DateTime parsedDate = inputFormat.parse(dataIndex['startdate']);
      var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
          getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
          convertYearToBE(parsedDate.year).toString() + ' เวลา ' +
          dataIndex['starttime'] + ' น.';
      return text;
    } else if (dataIndex['bookingType'] == 'rentcar') {
      var inputFormat = DateFormat('yyyy-MM-dd');
      DateTime parsedDate = inputFormat.parse(dataIndex['date_getcar']);
      var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
          getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
          convertYearToBE(parsedDate.year).toString() + ' เวลา ' +
          dataIndex['time_getcar'] + ' น.';
      return text;
    } else if (dataIndex['bookingType'] == 'activity') {
      var inputFormat = DateFormat('dd-MM-yyyy');
      DateTime parsedDate = inputFormat.parse(dataIndex['day']);
      var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
          getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
          convertYearToBE(parsedDate.year).toString() + ' เวลา ' +
          dataIndex['time'] + ' น.';
      return text;
    }
    else {
      return '';
    }
  }

  String getDateText2(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return formatCheckOut(dataIndex['checkOut']);
    } else if (dataIndex['bookingType'] == 'rentcar') {
      var inputFormat = DateFormat('yyyy-MM-dd');
      DateTime parsedDate = inputFormat.parse(dataIndex['date_sentcar']);
      var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
          getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
          convertYearToBE(parsedDate.year).toString() + ' เวลา ' +
          dataIndex['time_sentcar'] + ' น.';
      return text;
    }
    else {
      return '';
    }
  }

  Future getBookingData() async {

    // ---------------
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(Uri.parse("$SERVER_URL/booking"),
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
        connectionFailed = true;
        return http.Response('Error', 408);
      },)
    ;
    data = json.decode(res.body);

    // static
    bookingData = data['booking'];
    // changes
    currentData = [...bookingData].where(
            (row) => (row['status'] == 'soon')
    ).toList();
    print(currentData);

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
  // ---------------

  void filterStatusData(statusIndex) {
    switch (statusIndex) {
      case 1: filteringStatus = 'completed'; break;
      case 2: filteringStatus = 'canceled'; break;
      default:
        filteringStatus = 'soon';
    }
    if (filteringType == 'any') {
      filteredData = [...bookingData].where(
              (row) => (row['status'] == filteringStatus)
      ).toList();
    } else {
      filteredData = [...bookingData].where(
              (row) => (row['bookingType'] == filteringType && row['status'] == filteringStatus)
      ).toList();
    }
    print(filteredData);
    setState(() => {
      bookingStatus = statusIndex,
      currentData = filteredData,
    });
  }

  void filterTypeData(typeIndex) {
    switch (typeIndex) {
      case 1: filteringType = 'accommodation'; break;
      case 2: filteringType = 'flight'; break;
      case 3: filteringType = 'transfer'; break;
      case 4: filteringType = 'rentcar'; break;
      case 5: filteringType = 'activity'; break;
      default:
        filteringType = 'any';
    }
    if (filteringType == 'any') {
      filteredData = [...bookingData].where(
              (row) => (row['status'] == filteringStatus)
      ).toList();
    } else {
      filteredData = [...bookingData].where(
              (row) => (row['bookingType'] == filteringType && row['status'] == filteringStatus)
      ).toList();
    }
    print(filteredData);
    setState(() => {
      bookingType = typeIndex,
      currentData = filteredData,
    });

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
                    filterStatusData(0);
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
                    filterStatusData(1);
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
                    filterStatusData(2);
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
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: currentData == null ? 0 : currentData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => {
                          if (currentData[index]['bookingType'] == 'accommodation') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => hotelDetail(
                                        detail: currentData[index])))
                          } else if (currentData[index]['bookingType'] == 'transfer') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => transferDetail(
                                  detail: currentData[index])))
                          } else if (currentData[index]['bookingType'] == 'rentcar') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => rentCarDetail(
                                        detail: currentData[index])))
                          } else if (currentData[index]['bookingType'] == 'activity') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => activityDetail(
                                        detail: currentData[index])))
                          }
                          else {
                            print('INVALID TYPE'),
                          },

                        },
                        child: GFCard(
                          elevation: 8,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.zero,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(alignment: Alignment.bottomRight, children: <Widget>[
                                Row(
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    ShaderMask(shaderCallback: (rect) {
                                      return LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [Colors.transparent, primaryColor],
                                      ).createShader(Rect.fromLTRB(80, 0, rect.width*1, rect.height));
                                    },
                                      blendMode: BlendMode.srcATop,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                        child: Image.network(getImageUrl(currentData[index]['bookingType']),
                                            height: 110,
                                            width: 160,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Flexible(child: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                        left: 5,
                                        right: 20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getBookingTitle(currentData[index]),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getBookingSubtitle(currentData[index]),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 3,),
                                          Row(
                                            children: [
                                              if (currentData[index]['bookingType'] == 'accommodation')
                                                Icon(Icons.calendar_today_outlined,
                                                    color: boxColor,
                                                    size: 14),
                                              if (currentData[index]['bookingType'] == 'rentcar')
                                                Icon(Icons.directions_car,
                                                    color: boxColor,
                                                    size: 14),
                                              SizedBox(width: 3,),
                                              Text(
                                                getDateText1(currentData[index]),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: boxColor,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Row(

                                            children: [
                                              if (currentData[index]['bookingType'] == 'accommodation')
                                                Icon(Icons.alarm_off,
                                                    color: boxColor,
                                                    size: 14),
                                              if (currentData[index]['bookingType'] == 'rentcar')
                                                Icon(Icons.cancel_rounded,
                                                    color: boxColor,
                                                    size: 14),
                                              SizedBox(width: 3,),
                                              Text(
                                                getDateText2(currentData[index]),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: boxColor,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 78,
                                    right: 7,
                                  ),
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: boxColor,
                                    borderRadius: BorderRadius.all(Radius.circular(25),),
                                  ),
                                  child: BookingTypeIcon(type: currentData[index]['bookingType']),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.only(
                                    bottom: 5,
                                    right: 5,
                                  ),
                                  child: Text(
                                    'กดเพื่อดูรายละเอียดเพิ่มเติม >>',
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: boxColor,
                                        fontSize: 9),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                  ))
            else
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(child: CircularProgressIndicator()),
            ),

          ],
        ),
      ),
    );
  }

  String getImageUrl(type) {
    if (type == 'accommodation')
      return 'https://placeimg.com/640/480/any';
    else if (type == 'transfer')
      return 'https://t1.blockdit.com/photos/2020/11/5fb952383d4b9b0cc0fd7d2e_800x0xcover_3aaaqsST.jpg';
    else if (type == 'rentcar')
      return 'https://www.toyota.co.th/media/product/feature/large/e8d2cc60fa1d5467bc3a8b2b944677faa9c42502.jpg';
    else if (type == 'activity')
      return 'https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/2000785513283/Health%2520Land%2520Pradit%2520Manutham%2520Spa%2520Treatments-f3388649-4fee-4630-8c1c-cec1fd1f36f7.jpeg?_src=imagekit&tr=c-at_max';
    else
      return 'https://placeimg.com/640/480/any';
  }

}