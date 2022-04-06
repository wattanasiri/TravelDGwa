import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/screen/login_register/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class confirmLogoutBox extends StatefulWidget {

  final detail;
  final type;
  final width;
  final height;
  const confirmLogoutBox(
      {Key key,
        @required this.detail,
        this.type,
        this.width,
        this.height
      })
      : super(key: key);

  @override
  _myState createState() => _myState();
}

class _myState extends State<confirmLogoutBox> {
  var detail;

  Future clearToken() async {
    var _prefs = await SharedPreferences.getInstance();

    final success = await _prefs.remove('token');
    print(success);
  }

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
                color: boxColor,
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
                          'ออกจากระบบ',
                          style: GoogleFonts.poppins(
                              color: primaryColor,
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
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 14,),
                                children: <TextSpan>[
                                  TextSpan(text:
                                  'คุณต้องการที่จะออกจากระบบหรือไม่?',),
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
                              color: grayColor,
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
                                    clearToken();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(
                                        builder: (context) => LoginScreen()
                                    )
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
