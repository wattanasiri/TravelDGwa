import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:google_fonts/google_fonts.dart';

class cancelhotelhelp extends StatefulWidget {

  @override

  _cancelhotelhelpState createState() => _cancelhotelhelpState();
}

class _cancelhotelhelpState extends State<cancelhotelhelp> {


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
            'ศูนย์ช่วยเหลือที่พัก',
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
                    "ฉันจะยกเลิกและขอเงินคืนที่พักได้อย่างไร",
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
              //สอบถามเกี่ยวกับที่พัก
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child:
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:Text(
                        "ท่านสามารถยกเลิกและขอเงินคืนได้จากหน้ารายละเอียดการจองโดยจะมีปุ่มให้กดยกเลิกและระบบจะทำการติดต่อไปยังที่พักเพื่อทำการขอเงินคืน",
                        maxLines: null,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xff1D3557),
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ), ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }

}
