import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/profile.dart';
import 'package:se_app2/navigator/nav/profile/profile_edit.dart';

class changepass extends StatefulWidget {
  @override
  _changepassState createState() => _changepassState();
}

class _changepassState extends State<changepass> {
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
                //ปุ่มยกเลิก
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return editpro();
                  }));
                },
                  child :Container(
                    child: Row(
                      children: [
                        Text("ยกเลิก", style: TextStyle(fontSize: 17, color: Color(0xFFFF9A62)),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),),
                SizedBox(width: 75,),
                Text("เปลี่ยนรหัสผ่าน", style: TextStyle(fontSize: 17, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                SizedBox(width: 80,),
                //ปุ่มบันทึก
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return editpro();
                  }));
                },
                  child :Container(
                    child: Row(
                      children: [
                        Text("บันทึก", style: TextStyle(fontSize: 17, color: Color(0xFF7BEE99)),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),),
              ],
            ),
          ),
          //จบส่วนหัว
          SizedBox(height: 20,),
          //ส่วนรหัสผ่านเก่า
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text("รหัสผ่านเก่า", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                Container(
                  //width: 370,
                  height: 50,
                  //margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color:Color(0xFFECFAFF),
                    borderRadius: BorderRadius.circular(14),
                    border:  Border.all(color:Color(0xFF1d3557),width: 3),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'รหัสผ่านเก่า',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
          //จบส่วนรหัสผ่านเก่า
          SizedBox(height: 20,),
          //ส่วนรหัสผ่านใหม่
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text("รหัสผ่านใหม่", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                Container(
                  //width: 370,
                  height: 50,
                  //margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color:Color(0xFFECFAFF),
                    borderRadius: BorderRadius.circular(14),
                    border:  Border.all(color:Color(0xFF1d3557),width: 3),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'รหัสผ่านใหม่',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
          //จบส่วนรหัสผ่านใหม่
        ],
      ),
    );
  }
}
