import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/eachcard.dart';
import 'package:se_app2/navigator/nav/profile/creditcard/newcard.dart';

import '../profile.dart';

class maincreditcard extends StatefulWidget {
  @override
  _maincreditcardState createState() => _maincreditcardState();
}

class _maincreditcardState extends State<maincreditcard> {
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
            'บัตรที่บันทึกไว้',
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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => eachcard())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: const [
                          Icon(Boxicons.bxl_visa, color: Color(0xff1D3557), size: 40,),
                          SizedBox(width: 20),
                          Text("เสฎฐวุฒิ ชโลธรนฤมิต", style: TextStyle(fontSize: 16, color: Color(0xff1D3557)),),
                        ],
                      ),
                    ),
                    Text(
                      'บัตรหลัก',
                      style: TextStyle(
                        color: Color(0xff1D3557),
                        fontSize: 18,
                      )
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'เพิ่มบัตรใหม่',
                  style: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 18,
                  ),
                ),
              ],
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => newcard())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: const [
                          Icon(Icons.credit_card_rounded, color: Color(0xff1D3557), size: 40,),
                          SizedBox(width: 20),
                          Text("บัตรเครดิต / บัตรเดบิต", style: TextStyle(fontSize: 16, color: Color(0xff1D3557)),),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557), size: 30,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
