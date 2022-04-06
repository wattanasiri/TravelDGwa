import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:se_app2/Home/Attraction/tourism_result.dart';
import 'package:se_app2/navigator/nav/tripwithAI/trip_detail.dart';

class triplog extends StatefulWidget {

  @override

  _triplogState createState() => _triplogState();
}

class _triplogState extends State<triplog> {


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
            'บันทึกทริป',
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
          actions: [
            TextButton(
              onPressed: (){

              },
              child: Text(
                'แก้ไข',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFF9A62),
                ),
              ),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
        //padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //กำลังดำเนินการ
            //ไม่มีทริปที่กำลัง
            //เอาให้ส่วนนี้หายไปเลย
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'กำลังดำเนินการ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => tripdetail())
                    );
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff1D3557),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffECFAFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xff1D3557),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff1D3557),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(child: Text(
                              'ไปไหนก็ได้ทริป',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffECFAFF),
                              ),
                            ),),
                            SizedBox(height: 5,),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(child: Text(
                                  'เขาเขียว',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffECFAFF),
                                  ),
                                ),
                                ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62),
                                    size: 30),
                                //ปลายทาง
                                Flexible(child: Text(
                                  'บางแสน',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffECFAFF),
                                  ),
                                ),),
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
            SizedBox(height: 10,),
            //ทริปล่าสุด
            //ไม่มรทริปล่าสุด
            /*Text(
                  'ไม่มีทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => tripdetail())
                    );
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(child: Text(
                              'ไปไหนก็ได้ทริป',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),),
                            SizedBox(height: 5,),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(child: Text(
                                  'เขาเขียว',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1D3557),
                                  ),
                                ), ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62),
                                    size: 30),
                                //ปลายทาง
                                Flexible(child: Text(
                                  'บางแสน',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1D3557),
                                  ),
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => tripdetail())
                    );
                  },
                  child: Row(
                    children: [
                      //กล่องด้านหน้าเวลา
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '8 H',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      //ตกแต่ง
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 7,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xffECFAFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(1, 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      //กล่องหลังข้อมูลทริป
                      Container(
                        width: 225,
                        height: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffECFAFF),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ชื่อทริป
                            Flexible(child: Text(
                              'ไปไหนก็ได้ทริป',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1D3557),
                              ),
                            ),),
                            SizedBox(height: 5,),
                            //สถานที่
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ต้นทาง
                                Flexible(child: Text(
                                  'เขาเขียว',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1D3557),
                                  ),
                                ), ),
                                Icon(Boxicons.bx_right_arrow_alt,
                                    color: const Color(0xffFF9A62),
                                    size: 30),
                                //ปลายทาง
                                Flexible(child: Text(
                                  'บางแสน',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1D3557),
                                  ),
                                ),),
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
          ],
        ),
      ),
    );
  }

}
