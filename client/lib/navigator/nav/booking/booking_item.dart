import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:se_app2/constants.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/functions.dart';

import 'booking_detail_hotel.dart';
import 'booking_detail_ticket.dart';
import 'booking_detail_transfer.dart';
import 'components/booking_type_icon.dart';

class ResultItem extends StatefulWidget {
  final bookingData;
  const ResultItem(
      {Key key,
        this.bookingData,
      })
      : super(key: key);
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {

  var itemFound = false;
  var connectionFailed = false;
  var data;

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
    } else if (dataIndex['bookingType'] == 'transferrecipt') {
      return 'DRIVER UNKNOWN';
    }
    else {
      return 'text error';
    }
  }

  String getDateText1(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return formatCheckIn(dataIndex['checkIn']);
    } else if (dataIndex['bookingType'] == 'transferrecipt') {
      var inputFormat = DateFormat('dd-MM-yyyy');
      DateTime parsedDate = inputFormat.parse(dataIndex['startdate']);
      var text = 'วันที่ ' + parsedDate.day.toString() + ' ' +
          getMonthNameShort(parsedDate.month) + ' พ.ศ. ' +
          convertYearToBE(parsedDate.year).toString() + ' เวลา ' +
          dataIndex['starttime'] + ' น.';
      return text;
    }
    else {
      return '';
    }
  }

  String getDateText2(Map dataIndex) {
    if (dataIndex['bookingType'] == 'accommodation') {
      return formatCheckOut(dataIndex['checkOut']);
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.bookingData;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                if (data[index]['bookingType'] == 'accommodation') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => hotelDetail(
                              detail: data[index])))
                } else {
                  // print('not accom'),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => transferDetail(
                              detail: data[index])))
                },

              },
              child: GFCard(
                elevation: 8,
                color: const Color(0xff1D3557),
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
                              colors: [Colors.transparent, Color(0xff1D3557)],
                              ).createShader(Rect.fromLTRB(80, 0, rect.width*1, rect.height));
                            },
                            blendMode: BlendMode.srcATop,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.asset('assets/images/homebg.png',
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
                                  getBookingTitle(data[index]),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'UNDEFINED SUBTITLE',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontSize: 12),
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    if (data[index]['bookingType'] == 'accommodation')
                                      Icon(Icons.calendar_today_outlined,
                                          color: Color(0xffECFAFF),
                                          size: 14),
                                    SizedBox(width: 3,),
                                    Text(
                                      getDateText1(data[index]),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Color(0xffECFAFF),
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    if (data[index]['bookingType'] == 'accommodation')
                                      Icon(Icons.alarm_off,
                                          color: Color(0xffECFAFF),
                                          size: 14),
                                    SizedBox(width: 3,),
                                    Text(
                                      getDateText2(data[index]),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Color(0xffECFAFF),
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
                          color: Color(0xffECFAFF),
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: BookingTypeIcon(type: data[index]['bookingType']),
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
                              color: Color(0xffECFAFF),
                              fontSize: 9),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
