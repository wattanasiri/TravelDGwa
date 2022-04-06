import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';

import 'components/dash_separator.dart';

class hotelBilling extends StatefulWidget {

  final detail;
  final width;
  final height;
  const hotelBilling(
      {Key key,
        this.detail,
        this.width,
        this.height
      })
      : super(key: key);

  @override
  _hotelBillingState createState() => _hotelBillingState();
}

class _hotelBillingState extends State<hotelBilling> {
  var detail;
  List pricelist;

  String formatGetCar(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่รับรถ : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }
  String formatSentCar(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่คืนรถ : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }

  String formatPricing(var price) {
    var text = formatPrice(price) + ' THB';
    return text;
  }

  String getDayCount(String getDate, String sendDate) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    DateTime myGetDate = inputFormat.parse(getDate);
    DateTime mySendDate = inputFormat.parse(sendDate);
    var text = (daysBetween(myGetDate, mySendDate) + 1).toString();
    return text;
  }

  @override
  void initState() {
    super.initState();
    detail = widget.detail;

    pricelist = [
      {
        "info": "ค่าเช่ารถสำหรับ ${getDayCount(detail['date_getcar'], detail['date_sentcar'])} วัน",
        "price": detail['sum_detail_pricedate'] + detail['sum_detail_pricetime'],
      },
    ];

    if (detail['sum_detail_pricelocation'] > 0) {
      pricelist.add(
        {
          "info": "ค่าบริการรับส่งรถนอกสถานที่ : ${detail['location_getsentcar']}",
          "price": detail['sum_detail_pricelocation'],
        }
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(6.0))),
      contentPadding: EdgeInsets.all(0),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            height: height * 0.66,
            width: width - 50,
            decoration: BoxDecoration(
                color: Color(0xFFECFAFF),
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -0.0,
                  top: -40.0,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)),
                        child: Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8,
                      left: 0,
                      right: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ใบเสร็จ',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff1D3557),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail['car_name'],
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff1D3557),
                                          fontSize: 14,),
                                      ),
                                      Text(
                                        detail['partnername'],
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff1D3557),
                                          fontSize: 14,),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '#0001TH',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff827E7E),
                                    fontSize: 14,),
                                ),
                              ],
                            ),
                            Text(
                              'ข้อมูลเพิ่มเติม',
                              style: GoogleFonts.poppins(
                                color: const Color(0xff827E7E),
                                fontSize: 12,),
                            ),
                            Text(
                              "ทะเบียนรถ : ${detail['car_license']}",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff827E7E),
                                fontSize: 12,),
                            ),
                            Text(
                              formatGetCar(detail['date_getcar']) + " (${detail['time_getcar']} น.)",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff827E7E),
                                fontSize: 12,),
                            ),
                            Text(
                              formatSentCar(detail['date_sentcar']) + " (${detail['time_sentcar']} น.)",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff827E7E),
                                fontSize: 12,),
                            ),
                            Text(
                              "จุดรับรถ : ${detail['location_getsentcar']}",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff827E7E),
                                fontSize: 12,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      const DashDivider(height: 1,),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.book,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 4,),
                                SizedBox(
                                  width: width * 0.25,
                                  child: Text(
                                    'รวมประกันภัยพื้นฐาน',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff827E7E),
                                      fontSize: 10,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.directions_car_rounded,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 4,),
                                SizedBox(
                                  width: width * 0.28,
                                  child: Text(
                                    'บริการรับ  - ส่งรถตามจุดที่ให้บริการ',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff827E7E),
                                      fontSize: 10,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      const DashDivider(height: 1,),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.08,
                                  child: Text(
                                    'ครั้งที่',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontSize: 12,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    'รายละเอียด',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontSize: 12,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: width * 0.19,
                                  child: Text(
                                    'ราคา',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontSize: 12,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                      parent: NeverScrollableScrollPhysics()),
                      itemCount: pricelist == null ? 0 : pricelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width * 0.08,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff1D3557),
                                          fontSize: 12,),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.45,
                                      child: Text(
                                        pricelist[index]['info'],
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff1D3557),
                                          fontSize: 12,),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.19,
                                      child: Text(
                                        formatPricing(pricelist[index]['price']),
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff1D3557),
                                          fontSize: 12,),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.08,
                                  child: Text(
                                    'รวม',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: width * 0.45,
                                ),
                                Container(
                                  width: width * 0.19,
                                  child: Text(
                                    "${detail['total_price']} THB",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Expanded(child: Container()),
                      // const DashDivider(height: 1,),
                      // Container(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
