import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:se_app2/Home/Attraction/tourism_result.dart';
import 'package:se_app2/Home/Attraction/tourist_attraction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'blogpost/add_post_detail.dart';
class Blogdetail extends StatefulWidget {
  final detail;
  const Blogdetail({Key key,this.detail}) : super(key:key);

  @override
  State<Blogdetail> createState() => _BlogdetailState();
}
Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text(stars);
}


class _BlogdetailState extends State<Blogdetail> {
  bool viewVisible = false;
  int activeIndex = 0;
  var detail;
  Map author;

  Future getAuthor() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/blog/author/" + detail['authorId']));
    author = json.decode(res.body);
    setState(() {
      author = author;
    });
  }

  @override
  void initState() {
    super.initState();
    detail = widget.detail;
    getAuthor();
  }

  final urlImages = [
    'https://static.wikia.nocookie.net/narnia/images/9/91/Narniadawntreader.png/revision/latest?cb=20101128130243',
    'https://data.whicdn.com/images/177376242/original.gif',
    'http://1.bp.blogspot.com/-tIIfSD-zM8k/TxJ5zM0AY9I/AAAAAAAAAxA/WFbR4mkwOPw/s1600/jeremylove_narnia3_sealillies_01.jpg',
    'https://static.wikia.nocookie.net/narnia/images/b/ba/Narnia3-disneyscreencaps.com-10212.jpg/revision/latest?cb=20170401095930',
  ];
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
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DC),

      body: SingleChildScrollView(
        controller: _controller,
        child : Column(
          children: [
            //ทำให้ซ้อนกันได้
            Stack(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height),
                CarouselSlider.builder(
                  //itemCount: widget.data["image"].length,
                  itemCount: urlImages.length,
                  options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                      {setState(() => activeIndex = index)}),
                  itemBuilder: (context, index, realIndex) {
                    //final urlImage = widget.data["image"][index];
                    //return buildImage(urlImage, index);
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
                      onPressed: () => Navigator.of(context).pop(),
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
                                child: Column(
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                      Text(
                                        //"${widget.data['name']}",
                                        detail['topic'],
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff1D3557),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        //"${widget.data['name']}",
                                        detail['location'],
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff1D3557),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],),

                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_share),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30),*/
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Color(0xff1D3557),
                                    ),
                                    iconSize: 30,
                                    onPressed: () => {
                                      // setState(() => data.isFavorite = !data.isFavorite)
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () => {
                                      Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Addpostdetail()
                                      ))
                                      },
                                      icon: const Icon(Boxicons.bxs_edit_alt),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30),
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_trash),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30),
                                ],
                              )
                            ],
                          ),

                          /*Row(
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
                          ),*/
                          /*Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              //color: Color(0xffFFEEC9),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //locatio
                                //price
                                Row(
                                  children: [
                                    const Icon(Icons.monetization_on_outlined, color: Color(0xff1D3557), size: 20,),
                                    Text(
                                      ' ราคาเริ่มต้นที่ :',
                                      style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          //"${widget.data['price']}",
                                          "price",
                                          style: TextStyle(
                                              color: Color(0xff1D3557), fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //ended day open
                                SizedBox(height: 5,),
                                //day open
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined, color: Color(0xff1D3557), size: 20,),
                                    Text(
                                      ' วันเปิดทำการ :',
                                      style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          //"${widget.data['openday']}",
                                          "openday",
                                          style: TextStyle(
                                              color: Color(0xff1D3557), fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //ended day open
                                SizedBox(height: 5,),
                                //time
                                Row(
                                  children: [
                                    const Icon(Icons.timer, color: Color(0xff1D3557), size: 20,),
                                    Text(
                                      ' เวลาเปิดทำการ :',
                                      style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          //"${widget.data['time']}",
                                          "time",
                                          style: TextStyle(
                                              color: Color(0xff1D3557), fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //endedtime
                              ],
                            ),
                          ),*/
                          SizedBox(height: 20),
                          Container(
                            //margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'ไฮไลต์',
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
                                          //'${widget.data['desc']}',
                                          detail['desc'],
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
                          SizedBox(height: 10,),
                          //กล่องเพิ่มความเห็น
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            //width: 350,
                            height: 90,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFF4DC),
                                borderRadius: BorderRadius.circular(25),
                            ),
                            child : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     CircleAvatar(
                                      backgroundColor: Color(0xFFECFAFF),
                                      radius: 40,
                                      child: Text(
                                        '${author['realname'][0]}${author['surname'][0]}',
                                        style: TextStyle(
                                            fontSize: 35,
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
                                            'ผู้เขียน',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            '${author['realname']} ${author['surname']}',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '30 พฤษจิกายน พศ. 2564 เวลา 00:00 น. ',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //จบกล่องเพิ่มความเห็น
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Divider(color: Color(0xff827E7E), thickness: 1.5),
                              InkWell(
                                onTap: () {
                                  viewVisible ? hideWidget() : showWidget();
                                  if(viewVisible){
                                    _controller.animateTo(
                                        MediaQuery.of(context).size.height,
                                        curve: Curves.easeInOut,
                                        duration: const Duration(milliseconds: 500));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                          child: Text(
                                            'ความคิดเห็น',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff1D3557),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          viewVisible ? hideWidget() : showWidget();
                                          if(viewVisible){
                                            _controller.animateTo(
                                                MediaQuery.of(context).size.height,
                                                curve: Curves.easeInOut,
                                                duration: const Duration(milliseconds: 500));
                                          }
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
                              const Divider(color: Color(0xff827E7E), thickness: 1.5),
                              Container(
                                height: viewVisible ? 300 : 0,
                                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Color(0xffFFEEC9),
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child : MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView(
                                    children: [
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
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    const Icon(Icons.thumb_up_alt_outlined, color: Color(0xffFFF4DC), size: 20,),
                                                    SizedBox(width: 7,),
                                                    Text(
                                                        "325" ,
                                                        style: TextStyle(
                                                            color: Color(0xffFFF4DC), fontSize: 16)),
                                                    SizedBox(width: 7,),
                                                    const Icon(Icons.thumb_down_alt_outlined, color: Color(0xffFFF4DC), size: 20,),
                                                    SizedBox(width: 7,),
                                                    Text(
                                                        "325" ,
                                                        style: TextStyle(
                                                            color: Color(0xffFFF4DC), fontSize: 16)),
                                                  ],
                                                ),
                                                /*Text(
                                                    "fdfd" ,
                                                    style: TextStyle(
                                                        color: Color(0xffFFF4DC), fontSize: 16)),
                                                Text(
                                                    'price',
                                                    style: TextStyle(
                                                        color: Color(0xffFFF4DC), fontSize: 16)),*/
                                                _buildRatingStars(5),
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
                                    ],
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
  Widget buildImage(String urlImage, int index) => Container(
    color: Colors.black,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: /*widget.data["image"].length*/urlImages.length,
    effect: ScaleEffect(
        dotWidth: 8,
        dotHeight: 8,
        activeDotColor: const Color(0xffECFAFF),
        dotColor: const Color(0xffECFAFF).withOpacity(0.5)),
  );
}
