import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';

import 'billing_rentcar.dart';
import 'cancel_confirm.dart';

class rentCarDetail extends StatefulWidget {

  final detail;
  const rentCarDetail(
      {Key key,
      this.detail,
      })
      : super(key: key);

  @override
  _rentCarDetailState createState() => _rentCarDetailState();
}

class _rentCarDetailState extends State<rentCarDetail> {

  var detail;

  String type = 'rentcar';
  String id;
  String hotelName;

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

  List<String> devices = ['FM/AM Radio', 'Bluetooth', 'USB/AUX', 'CD/MP3'];

  bool viewVisible = false;

  String formatGetCar(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่รับรถ : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }
  String formatSentCar(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    var text = 'วันที่คืนรถ : ' + parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
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
                  itemCount: 1,
                  options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          {setState(() => activeIndex = index)}),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = detail['image'];
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
                                      detail["car_name"],
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ให้บริการโดย: " + detail["partnername"],
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
                                formatGetCar(detail['date_getcar']),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Text(
                                '(${detail['time_getcar']} น.)',
                                style: TextStyle(
                                  color: grayColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                formatSentCar(detail['date_sentcar']),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Text(
                                '(${detail['time_sentcar']} น.)',
                                style: TextStyle(
                                  color: grayColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 2,
                            thickness: 2,
                            color: grayColor,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'ข้อมูลรถ',
                                  style: TextStyle(
                                    color: grayColor,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ปีจดทะเบียน',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              'จำนวนที่นั่ง',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              'กระเป๋าใบใหญ่',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              'กระเป๋าใบเล็ก',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '2563',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              '4',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                            Text(
                                              '2',
                                              style: TextStyle(
                                                  color: grayColor, fontSize: 14),
                                            ),
                                          ],
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
                                  'อุปกรณ์ภายในรถ',
                                  style: TextStyle(
                                    color: grayColor,
                                    fontSize: 18,
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
                                      itemCount: devices.length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                      "• ${devices[index]}",
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

                          InkWell(
                            onTap: () {
                              setState(() {
                                viewVisible = !viewVisible;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                      child: Text(
                                        'จุดรับรถ - คืนรถ (จุดเดียวกัน)',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff1D3557),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        viewVisible = !viewVisible;
                                      });
                                    },
                                    iconSize: 35,
                                    padding: EdgeInsets.zero,
                                    splashRadius: 20,
                                    constraints: const BoxConstraints(),
                                    icon: viewVisible
                                        ? const Icon(Icons.keyboard_arrow_up_rounded)
                                        : const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Visibility(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => {
                                          print('nothing')
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: primaryColor,
                                          minimumSize: const Size(350, 60),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(16)),
                                          ),
                                        ),
                                        child:
                                        SizedBox(
                                          width: 310,
                                          child: Text(
                                            '${detail['detail_pricelocation']} (THB +${detail['sum_detail_pricelocation']})',
                                            style: TextStyle(
                                                color: Color(0xFFECFAFF), fontSize: 16),
                                          ),
                                        ),

                                      ),
                                      SizedBox(height: 10,),
                                    ]
                                ),
                              ],
                            ),
                            visible: viewVisible,
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
                                  'ราคา',
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "THB ${detail['total_price']}",
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
        count: 1,
        effect: ScaleEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: skyBlueColor,
            dotColor: skyBlueColor.withOpacity(0.5)),
      );
}
