import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/changepass.dart';
import 'package:se_app2/navigator/nav/profile/profile.dart';

class editpro extends StatefulWidget {
  @override
  _editproState createState() => _editproState();
}

class _editproState extends State<editpro> {
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
                    return ProfilePage();
                  }));
                },
                  child :Container(
                    child: Row(
                      children: [
                        Text("ยกเลิก", style: TextStyle(fontSize: 17, color: Color(0xFFFF9A62)),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),),
                SizedBox(width: 80,),
                Text("แก้ไขโปรไฟล์", style: TextStyle(fontSize: 17, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),
                SizedBox(width: 85,),
                //ปุ่มบันทึก
                GestureDetector( onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
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
          SizedBox(height: 10,),
          //ส่วนล่าง
          Container(
            child: Column(
              children: [
                //ส่วนรูปโปรไฟล์
                Container(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFECFAFF),
                        radius: 48,
                        child: Text("SC", style: TextStyle(fontSize: 40, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                      ),
                      SizedBox(height: 5,),
                      Text("เปลี่ยนรูปโปรไฟล์", style: TextStyle(fontSize: 17, color: Color(0xFFFF9A62)),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
                //จบส่วนรูปโปรไฟล์
                SizedBox(height: 10,),
                //เส้นกั้น
                Container(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: Column(
                  children: [
                    Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color : Color(0xff1d3557), borderRadius : BorderRadius.circular(10),
                    ),
                  ),
                  ],
                ),
                ),
                //จบเส้นกั้น
                //ชื่อและนามสกุล
                Container(
                  child: Row(
                    children: [
                      //ชื่อ
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [

                            Text("ชื่อ", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                            Container(
                              width: 170,
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
                                  hintText: 'ชื่อ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                      //นามสกุล
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [
                            Text("นามสกุล", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                            Container(
                              width: 170,
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
                                  hintText: 'นามสกุล',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //จบส่วนชื่อและนามสกุล
                //ส่วนเมล
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text("อีเมลล์", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                            hintText: 'E-mail',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                //จบส่วนเมล
                //ส่วนเบอร์ทรศ
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text("เบอร์โทรศัพท์", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                            hintText: '09-8765-4321',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                //จบส่วนเบอร์ทรศ
                SizedBox(height: 10,),
                //ส่วนเปลี่ยนรหัส

                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      //เส้นกั้น
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color : Color(0xff1d3557), borderRadius : BorderRadius.circular(10),
                        ),
                      ),
                      //จบเส้นกั้น
                      //เปลี่ยนรหัส
                      SizedBox(height: 10,),
                      GestureDetector( onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return changepass();
                        }));
                      },
                        child : Text("เปลี่ยนรหัสผ่าน", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                      ),
                      SizedBox(height: 10,),
                      //เส้นกั้น
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color : Color(0xff1d3557), borderRadius : BorderRadius.circular(10),
                        ),
                      ),
                      //จบเส้นกั้น
                    ],
                  ),
                ),

                //จบส่วนเปลี่ยนรหัส
              ],
            ),
          ),
          //จบส่วนล่าง
        ],
      ),
    );
  }
}
