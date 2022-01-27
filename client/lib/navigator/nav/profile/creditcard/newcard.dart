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
            'เพิ่มบัตร',
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("หมายเลขบัตร",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'หมายเลขบัตร',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ]
            ),
            Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ชื่อบนบัตร",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'ชื่อบนบัตร',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ]
            ),
            Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("วันหมดอายุ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'วันหมดอายุ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("CVV",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'CVV',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ]
            ),
            Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ชื่อเล่นบัตร (ไม่บังคับ)",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'ชื่อเล่นบัตร (ไม่บังคับ)',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ]
            ),
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
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context).pop()
              },
              style: ElevatedButton.styleFrom(
                elevation: 8,
                onPrimary: const Color(0xff1D3557),
                primary: const Color(0xff1D3557),
                minimumSize: const Size(350, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              child: const Text(
                'บันทึกบัตร',
                style: TextStyle(
                    color: Color(0xffFFF4DC),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            //จบส่วนล่าง
          ],
        ),
      ),
    );
  }
}
