import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/activity/activity_register.dart';

class activity_partner extends StatefulWidget {

  @override
  _activity_partnerState createState() => _activity_partnerState();
}

class _activity_partnerState extends State<activity_partner> {
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_register(

                    ),)),
                  },
                  child: Row(
                    children: [
                      Icon(Icons.event_available_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'กิจกรรม',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'การจัดกิจกรรมต่างๆไม่ว่าจะเป็นสถานที่ท่องเที่ยวหรือสถานที่พักผ่อนให้นักท่องเที่ยวภายใน 1 วัน',
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


