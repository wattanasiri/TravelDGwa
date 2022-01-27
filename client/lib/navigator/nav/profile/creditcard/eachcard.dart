import 'package:flutter/material.dart';

class eachcard extends StatefulWidget {
  @override
  _eachcardState createState() => _eachcardState();
}

class _eachcardState extends State<eachcard> {
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'ข้อมูลบัตร',
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
      body: Column(
        children: [
          SizedBox(height: 10,),
          //ส่วนล่าง
          Container(
            //รวมส่วนล่าง
            padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //บัตร
                    Container(
                      padding: const EdgeInsets.only(top: 10),
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
                      height: 200,
                        child : Column(
                          children: [
                            //ตราวีซ่า
                            Container(
                              padding: const EdgeInsets.only(left: 290),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/visa.png',width: 40, height: 40,),
                              ],
                            ),
                            ),
                            SizedBox(height: 40,),
                            //เลขบัตร
                            Container(
                      child: Row(
                        children :[
                          SizedBox(width: 20,),
                          Text("01", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                        ],
                      ),
                          ),
                            SizedBox(height: 40,),
                            //ชื่อ
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text("ชื่อ", style: TextStyle(fontSize: 17, color: Color(0xFF1d3557)),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                  //จบส่วนบัตร
                  SizedBox(height: 35,),
                  //ส่วนติ๊ก
                  Container(
                    child: Row(
                      children: [
                        Text("ตั้งค่าเป็นบัตรหลัก", style: TextStyle(fontSize: 20, color: Color(0xff1d3557)),),
                  //จบส่วนติ๊ก
                      ],
                    ),
                  ),
                  //ลบบัตร
                  SizedBox(height: 20,),
                    Container(

                      decoration: BoxDecoration(
                        color : Color(0xffF25B52), borderRadius : BorderRadius.circular(15),
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
                          SizedBox(width: 145,),
                          Text("ลบบัตร", style: TextStyle(fontSize: 20, color: Color(0xFFECFAFF)),),
                        ],
                      ),
                    ),
                  //จบลบบัตร
                ],
              ),
            //จบรวมส่วนล่าง
          ),
          //จบส่วนล่าง
        ],
      ),
    );
  }
}
