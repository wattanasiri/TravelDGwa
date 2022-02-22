
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Rentcar_detail_car.dart';

class detailpartner extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data,partnerdata;
  var destination = new List();

  detailpartner({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.destination});
  @override
  _detailpartnerState createState() => _detailpartnerState();
}

class _detailpartnerState extends State<detailpartner> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    print('datapartner');
    print(widget.partnerdata);
    print(widget.partnerdata['foundpartner']['image']);
    print(widget.partnerdata['foundpartner']['image'].length);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height),
                Container(
                  color: Colors.white,
                  child: CarouselSlider.builder(
                    itemCount: widget.partnerdata['foundpartner']['image'].length,
                    options: CarouselOptions(
                        height: 400.0,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) =>
                        {setState(() => activeIndex = index)}),
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = widget.partnerdata['foundpartner']['image'][index];
                      return buildImage(urlImage, index);
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.black),
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                          cardetail(
                            dategetcar: widget.dategetcar,
                            timegetcar: widget.timegetcar,
                            datesentcar: widget.datesentcar,
                            timesentcar: widget.timesentcar,
                            yourlocation: widget.yourlocation,
                            data: widget.data,
                            destination: widget.destination,
                            partnerdata: widget.partnerdata,
                          ),)),
                    ),
                  ),
                ),
                Container(
                    height: 400,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: buildIndicator()),
                Container(
                  margin: const EdgeInsets.only(top: 380),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xffFFF4DC),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.partnerdata['foundpartner']['namepartner'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff1D3557),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.calendar_today_outlined, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'วันเปิดทำการ          :    ${ widget.partnerdata['foundpartner']['opening_day']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.share_arrival_time_outlined, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'เวลาเปิดทำการ       :    ${ widget.partnerdata['foundpartner']['opening_time']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius: BorderRadius.all(Radius.circular(15)
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'รับส่งรถนอกเวลาทำการ',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: widget.partnerdata['foundpartner']['time_extrapay'].length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.circle, color: const Color(0xff1D3557), size: 5),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                  child: Text(
                                                      '      ' + widget.partnerdata['foundpartner']['time_extrapay'][index] + ' :  + ' + widget.partnerdata['foundpartner']['price_extrapay'][index],
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: const Color(0xff1D3557),
                                                        fontSize: 14,
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius: BorderRadius.all(Radius.circular(15)
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'เอกสารประกอบการเช่า',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: widget.partnerdata['foundpartner']['document_require'].length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.circle, color: const Color(0xff1D3557), size: 5),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                  child: Text(
                                                      '      ' + widget.partnerdata['foundpartner']['document_require'][index],
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: const Color(0xff1D3557),
                                                        fontSize: 14,
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.phone_enabled_outlined , color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'เบอร์โทรศัพท์  :    ${ widget.partnerdata['foundpartner']['phone']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.email_outlined , color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'อีเมล  : ${ widget.partnerdata['foundpartner']['email']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
    color: Colors.white,
    height: double.infinity,
    width: double.infinity,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,

      alignment: Alignment.center,
    ),
  );

  // Widget buildImage(String urlImage, int index) =>CircleAvatar(radius: (1000),
  //     backgroundColor: Colors.white,
  //     child: ClipRRect(
  //       borderRadius:BorderRadius.circular(0),
  //       child: Image.network(
  //         urlImage,
  //         fit: BoxFit.cover,
  //       ),
  //     )
  // );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.partnerdata['foundpartner']['image'].length,
    effect: ScaleEffect(
        dotWidth: 8,
        dotHeight: 8,
        activeDotColor: const Color(0xffECFAFF),
        dotColor: const Color(0xffECFAFF).withOpacity(0.5)
    ),
  );
}

