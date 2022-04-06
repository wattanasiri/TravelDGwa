import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';

class rentcar_request extends StatefulWidget {


  @override
  _rentcar_requestState createState() => _rentcar_requestState();
}

class _rentcar_requestState extends State<rentcar_request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFFF4DC),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff1D3557),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () =>  Navigator.pushNamed(
                context, '/Navi',
              ),
            ),
            title: const Text(
              'สมัครพาร์ทเนอร์เช่ารถ',
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
        body:SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Icon(
                      Icons.access_time,
                      size: 200,
                      color: Color(0xff1D3557)),
                  SizedBox(height: 30),
                  Text(
                    "ระบบได้รับข้อมูลการสมัครเป็นพาร์ทเนอร์ของท่านเรียบร้อยแล้ว โปรดรอการแจ้งยืนยันผล ทาง SMS และ Email ที่ลงทะเบียนไว้ หลังตรวจสอบข้อมูลเสร็จสิ้น",
                    style: TextStyle(
                      color: Color(0xff1D3557),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            )

        )

    );
  }
}
