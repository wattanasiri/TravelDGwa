import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/maincreditcard.dart';

class newcard extends StatefulWidget {
  @override
  _newcardState createState() => _newcardState();
}

class _newcardState extends State<newcard> {
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
                    return maincreditcard();
                  }));
                },
                  child :Container(
                    child: Row(
                      children: [
                        Image.asset('assets/icons/back.png',width: 25, height: 25,),
                      ],
                    ),
                  ),),
                SizedBox(width: 125,),
                //Icon(Icons.house, color: Color(0xFFECFAFF), size: 25,),
                Text("เพิ่มบัตร", style: TextStyle(fontSize: 17, color: Color(0xFFECFAFF)),textAlign: TextAlign.center,),

              ],
            ),
          ),
          //จบส่วนหัว
          SizedBox(height: 20,),
          //ส่วนล่าง
          //ส่วนหมายเลขบัตร
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text("หมายเลขบัตร", style: TextStyle(fontSize: 15, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                      hintText: 'หมายเลขบัตร',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
          //จบส่วนหมายเลขบัตร
          //ชื่อบนบัตร
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text("ชื่อบนบัตร", style: TextStyle(fontSize: 15, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                      hintText: 'ชื่อบนบัตร',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
          //จบส่วนชื่อบนบัตร
          //ส่วนวันหมดอายุและCVv
          Container(
            child: Row(
              children: [
                //วันหมดอายุ
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [

                      Text("วันหมดอายุ", style: TextStyle(fontSize: 15, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                            hintText: 'วันหมดอายุ',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                //CVV
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 20),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text("CVV", style: TextStyle(fontSize: 15, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                            hintText: 'CVV',
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
          //จบส่วนส่วนวันหมดอายุและCVV
          //ส่วนหมายเลขบัตร
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text("ชื่อเล่นบัตร (ไม่บังคับ)", style: TextStyle(fontSize: 15, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
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
                      hintText: 'ชื่อเล่น',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
          //จบส่วนหมายเลขบัตร
          //ตั้งค่าเป็นบัตรหลัก
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(

              children: [
                Text("ตั้งค่าเป็นบัตรหลัก", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
              ],
            ),
          ),
          //จบต้งค่าเป็นบัตรหลัก
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
            children: [
              //ลบบัตร
              Container(
                decoration: BoxDecoration(
                  color : Color(0xff1D3557), borderRadius : BorderRadius.circular(15),
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
                height: 60,
                child: Row(
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  children :[
                    //Icon(Icons.house, color: Color(0xFFECFAFF), size: 40,),
                    SizedBox(width: 135,),
                    Text("บันทึกบัตร", style: TextStyle(fontSize: 20, color: Color(0xFFECFAFF)),),
                  ],
                ),
              ),
              //จบลบบัตร
            ],
          ),),

          //จบส่วนล่าง
        ],
      ),
    );
  }
}
