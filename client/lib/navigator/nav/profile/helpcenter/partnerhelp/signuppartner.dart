import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:google_fonts/google_fonts.dart';

class signuppartnerhelp extends StatefulWidget {

  @override

  _signuppartnerhelpState createState() => _signuppartnerhelpState();
}

class _signuppartnerhelpState extends State<signuppartnerhelp> {


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
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          title: const Text(
            'ศูนย์ช่วยเหลือพาร์ทเนอร์',
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
        padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30,right: 20),
        //padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 30),
        /*physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),*/
        child: Flexible(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start
            ,
            children: [
              Row(
                children: [
                  Flexible(child:
                  Text(
                    "ฉันจะสมัครพาร์ทเนอร์ได้อย่างไร",
                    maxLines: null,
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    //1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1 .   ",
                          maxLines: null,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff1D3557),
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                        Flexible(
                          child: Text(
                            "ขั้นตอนแรกให้เข้าไปในหน้าโปรไฟล์และเลือกฟังค์ชั่น สมัครเป็นพาร์ทเนอร์",
                            maxLines: null,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: const Color(0xff1D3557),
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 7,),
                    //2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2 .   ",
                          maxLines: null,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff1D3557),
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                        Flexible(
                          child: Text(
                            "ขั้นตอนต่อไปให้ท่านเลือกหัวข้อพาร์ทเนอร์ที่ท่านจะ สมัคร",
                            maxLines: null,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: const Color(0xff1D3557),
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 7,),
                    //3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "3 .   ",
                          maxLines: null,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff1D3557),
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                        Flexible(
                          child: Text(
                            "หลังจากนั้นระบบจะให้ท่านทำการกรอกข้อมูลของ ท่านและการให้บริการที่ท่านเลือก ",
                            maxLines: null,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: const Color(0xff1D3557),
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 7,),
                    //4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "4 .   ",
                          maxLines: null,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff1D3557),
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                        Flexible(
                          child: Text(
                            "หลังจากที่ท่านกรอกและกดสมัครแล้วระบบจะทำการตรวจสอบและแจ้งท่านกลับไปทางSMSหรือEmail ของท่าน",
                            maxLines: null,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: const Color(0xff1D3557),
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

}
