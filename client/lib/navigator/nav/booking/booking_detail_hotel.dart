import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'booking_item.dart';

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
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var detail;

  String id;
  Map data;
  String hotelName;

  // Future getRoom() async {
  //   http.Response res =
  //       await http.get(Uri.parse("http://10.0.2.2:8080/hotel/" + id + '/room'));
  //   data = json.decode(res.body);
  //   hotelName = data['rooms']['name'];
  // }

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

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

  @override
  void initState() {
    super.initState();
    // id = widget.detail['_id'];
    // detail = widget.detail;
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
                          color: Color(0xffECFAFF)),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'NAME',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff1D3557),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_phone),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30),
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_chat),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30)
                                ],
                              )
                            ],
                          ),
                          _buildRatingStars(5),
                          SizedBox(height: 5,),
                          Row(
                            children: const [
                              Text(
                                'วันที่เช็คอิน : 29 ธันวาคม พ.ศ. 2564',
                                style: TextStyle(
                                  color: Color(0xff1D3557),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Text(
                                '(14.00 น.)',
                                style: TextStyle(
                                  color: Color(0xff827E7E),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                'วันที่เช็คเอาท์ : 1 มกราคม พ.ศ. 2565',
                                style: TextStyle(
                                  color: Color(0xff1D3557),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Text(
                                '(12.00 น.)',
                                style: TextStyle(
                                  color: Color(0xff827E7E),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 2,
                            thickness: 2,
                            color: Color(0xff827E7E),
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
                                    color: Color(0xff827E7E),
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Color(0xff827E7E),
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '26.0 ตร.ม',
                                          style: TextStyle(
                                              color: Color(0xff827E7E), fontSize: 14),
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
                                            color: Color(0xff827E7E),
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 ผู้เข้าพัก (เข้าพักสูงสุดได้ 2 คน)',
                                          style: TextStyle(
                                              color: Color(0xff827E7E), fontSize: 14),
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
                                            color: Color(0xff827E7E),
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 เตียงเดี่ยว หรือ 1 เตียงใหญ่',
                                          style: TextStyle(
                                              color: Color(0xff827E7E), fontSize: 14),
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
                                            color: Color(0xff827E7E),
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          '2 โซฟา',
                                          style: TextStyle(
                                              color: Color(0xff827E7E), fontSize: 14),
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
                                            color: Color(0xff827E7E),
                                            size: 20),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                        child: Text(
                                          'ห้ามสูบบุหรี่',
                                          style: TextStyle(
                                              color: Color(0xff827E7E), fontSize: 14),
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
                                    color: Color(0xff827E7E),
                                    fontSize: 16,
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• เครื่องปรับอากาศ',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• เครื่องปรับอากาศ',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• เครื่องปรับอากาศ',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• เครื่องปรับอากาศ',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
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
                                  'สิ่งอำนวยความสะดวกภายในห้องน้ำ',
                                  style: TextStyle(
                                    color: Color(0xff827E7E),
                                    fontSize: 16,
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• น้ำอุ่น',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      child: Text(
                                        '• ฝักบัว',
                                        style: TextStyle(
                                            color: Color(0xff827E7E), fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const Divider(
                            height: 2,
                            thickness: 2,
                            color: Color(0xff827E7E),
                          ),

                          const SizedBox(height: 10,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Flexible(
                                child: Text(
                                  'ทั้งหมด',
                                  style: TextStyle(
                                      color: Color(0xff1D3557), fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                'THB 3,300',
                                style: TextStyle(
                                    color: Color(0xff1D3557), fontSize: 20, fontWeight: FontWeight.bold),
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
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: const Color(0xff1D3557),
                                    primary: const Color(0xff1D3557),
                                    minimumSize: Size(size.width * 0.4, 50),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                    ),
                                  ),
                                  child: const Text(
                                    'ดูใบเสร็จการชำระ',
                                    style: TextStyle(
                                        color: Color(0xffFFF4DC), fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05,),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () async => {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: const Color(0xffF25B52),
                                    primary: const Color(0xffF25B52),
                                    minimumSize: Size(size.width * 0.4, 50),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                    ),
                                  ),
                                  child: const Text(
                                    'ยกเลิกการจอง',
                                    style: TextStyle(
                                        color: Color(0xffECFAFF), fontSize: 18),
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
            activeDotColor: const Color(0xffECFAFF),
            dotColor: const Color(0xffECFAFF).withOpacity(0.5)),
      );
}
