import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/booking/booking.dart';

import '../profile.dart';


class partnershippage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "partnership",
      home: partnership(),

    );
  }
}

class partnership extends StatefulWidget {
  @override
  _partnershipState createState() => _partnershipState();
}

class _partnershipState extends State<partnership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      body: Column(
        children: [
          //ส่วนหัว
          Container(
            padding: const EdgeInsets.only(top: 50.0,left: 20),
            decoration: BoxDecoration(
                color : Color(0xFF1d3557), borderRadius : BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),)),
            height: 100,
            child: Row(
              children: [
                GestureDetector( onTap: () {
                  Navigator.pop(context);
                  },
                child :Container(
                  child: Row(
                    children: [
                      Image.asset('assets/icons/back.png',width: 25, height: 25,),
                    ],
                  ),
                ),),
                SizedBox(width: 96,),
                //Icon(Icons.house, color: Color(0xFFECFAFF), size: 25,),
                Text("สมัครพาร์ทเนอร์", style: TextStyle(fontSize: 17, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),

              ],
            ),

          ),
          //จบส่วนหัว
          SizedBox(height: 10,),
          //ส่วนเมนู
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                //ที่พัก
                  Container(
                    width: 87,
                    padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                  color : Color(0xff1d3557), borderRadius : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),),
                    height: 60,
                    child: Text("ที่พัก", style: TextStyle(fontSize: 15, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                  ),
                SizedBox(width: 1,),
                //เช่ารถ
                Container(
                  width: 87,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color : Color(0xff1d3557),),
                  height: 60,
                  child: Text("เช่ารถ", style: TextStyle(fontSize: 15, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                ),
                SizedBox(width: 1,),
                //รถรับส่ง
                Container(
                  width: 87,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color : Color(0xff1d3557),),
                  height: 60,
                  child: Text("รถรับส่ง", style: TextStyle(fontSize: 15, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                ),
                SizedBox(width: 1,),
                //กิจกรรม
                Container(
                  width: 87,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color : Color(0xff1d3557), borderRadius : BorderRadius.only(bottomRight: Radius.circular(10),topRight:Radius.circular(10)),),
                  height: 60,
                  child: Text("กิจกรรม", style: TextStyle(fontSize: 15, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
          //จบส่วนเมนู

          SizedBox(height:0,),
          //ส่วนล่าง
          //รวมกล่อง
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //กล่อง1
                GestureDetector( onTap: () {
                  //print('Test');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return partnership();
                  }));
                },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color : Color(0xff1d3557), borderRadius : BorderRadius.circular(10),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 6, // blur radius
                          offset: Offset(1, 6), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    height: 80,
                    child: Row(
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      children :[
                        Image.asset('assets/icons/partnership.png',width: 40, height: 40,),
                        //Icon(Icons.house, color: Color(0xFFECFAFF), size: 40,),
                        SizedBox(width: 20,),
                        Text(" สมัครเป็นพาทเนอร์", style: TextStyle(fontSize: 20, color: Color(0xFFECFAFF)),),
                        SizedBox(width: 50,),
                        Expanded(
                          child: Image.asset('assets/icons/next 1.png',width: 40, height: 40,),
                        ),
                      ],
                    ),
                  ),
                ),
                //จบกล่อง1
                SizedBox(height: 15,),
                //กล่อง 2
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Booking();
                  }));
                },
                  child : Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color : Color(0xFFECFAFF), borderRadius : BorderRadius.circular(10),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 6, // blur radius
                          offset: Offset(1, 6), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    height: 80,
                    child: Row(
                      children :[
                        Image.asset('assets/icons/creditcard.png', width: 40.0, height: 40.0),
                        SizedBox(width: 20,),
                        Text("บัตรเครดิตที่บันทึกไว้", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        SizedBox(width: 36,),
                        Image.asset('assets/icons/next 3.png', width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ),
                //จบกล่อง 2
                SizedBox(height: 15,),
                //กล่อง 3
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Booking();
                  }));
                },
                  child : Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color : Color(0xFFECFAFF), borderRadius : BorderRadius.circular(10),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 6, // blur radius
                          offset: Offset(1, 6), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    height: 80,
                    child: Row(
                      children :[
                        Image.asset('assets/icons/favourite.png', width: 40.0, height: 40.0),
                        SizedBox(width: 20,),
                        Text("รายการโปรด", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        SizedBox(width: 100,),
                        Image.asset('assets/icons/next 3.png', width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ),
                //จบกล่อง 3
                SizedBox(height: 15,),
                //กล่อง 4
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Booking();
                  }));
                },
                  child : Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color : Color(0xFFECFAFF), borderRadius : BorderRadius.circular(10),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 6, // blur radius
                          offset: Offset(1, 6), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    height: 80,
                    child: Row(
                      children :[
                        Image.asset('assets/icons/help.png', width: 40.0, height: 40.0),
                        SizedBox(width: 20,),
                        Text("ศูนย์ช่วยเหลือ", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        SizedBox(width: 92,),
                        Image.asset('assets/icons/next 3.png', width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ),
                //จบกล่อง 4
              ],),),
          //จบส่วนล่าง
        ],
      ),
    );
  }
}
