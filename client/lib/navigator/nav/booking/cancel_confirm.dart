import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/navigator/nav/booking/components/cancel_notif.dart';

import 'booking.dart';


class confirmCancelBox extends StatefulWidget {

  final detail;
  final width;
  final height;
  const confirmCancelBox(
      {Key key,
        this.detail,
        this.width,
        this.height
      })
      : super(key: key);

  @override
  _confirmBoxState createState() => _confirmBoxState();
}

class _confirmBoxState extends State<confirmCancelBox> {
  var detail;

  @override
  void initState() {
    super.initState();
    detail = widget.detail;
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(15))),
      contentPadding: EdgeInsets.all(0),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            height: 200,
            width: width - 50,
            decoration: BoxDecoration(
                color: Color(0xFFECFAFF),
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      top: 16,
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
                          'ยกเลิกการจอง',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff1D3557),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 12,),
                                children: <TextSpan>[
                                  TextSpan(text:
                                  'ในการยกเลิกการจองต้องใช้เวลาดำเนินการคืนเงิน ประมาณ 1-2 สัปดาห์ และอาจมีค่าธรรมเนียมในการยกเลิกตาม ',),
                                  TextSpan(
                                      text: 'ข้อกำหนดของ TravelDGwa',
                                      style:  TextStyle(
                                          color: orangeColor,
                                          decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('move user to ToS');
                                        }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xff827E7E),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: (width - 90) * 0.509,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Text(
                                      'ยกเลิก',
                                      style: GoogleFonts.poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Booking()));
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return notifBox(
                                          title: 'ยกเลิกการจอง',
                                          text: 'การยกเลิกการจองเสร็จสมบูรณ์',
                                          fontSize: 14.0,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: (width - 90) * 0.509,
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      'ดำเนินการต่อ',
                                      style: GoogleFonts.poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,),
                                      textAlign: TextAlign.center,
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
          );
        },
      ),
    );
  }
}
