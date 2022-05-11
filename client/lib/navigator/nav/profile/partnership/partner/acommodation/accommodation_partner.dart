import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/acommodation/accom_register.dart';

class accom_partner extends StatefulWidget {

  @override
  _accom_partnerState createState() => _accom_partnerState();
}

class _accom_partnerState extends State<accom_partner> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffFFF4DC),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(20),
                    primary: const Color(0xffECFAFF),
                    onPrimary: const Color(0xff1D3557),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () async=> {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => accom_register(
                    //
                    // ),)),
                  },
                  child: Row(
                    children: [
                      Icon(Icons.apartment_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'อพาร์ทเม้น',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'ที่อยู่อาศัยตกแต่งในอาคารอพาร์ตเมนต์ที่มีห้องพักส่วนตัวพร้อมบริการเหมือนโรงแรม',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(20),
                    primary: const Color(0xffECFAFF),
                    onPrimary: const Color(0xff1D3557),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => partnership())
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.holiday_village_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'วิลลา',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'ที่พักที่เป็นพื้นที่ขนาดใหญ่ บรรจุกลุ่มคนได้เป็นจำนวนมาก เป็นพื้นที่โล่งและใกล้เคียงกับธรรมชาติ',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(20),
                    primary: const Color(0xffECFAFF),
                    onPrimary: const Color(0xff1D3557),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => partnership())
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.house_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'บ้านเดี่ยว',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'ที่พักเชิงพาณิชย์ที่ให้บริการห้องพักส่วนตัวพร้อมอาหารและบริการแขก',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(20),
                    primary: const Color(0xffECFAFF),
                    onPrimary: const Color(0xff1D3557),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => partnership())
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.bungalow_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'บังกะโล',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'บ้านพักตากอากาศตามชายทะเล ',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
