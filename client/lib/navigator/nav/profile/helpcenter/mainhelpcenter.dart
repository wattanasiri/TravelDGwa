import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_main.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/Activityhelp/activityhelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/Aitriphelp/Aitriphelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/bloghelp/bloghelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/flighthelp/flighthelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/flighthelp/howtobookflight.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/partnerhelp/partnerhelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/rentcarhelp/rentcarhelp.dart';
import 'package:se_app2/navigator/nav/profile/helpcenter/transfervehiclehelp/transvehelp.dart';

import 'accomhelp/Accomodationhelp/accomodationhelp.dart';

class mainhelp extends StatefulWidget {

  @override

  _mainhelpState createState() => _mainhelpState();
}

class _mainhelpState extends State<mainhelp> {


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
            'ศูนย์ช่วยเหลือ',
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
                      "การช่วยเหลือตามฟังค์ชั่น",
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
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับที่พัก
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับที่พัก",
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
                              builder: (context) => accomhelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับเที่ยวบิน
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับเที่ยวบิน",
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
                              builder: (context) => flighthelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับบริการรถรับ-ส่ง
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับบริการรถรับ-ส่ง",
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
                              builder: (context) => transvehelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับเช่ารถ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับเช่ารถ",
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
                              builder: (context) => rentcarhelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับกิจกรรม
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับกิจกรรม",
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
                              builder: (context) => activityhelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับพาร์ทเนอร์
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับพาร์ทเนอร์",
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
                              builder: (context) => partnerhelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับการจัดทริป
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับการจัดทริป",
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
                              builder: (context) => aitriphelp())
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //สอบถามเกี่ยวกับบล๊อค
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child:
                    Text(
                      "สอบถามเกี่ยวกับบล๊อค",
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
                              builder: (context) => bloghelp())
                          );
                        }
                    ),
                  ],
                ),
              ],
            ),
        ),

      ),
    );
  }

}
