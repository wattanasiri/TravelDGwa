import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cancelhotelhelp.dart';
import 'getbookingdetail.dart';
import 'howtobook.dart';

class accomhelp extends StatefulWidget {

  @override

  _accomhelpState createState() => _accomhelpState();
}

class _accomhelpState extends State<accomhelp> {


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          title: const Text(
            'ศูนย์ช่วยเหลือที่พัก',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30,right: 20),
        //padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 30),
        /*physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),*/
        child: Flexible(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start
            ,
            children: [
              Row(
                children: [
                  Flexible(child:
                  Text(
                    "การช่วยเหลือเกี่ยวกับที่พัก",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              //สอบถามเกี่ยวกับที่พัก
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child:
                  Text(
                    "คำถามยอดนิยม",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              //ฉันจะยกเลิกและขอคืนเงินที่พักได้อย่างไร
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child:
                  Text(
                    "ฉันจะยกเลิกและขอคืนเงินที่พักได้อย่างไร",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xff1D3557)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                              builder: (context) => cancelhotelhelp())
                          );
                      }
                  ),
                ],
              ),
              SizedBox(height: 15,),
              //ฉันจะจองที่พักได้อย่างไร
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child:
                  Text(
                    "ฉันจะจองที่พักได้อย่างไร",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xff1D3557)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                              builder: (context) => howtobookhelp())
                          );
                      }
                  ),
                ],
              ),
              SizedBox(height: 15,),
              //ฉันจะขอรับรายละเอียดการจองอีกครั้งได้อย่างไร
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child:
                  Text(
                    "ฉันจะขอรับรายละเอียดการจองอีกครั้งได้อย่างไร",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xff1D3557)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                              builder: (context) => bookingdetailhelp())
                          );
                      }
                  ),
                ],
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),

      ),
    );
  }

}
