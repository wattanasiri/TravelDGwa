import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/booking/booking.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/acommodation/accommodation_partner.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/activity/activity_partner.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/airport_tranfer/airport_tranfer_partner.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/rentcar/rentcar.dart';

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
    return
      DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1d3557),
          bottom: TabBar(
            // labelPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            tabs: [
              Tab(text: 'ที่พัก'),
              Tab(text: 'เช่ารถ'),
              Tab(text: 'รถรับส่ง'),
              Tab(text: 'กิจกรรม'),
            ],
          ),
          title: Text('สมัครพาร์ทเนอร์'),
        ),
        body: TabBarView(
          children: [
            accom_partner(),
            rentcar_partner(),
            airport_tranfer_partner(),
            activity_partner(),
          ],
        ),
      ),
    );

  }
}
