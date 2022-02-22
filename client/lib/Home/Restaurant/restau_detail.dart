import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Restaudetail extends StatefulWidget {
  @override
  _RestaudetailState createState() => _RestaudetailState();
}
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





class _RestaudetailState extends State<Restaudetail> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DC),

      body: SingleChildScrollView(
        child : Column(
          children: [
            //ทำให้ซ้อนกันได้
            Stack(
              children: [
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
                //จุดเลื่อนภาพ
                Container(
                    height: 400,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: buildIndicator()),
                //จุดเลื่อนภาพ
                //กล่องด้านล่าง
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  "detail['name']",
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
                          _buildRatingStars(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff1D3557),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                    children: const <Widget>[
                                      Icon(Icons.map_rounded,
                                          color: Color(0xffFF9A62)),
                                      SizedBox(width: 10),
                                      Text(
                                        'เส้นทาง',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.favorite_border_rounded,
                                  color: Color(0xff1D3557),
                                ),
                                iconSize: 30,
                                onPressed: () => {
                                  // setState(() => data.isFavorite = !data.isFavorite)
                                },
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'ตำแหน่งที่ตั้ง',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          "detail['location']",
                                          style: TextStyle(
                                              color: Color(0xff1D3557), fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'รายละเอียดที่พัก',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          'detail['"desc"']45d6fgfdgggdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdggrsdfgggddd'
                                              'wertggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggddddddddddd',
                                          style: TextStyle(
                                              color: Color(0xff1D3557), fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Divider(color: Color(0xff827E7E), thickness: 1.5),
                              InkWell(
                                onTap: () => {viewVisible ? hideWidget() : showWidget()},
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                          child: Text(
                                            'ดูรีวิว'.toString(),
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff1D3557),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                            {viewVisible ? hideWidget() : showWidget()},
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

                                    ],
                                  ),
                                ),
                              ),
                              const Divider(color: Color(0xff827E7E), thickness: 1.5),
                              Visibility(
                                visible: viewVisible,
                                child: Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffFFEEC9),
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child : Container(
                                    child: Column(
                                      children: [
                                        /*Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                "fdfd" ,
                                                style: TextStyle(
                                                    color: Color(0xff1D3557), fontSize: 16)),
                                            Text(
                                                'price',
                                                style: TextStyle(
                                                    color: Color(0xff1D3557), fontSize: 16))
                                          ],
                                        ),*/
                                        //กล่องรีวิว
                                        Container(
                                          //height: 300,
                                          child: Column(
                                            children: [
                                              SingleChildScrollView(
                                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                child : Column(
                                                  children: [
                                                    //กล่องรีวิว1
                                                    Container(
                                                      margin: EdgeInsets.symmetric(vertical: 10),
                                                      padding: EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff1D3557),
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 6,
                                                            offset: const Offset(1, 6),
                                                          ),
                                                        ],
                                                      ),
                                                      child : Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const CircleAvatar(
                                                                backgroundColor: Color(0xFFECFAFF),
                                                                radius: 25,
                                                                child: Text(
                                                                  "SC",
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: Color(0xFF1d3557)
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Flexible(
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      'Sedtawut Chalothronnarumit',
                                                                      style: TextStyle(
                                                                        color: Color(0xffFFF4DC),
                                                                        fontSize: 16,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '29 พฤศจิกายน พ.ศ. 2564, เวลา 12.10 น.',
                                                                      style: TextStyle(
                                                                        color: Color(0xffFFF4DC),
                                                                        fontSize: 10,
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5),
                                                                    Text(
                                                                      'อาหารอร่อยสดใหม่มาก',
                                                                      style: TextStyle(
                                                                        color: Color(0xffFFF4DC),
                                                                        fontSize: 14,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  IconButton(
                                                                    onPressed: () =>
                                                                    {viewVisible ? hideWidget() : showWidget()},
                                                                    iconSize: 35,
                                                                    padding: EdgeInsets.zero,
                                                                    splashRadius: 20,
                                                                    constraints: const BoxConstraints(),
                                                                    icon: viewVisible
                                                                        ? const Icon(Icons.keyboard_arrow_up_rounded,
                                                                      color : Color(0xffFFF4DC),)
                                                                        : const Icon(
                                                                        Icons.keyboard_arrow_down_rounded),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                  "fdfd" ,
                                                                  style: TextStyle(
                                                                      color: Color(0xffFFF4DC), fontSize: 16)),
                                                              Text(
                                                                  'price',
                                                                  style: TextStyle(
                                                                      color: Color(0xffFFF4DC), fontSize: 16))
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                    //จบกล่องรีวิว1
                                                    //กล่องรีวิว2
                                                    Container(
                                                      margin: EdgeInsets.symmetric(vertical: 10),
                                                      padding: EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff1D3557),
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const CircleAvatar(
                                                            backgroundColor: Color(0xFFECFAFF),
                                                            radius: 25,
                                                            child: Text(
                                                              "SC",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Color(0xFF1d3557)
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Flexible(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'อพาร์ทเม้น',
                                                                  style: TextStyle(
                                                                    color: Color(0xffECFAFF),
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'ที่อยู่อาศัยตกแต่งในอาคารอพาร์ตเมนต์ที่มีห้องพักส่วนตัวพร้อม บริการเหมือนโรงแรม',
                                                                  style: TextStyle(
                                                                    color: Color(0xffECFAFF),
                                                                    fontSize: 14,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //จบรีวิวกล่อง2
                                                    //กล่องรีวิว3
                                                    Container(
                                                      margin: EdgeInsets.symmetric(vertical: 10),
                                                      padding: EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff1D3557),
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const CircleAvatar(
                                                            backgroundColor: Color(0xFFECFAFF),
                                                            radius: 25,
                                                            child: Text(
                                                              "SC",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Color(0xFF1d3557)
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Flexible(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'อพาร์ทเม้น',
                                                                  style: TextStyle(
                                                                    color: Color(0xffECFAFF),
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'ที่อยู่อาศัยตกแต่งในอาคารอพาร์ตเมนต์ที่มีห้องพักส่วนตัวพร้อม บริการเหมือนโรงแรม',
                                                                  style: TextStyle(
                                                                    color: Color(0xffECFAFF),
                                                                    fontSize: 14,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //จบรีวิวกล่อง3
                                                  ],
                                                ),

                                        ),
                                              //จบกล่องรีวิว
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //กล่องด้านล่าง
              ],
            ),
          ],
        ),
      ),
    );
  }
  void navigatePop() => {setState(() {}), Navigator.of(context).pop()};
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

