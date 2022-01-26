import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/eachcard.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/newcard.dart';

import '../profile.dart';

class maincreditcard extends StatefulWidget {
  @override
  _maincreditcardState createState() => _maincreditcardState();
}

class _maincreditcardState extends State<maincreditcard> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }));
                },
                  child :Container(
                    child: Row(
                      children: [
                        Image.asset('assets/icons/back.png',width: 25, height: 25,),
                      ],
                    ),
                  ),),
                SizedBox(width: 100,),
                //Icon(Icons.house, color: Color(0xFFECFAFF), size: 25,),
                Text("บัตรที่บันทึกไว้", style: TextStyle(fontSize: 17, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),

              ],
            ),
          ),
          //จบส่วนหัว
          SizedBox(height:10 ,),
          //ส่วนล่าง
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //ยังไม่มีบัตร
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return newcard();
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
                        Container(padding: const EdgeInsets.all(20.0),),
                        Text("ยังไม่มีบัตรเครดิตที่บันทึกไว้", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                      ],
                    ),
                  ),
                ),
                //จบยังไม่มีบัตร
                SizedBox(height: 15,),
                //บัตรที่บันทึก
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return eachcard();
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
                        Image.asset('assets/icons/visa.png', width: 40.0, height: 40.0),
                        SizedBox(width: 20,),
                        Text("ชื่อบัตร", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        SizedBox(width: 148,),
                        Image.asset('assets/icons/next 3.png', width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ),
                //จบบัตรที่บันทึก
                SizedBox(height: 15,),
                //เพิ่มบัตรใหม่
                Container(child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Text("เพิ่มบัตรใหม่", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                  ],
                ),
                ),
                //จบเพิ่มบัตรใหม่
                SizedBox(height: 15,),
                //ข้อมูลบัตร
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return newcard();
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
                        Image.asset('assets/icons/creditcard2.png', width: 40.0, height: 40.0),
                        SizedBox(width: 20,),
                        Text("บัตรเครดิต/เดบิต", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        SizedBox(width: 66,),
                        Image.asset('assets/icons/next 3.png', width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ),
                //จบข้อมูลบัตร
              ],
            ),
          ),
          //จบส่วนล่าง
        ],
      ),
    );
  }
}
