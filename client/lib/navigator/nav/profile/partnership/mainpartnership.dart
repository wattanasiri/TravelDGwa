import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/booking/booking.dart';

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
    return Scaffold(
      backgroundColor : const Color(0xFFFFF4DC),
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
            'สมัครพาร์ทเนอร์',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Color(0xff1D3557),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
                      ),
                      child: const Center(
                        child: Text(
                          'ที่พัก',
                          style: TextStyle(
                            color: Color(0xffECFAFF),
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                        decoration: const BoxDecoration(
                            color: Color(0xff1D3557),
                        ),
                        child: const Center(
                          child: Text(
                            'เช่ารถ',
                            style: TextStyle(
                                color: Color(0xffECFAFF),
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                        decoration: const BoxDecoration(
                            color: Color(0xff1D3557),
                        ),
                        child: const Center(
                          child: Text(
                            'รถรับส่ง',
                            style: TextStyle(
                                color: Color(0xffECFAFF),
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                        decoration: const BoxDecoration(
                            color: Color(0xff1D3557),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))
                        ),
                        child: const Center(
                          child: Text(
                            'กิจกรรม',
                            style: TextStyle(
                                color: Color(0xffECFAFF),
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.home_rounded, size: 50, color: Color(0xff1D3557)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'อพาร์ทเม้น',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'ที่อยู่อาศัยตกแต่งในอาคารอพาร์ตเมนต์ที่มีห้องพักส่วนตัวพร้อม บริการเหมือนโรงแรม',
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.home_rounded, size: 50, color: Color(0xff1D3557)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.home_rounded, size: 50, color: Color(0xff1D3557)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.home_rounded, size: 50, color: Color(0xff1D3557)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
