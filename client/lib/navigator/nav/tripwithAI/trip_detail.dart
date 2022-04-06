import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import 'package:se_app2/Home/Attraction/tourism_result.dart';
import 'package:se_app2/navigator/nav/tripwithAI/trip_edit.dart';

class tripdetail extends StatefulWidget {

  @override

  _tripdetailState createState() => _tripdetailState();
}

class _tripdetailState extends State<tripdetail> {
  bool begincheck = false;
  bool sdiecheck = false;
  bool endcheck = false;
  // Generating a long list to fill the ListView
  final List<Map> checkbox = List.generate(100,
          (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});

  //เอาไว้สร้างตัวระหว่างทางเพิ่ม
  int btw = 2;
  //เอาไว้สร้างตัวระหว่างทางเพิ่ม

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
            'ข้อมูลทริป',
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => tripedit())
                );
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
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //ชื่อทริป
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30,),
                      Text(
                        'ชื่อ  ทริป',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1D3557),
                        ),
                      ),
                      SizedBox(width: 50,),
                      Flexible(
                        child:Row(
                        children: [
                          Flexible(child: Text(
                            'ไปไหนก็ได้ที่อยากไปไม่ต้องรู้หรอกว่าจะไปไหน',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1D3557),
                            ),
                          ),
                          ),
                          /*IconButton(
                            icon: const Icon(
                              Boxicons.bxs_edit_alt,
                              color: Color(0xff1D3557),
                            ),
                            onPressed: () {},
                          ),*/
                        ],
                      ),
                      ),
                    ],
                  ),
                //จบชื่อทริป
                SizedBox(height: 10,),
                //เวลารวม
                Container(
                  margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'เวลารวมของทริป',
                        style: TextStyle(fontWeight: FontWeight.w900,
                            fontSize: 17,color: Color(0xff1D3557) ),
                      ),
                      Container(
                        width: 170,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_outlined,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text(
                              '12:00 น.',
                              style: TextStyle(fontWeight: FontWeight.w900,
                                  fontSize: 17,color: Color(0xff1D3557) ),
                            ),
                          ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            //จบเวลารวม
            SizedBox(height: 10,),
            //แผนที่
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'เส้นทางและแผนที่',
                    style: TextStyle(fontWeight: FontWeight.w900,
                        fontSize: 17,color: Color(0xff1D3557) ),
                  ),
                  //ปุ่มเปิดแผนที่
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => {},
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15),
                          width: 168,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xff1D3557),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.map_rounded,
                                  color: Color(0xffFF9A62)),
                              SizedBox(width: 10),
                              Text(
                                'เปิดแผนที่',
                                style: TextStyle(
                                    color: Color(0xffECFAFF),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //จบปุ่มเปิดแผนที่
                ],
              ),
            ),
            //จบแผนที่
            SizedBox(height: 10,),
            //ต้นทาง
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 2),
                      child: Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ต้นทาง',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xff1D3557) ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Boxicons.bxs_circle,
                        color: const Color(0xff1BC3FF),
                        size: 30),
                    SizedBox(width: 2,),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        width: 320,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xffFCD88D),
                          borderRadius: BorderRadius.circular(25),

                          /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                        child:Row(
                          children : [
                            Text(
                              'สถานที่ต้นทาง',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w900,
                                  fontSize: 17,color: Color(0xff1D3557) ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
                //จบต้นทาง
                SizedBox(height: 10,),
                //เวลา
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Boxicons.bx_dots_vertical_rounded,
                        color: const Color(0xff1D3557),
                        size: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาเริ่มต้น',
                          style: TextStyle(fontWeight: FontWeight.w900,
                              fontSize: 15,color: Color(0xff1D3557) ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          width: 135,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.access_time_outlined,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text(
                                '12:00 น.',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 17,color: Color(0xff1D3557) ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาจบของทริป',
                          style: TextStyle(fontWeight: FontWeight.w900,
                              fontSize: 15,color: Color(0xff1D3557) ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          width: 135,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.access_time_outlined,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text(
                                '12:00 น.',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 17,color: Color(0xff1D3557) ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                        value: begincheck,
                        onChanged: (begincheck) => setState(() => this.begincheck = begincheck),
                    )
                  ],
                ),
              ],
            ),
            //จบเวลา
            SizedBox(height: 10,),
            //ระหว่างทาง
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //สร้างตัวระหว่างทาง
                itemCount: btw,
                itemBuilder: (context,index){
                  return  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 2),
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ระหว่างทาง',
                                        style: TextStyle(fontWeight: FontWeight.w900,
                                            fontSize: 15,color: Color(0xff1D3557) ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_circle,
                              color: const Color(0xffFF9A62),
                              size: 30),
                          SizedBox(width: 2,),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            width: 320,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD88D),
                              borderRadius: BorderRadius.circular(25),

                              /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                            child:Row(
                              children : [
                                Text(
                                  'สถานที่ระหว่างทาง',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 17,color: Color(0xff1D3557) ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //จบต้นทาง
                      SizedBox(height: 10,),
                      //เวลา
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bx_dots_vertical_rounded,
                              color: const Color(0xff1D3557),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาเริ่มต้น',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '12:00 น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557) ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาจบของทริป',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '12:00 น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557) ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: sdiecheck,
                            onChanged: (sdiecheck) => setState(() => this.sdiecheck = sdiecheck),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                }
            ), //จบเวลา
            SizedBox(height: 10,),
            //ปลายทาง
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 2),
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ปลายทาง',
                                        style: TextStyle(fontWeight: FontWeight.w900,
                                            fontSize: 15,color: Color(0xff1D3557) ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_been_here,
                              color: const Color(0xffFF0000),
                              size: 30),
                          SizedBox(width: 2,),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            width: 320,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD88D),
                              borderRadius: BorderRadius.circular(25),

                              /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                            child:Row(
                              children : [
                                Text(
                                  'สถานที่ปลายทาง',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 17,color: Color(0xff1D3557) ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //จบต้นทาง
                      SizedBox(height: 10,),
                      //เวลา
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bx_dots_vertical_rounded,
                              color: const Color(0xff1D3557),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาเริ่มต้น',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '12:00 น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557) ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาจบของทริป',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '12:00 น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557) ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: endcheck,
                            onChanged: (endcheck) => setState(() => this.endcheck = endcheck),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //จบปลายทาง
            SizedBox(height: 20,),
            // ปุ่มกดเพิ่ม
            // ปุ่มกดสร้าง
            ElevatedButton(
              /*onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                            shadowColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                        ),*/
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                onPrimary: const Color(0xff7BEE99),
                primary: const Color(0xff7BEE99),
                minimumSize: const Size(350, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              child: const Text(
                'เริ่มทริป',
                style: TextStyle(color: Color(0xff1D3557), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
