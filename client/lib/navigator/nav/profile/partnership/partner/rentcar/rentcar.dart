import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/rentcar/rentcar_register.dart';

class rentcar_partner extends StatefulWidget {


  @override
  _rentcar_partnerState createState() => _rentcar_partnerState();
}

class _rentcar_partnerState extends State<rentcar_partner> {

  final GlobalKey<FormState> _formKey = GlobalKey();
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
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => rentcar_register(
                    ),));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.directions_car, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สมัครเป็นพาร์ทเนอร์รถเช่า',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            // Text(
                            //   'ที่อยู่อาศัยตกแต่งในอาคารอพาร์ตเมนต์ที่มีห้องพักส่วนตัวพร้อม บริการเหมือนโรงแรม',
                            //   style: TextStyle(
                            //     color: Color(0xff1D3557),
                            //     fontSize: 14,
                            //   ),
                            // )
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
