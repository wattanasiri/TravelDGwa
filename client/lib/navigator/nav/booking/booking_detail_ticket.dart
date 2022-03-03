import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';

import 'booking_item.dart';
import 'cancel_confirm.dart';

class ticketDetail extends StatefulWidget {

  final detail;
  const ticketDetail(
      {Key key,
      this.detail,
      })
      : super(key: key);

  @override
  State<ticketDetail> createState() => _TargetState();
}

class _TargetState extends State<ticketDetail> {

  var detail;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'AAAAA',
                  style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 8,),
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

                          },
                        ),
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: grayColor,
                        primary: grayColor,
                        minimumSize: Size(size.width * 0.9, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      child: const Text(
                        'บริการนี้ไม่สามารถยกเลิกได้',
                        style: TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),


      )
    );
  }
}