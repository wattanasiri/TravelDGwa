import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';

import 'billing_transfer.dart';
import 'cancel_confirm.dart';

class transferDetail extends StatefulWidget {

  final detail;
  const transferDetail(
      {Key key,
      this.detail,
      })
      : super(key: key);

  @override
  State<transferDetail> createState() => _TargetState();
}

class _TargetState extends State<transferDetail> {

  var detail;

  String type = 'transfer';

  String formatDate(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }

  String formatTime(String time) {
    var text = time + ' น.';
    return text;
  }

  RatingBarIndicator _buildRatingBar(double rating){
    return RatingBarIndicator(
        rating: rating,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: EdgeInsets.only(right: 0.7),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemSize: 20.0,
    );
  }


  @override
  void initState() {
    super.initState();
    detail = widget.detail;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('รถรับ - ส่งสนามบิน',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top:20,
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'ข้อมูลคนขับ',
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 8,),
                Container(

                  decoration: BoxDecoration(
                      color: boxColor,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 10,
                          right: 10,
                        ),
                        child: Image.asset('assets/images/driver_example.png',
                            width: 70.0, height: 70.0),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              'นายสมปอง ดองงาน',
                              style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'รถรุ่น : Honda City',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                              Text(
                                'ทะเบียน : ฟฟ 6207',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Flexible(child: _buildRatingBar(3.8),),

                                  Text(
                                    '(3.8)',
                                    style: TextStyle(
                                      color: grayColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(Boxicons.bxs_phone),
                                color: primaryColor,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 30),
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(Boxicons.bxs_chat),
                                color: primaryColor,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 30),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                      color: boxColor,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'วันที่',
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 18,),
                              ),
                            ),
                            Text(
                              formatDate(detail['startdate']),
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 18,),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'เวลา',
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 18,),
                              ),
                            ),
                            Text(
                              formatTime(detail['starttime']),
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 18,),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'ประเภทรถ',
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 18,),
                              ),
                            ),
                            Text(
                              detail['typeshuttle'],
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 18,),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: primaryColor,
                                      ),
                                      Positioned(
                                        top: 30.0,
                                        child: SizedBox(
                                          width: 4.0,
                                          child: Icon(
                                            Boxicons.bx_dots_vertical_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'จาก',
                                        style: GoogleFonts.poppins(
                                            color: primaryColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        detail['yourlocation'],
                                        style: GoogleFonts.poppins(
                                            color: primaryColor,
                                            fontSize: 11),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 26,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.airplanemode_active,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ไป',
                                        style: GoogleFonts.poppins(
                                            color: primaryColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        detail['destination'],
                                        style: GoogleFonts.poppins(
                                            color: primaryColor,
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: grayColor,
                              ),
                              SizedBox(height: 15,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'ราคา',
                                      style: GoogleFonts.poppins(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'THB ${detail['sum_price']}',
                                    style: GoogleFonts.poppins(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),

                      ],

                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async => {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return transferBilling(
                                detail: detail,
                              );
                            },
                          ),
                        },
                        style: ElevatedButton.styleFrom(
                          onPrimary: primaryColor,
                          primary: primaryColor,
                          minimumSize: Size(size.width * 0.4, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text(
                          'ดูใบเสร็จการชำระ',
                          style: TextStyle(
                              color: secondaryColor, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.05,),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async => {
                          if (detail['canceled'] == false && detail['status'] == 'soon') showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return confirmCancelBox(
                                detail: detail,
                                type: type,
                              );
                            },
                          ),
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                          detail['canceled'] ? grayColor :
                          detail['status'] == 'completed' ? grayColor : redOrangeColor,
                          minimumSize: Size(size.width * 0.4, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: Text(
                          detail['canceled'] ? 'การจองถูกยกเลิก' :
                          detail['status'] == 'completed' ? 'การจองเสร็จสิ้น' : 'ยกเลิกการจอง',
                          style: TextStyle(
                              color: boxColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),


      )
    );
  }
}