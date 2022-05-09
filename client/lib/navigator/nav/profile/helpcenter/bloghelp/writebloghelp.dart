import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class writebloghelp extends StatefulWidget {

  @override

  _writebloghelpState createState() => _writebloghelpState();
}

class _writebloghelpState extends State<writebloghelp> {


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
            'ศูนย์ช่วยเหลือบล็อก',
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
                    "ฉันจะเขียนบล็อกได้อย่างไร",
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
                            "ขั้นตอนแรกให้เข้าไปในบล็อกและระบบจะแสดงหน้า บล็อคต่างๆ",
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
                            "ขั้นตอนต่อไปให้ท่านเลือก “ +” โดยปุ่มจะอยู่ ด้านล่างขวาของจอ",
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
                            "หลังจากที่เลือกแล้วระบบจะให้ท่านเลือกรูปที่จะลงในบล็อกและนำท่านไปยังหน้าที่ใส่ข้อมูล",
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
                            "จากนั้นที่กรอกข้อมูลเสร็จให้ท่านกดปุ่ม “โพสต์”มุมด้านบนขวาจอ",
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
