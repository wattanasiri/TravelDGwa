import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';


class notifBox extends StatefulWidget {

  final width;
  final height;
  final fontSize;
  final title;
  final text;
  const notifBox(
      {Key key,
        this.width,
        this.height,
        this.fontSize = 16.0,
        this.title = 'Notification',
        this.text = 'unknown message'
      })
      : super(key: key);

  @override
  _notifBoxState createState() => _notifBoxState();
}

class _notifBoxState extends State<notifBox> {

  var width;
  var height;
  double fontSize;
  String title;
  String text;

  @override
  void initState() {
    super.initState();

    fontSize = widget.fontSize;
    title = widget.title;
    text = widget.text;
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
                          title,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff1D3557),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 105,
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            text,
                            style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: fontSize,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),


                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xff827E7E),
                              ),
                              Expanded(
                                child:
                                  Container(
                                    decoration: BoxDecoration(
                                      color: skyBlueColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ตกลง',
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
