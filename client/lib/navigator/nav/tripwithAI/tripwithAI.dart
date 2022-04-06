import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:se_app2/navigator/nav/tripwithAI/trip_detail.dart';
import 'package:se_app2/navigator/nav/tripwithAI/trip_log.dart';

class TripWithAI extends StatefulWidget {

  const TripWithAI({Key key}) : super(key: key);


  @override
  _TripWithAIState createState() => _TripWithAIState();
}


class _TripWithAIState extends State<TripWithAI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : const Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400.0),
        /* AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.pushNamed(
              context, '/Navi',
            ),
          ),
          title: const Text(
            'ไลฟ์ไสตล์การเที่ยว',
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
        ),*/
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 0),
            decoration: const BoxDecoration(
                color : Color(0xFF1d3557),
                borderRadius : BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                )
            ),

            child: Column(
              children: [
                const SizedBox(width: 15),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ต้นทาง
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_circle,
                              color: const Color(0xff1BC3FF),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ต้นทาง',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xffFFF4DC) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                  /*border: Border.all(
                                    color: const Color(0xff1D3557), width: 2)*/),
                                child: TextFormField(
                                  //controller: name,
                                  decoration: const InputDecoration(
                                      hintText: 'สถานที่ต้นทาง',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                      /*suffixIcon:
                                      Icon(Icons.search, color: Color(0xff1D3557))*/
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุสถานที่ต้นทาง';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //word = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Boxicons.bx_dots_vertical_rounded,
                              color: const Color(0xffFFF4DC),
                              size: 30),
                        ],
                      ),
                      //ปลายทาง
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Icon(Boxicons.bxs_been_here,
                              color: const Color(0xffFF0000),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ปลายทาง',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xffFFF4DC) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                  /*border: Border.all(
                                    color: const Color(0xff1D3557), width: 2)*/),
                                child: TextFormField(
                                  //controller: name,
                                  decoration: const InputDecoration(
                                    hintText: 'สถานที่ปลายทาง',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xffECFAFF))),
                                    /*suffixIcon:
                                      Icon(Icons.search, color: Color(0xff1D3557))*/
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุสถานที่ต้นทาง';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //word = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      //เวลา
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาเริ่มต้น',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xffFFF4DC) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                width: 170,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    hintText: 'ชม./น./วินาที',
                                    prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'กรุณาระบุเวลา';
                                    }
                                    return null;
                                  },
                                  //controller: _timegetcarcontroller,
                                  //focusNode: myFocusNode2,
                                  onTap: () async {
                                    TimeOfDay pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    if(pickedTime != null ){
                                      //DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                      //String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                      //_timegetcarcontroller.text = formattedTime.toString();

                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลารวมของทริป',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xffFFF4DC) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                width: 170,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    hintText: 'ชม./น./วินาที',
                                    prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'กรุณาระบุเวลา';
                                    }
                                    return null;
                                  },
                                  //controller: _timegetcarcontroller,
                                  //focusNode: myFocusNode2,
                                  onTap: () async {
                                    TimeOfDay pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    if(pickedTime != null ){
                                      //DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                      //String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                      //_timegetcarcontroller.text = formattedTime.toString();

                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      //ปุ่มกดสร้าง
                      ElevatedButton(
                        /*onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                            shadowColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                        ),*/
                        onPressed: () {
                          openEditNameDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          onPrimary: const Color(0xff7BEE99),
                          primary: const Color(0xff7BEE99),
                          minimumSize: const Size(350, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text(
                          'สร้างทริป',
                          style: TextStyle(color: Color(0xff1D3557), fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          title: const Text(
            'การจัดทริป',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => triplog())
                  );
                },
                child: Text(
                  'บันทึกทริป',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFF9A62),
                  ),
                ),)
          ],

        ),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                        builder: (context) => triplog())
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
  Future openEditNameDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ชื่อทริป',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextFormField(
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                setState(() {
                  //word = nameEdit.text;
                });
                //ดึงข้อมูล
                //get....();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => tripdetail())
                  );
              },
              child: const Text('ตกลง'))
        ],
      ));
}