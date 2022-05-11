import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';

import 'billing_hotel.dart';
import 'cancel_confirm.dart';

class hotelDetail extends StatefulWidget {

  final detail;
  const hotelDetail(
      {Key key,
      this.detail,
      })
      : super(key: key);

  @override
  _hotelDetailState createState() => _hotelDetailState();
}

class _hotelDetailState extends State<hotelDetail> {

  var detail;

  String type = 'hotel';
  String id;
  String hotelName;

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

  List<String> facilitiesInRoom = ['เครื่องปรับอากาศ', 'โทรทัศน์', 'ตู้เย็น', 'ไมโครเวฟ', 'อินเทอร์เน็ต WIFI'];
  List<String> facilitiesInBathRoom = ['น้ำอุ่น', 'ห้องน้ำส่วนตัว', 'อุปกรณ์อาบน้ำ'];

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  String formatPricing(var price) {
    var text = 'THB ' + formatPrice(price);
    return text;
  }

  String formatCheckIn(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่เช็คอิน : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }
  String formatCheckOut(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่เช็คเอาท์ : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }

  RatingBarIndicator _buildRatingBar(double rating){
    return RatingBarIndicator(
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 0.7),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 20.0,
    );
  }

  @override
  void initState() {
    super.initState();
    id = widget.detail['_id'];
    detail = widget.detail;

    print(detail);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height),
                CarouselSlider.builder(
                  itemCount: urlImages.length,
                  options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          {setState(() => activeIndex = index)}),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  },
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
                          color: boxColor),
                      onPressed: () => Navigator.pop(context),
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
                      color: secondaryColor,
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail["acc_name"],
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ห้อง " + detail["room"],
                                      style: GoogleFonts.poppins(
                                        color: primaryColor,
                                        fontSize: 16,),
                                    ),
                                  ]
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_phone),
                                      color: primaryColor,
                                      iconSize: 30),
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_chat),
                                      color: primaryColor,
                                      iconSize: 30)
                                ],
                              )
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     _buildRatingBar(numberToDouble(detail['star'])),
                          //     SizedBox(width: 5,),
                          //     Text(
                          //       '(${formatStar(detail['star'])})',
                          //       style: TextStyle(
                          //         color: grayColor,
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                formatCheckIn(detail['checkIn']),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                              // Text(
                              //   '(XX.XX น.)',
                              //   style: TextStyle(
                              //     color: grayColor,
                              //     fontSize: 13,
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                formatCheckOut(detail['checkOut']),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 2,
                            thickness: 2,
                            color: grayColor,
                          ),
                          const SizedBox(height: 5,),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'รายละเอียดที่พัก',
                                  style: TextStyle(
                                    color: grayColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: grayColor,
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '26.0 ตร.ม',
                                          style: TextStyle(
                                              color: grayColor, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.people,
                                            color: grayColor,
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 ผู้เข้าพัก (เข้าพักสูงสุดได้ 2 คน)',
                                          style: TextStyle(
                                              color: grayColor, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.bed,
                                            color: grayColor,
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 เตียงเดี่ยว หรือ 1 เตียงใหญ่',
                                          style: TextStyle(
                                              color: grayColor, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.event_seat_rounded,
                                            color: grayColor,
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 โซฟา',
                                          style: TextStyle(
                                              color: grayColor, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.smoke_free,
                                            color: grayColor,
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          'ห้ามสูบบุหรี่',
                                          style: TextStyle(
                                              color: grayColor, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'สิ่งอำนวยความสะดวกภายในห้อง',
                                  style: TextStyle(
                                    color: grayColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: facilitiesInRoom.length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                      "• ${facilitiesInRoom[index]}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: grayColor,
                                                        fontSize: 14,
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'สิ่งอำนวยความสะดวกภายในห้องน้ำ',
                                  style: TextStyle(
                                    color: grayColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: facilitiesInBathRoom.length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                      "• ${facilitiesInBathRoom[index]}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: grayColor,
                                                        fontSize: 14,
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          const Divider(
                            height: 2,
                            thickness: 2,
                            color: grayColor,
                          ),

                          const SizedBox(height: 10,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'ทั้งหมด',
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                formatPricing(detail['totalPrice']),
                                style: TextStyle(
                                    color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () async => {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return hotelBilling(
                                          detail: detail,
                                        );
                                      },
                                    ),
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: primaryColor,
                                    primary: primaryColor,
                                    minimumSize: Size(size.width * 0.4, 50),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                    ),
                                  ),
                                  child: const Text(
                                    'ดูใบเสร็จการชำระ',
                                    style: TextStyle(
                                        color: secondaryColor, fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05,),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () async => {
                                    if (detail['canceled'] == false && detail['status'] == 'soon') showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return confirmCancelBox(
                                          detail: detail,
                                          type: type
                                        );
                                      },
                                    ),
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                    detail['canceled'] ? grayColor :
                                    detail['status'] == 'completed' ? grayColor : redOrangeColor,
                                    minimumSize: Size(size.width * 0.4, 50),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                    ),
                                  ),
                                  child: Text(
                                    detail['canceled'] ? 'การจองถูกยกเลิก' :
                                    detail['status'] == 'completed' ? 'การจองเสร็จสิ้น' : 'ยกเลิกการจอง',
                                    style: TextStyle(
                                        color: boxColor, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
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
        color: Colors.black,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: ScaleEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: skyBlueColor,
            dotColor: skyBlueColor.withOpacity(0.5)),
      );
}
