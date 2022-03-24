import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Rentcar_detail_car.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/Widgets/notif_ok.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Comment/comment_add.dart';
import '../Comment/comment_item.dart';

class detailpartner extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data,partnerdata;
  var destination = [];

  detailpartner({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.destination});
  @override
  _detailpartnerState createState() => _detailpartnerState();
}

class _detailpartnerState extends State<detailpartner> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  int activeIndex = 0;

  String type = 'rentcarpartner'; // IMPORTANT
  var commentBody;
  List commentData;
  bool commentsLoaded = false;
  double currentRating = 3;

  final _controller = ScrollController();

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

  void removeDataInList(String id) {
    print(commentData);
    print(id);
    setState(() {
      commentData.removeWhere((value) => value["id"] == id);
    });
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

  Future loadComment() async {
    // ---------------
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');


    http.Response res = await http.get(Uri.parse
      ("http://10.0.2.2:8080/comment/${widget.partnerdata['foundpartner']['_id']}/model/$type"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      commentBody = json.decode(res.body);
      setState(() {
        commentData = commentBody['comment'];
        commentsLoaded = true;
      });
      print(commentData);
    }

  }

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
        controller: _controller,
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
                          Row(
                            children: [
                              _buildRatingBar(numberToDouble(widget.partnerdata['foundpartner']['star'])),
                              SizedBox(width: 5,),
                              Text(
                                '(${formatStar(widget.partnerdata['foundpartner']['star'])})',
                                style: TextStyle(
                                  color: grayColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
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
                                const Text(
                                  '* ค่าบริการนอกเวลาทำการจะมีการเก็บตอนที่ท่านมารับรถ',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 13,
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
                          SizedBox(height: 10,),
                          const Divider(color: Color(0xff827E7E), thickness: 1.5),
                          SizedBox(height: 10,),
                          commentAdd(detail: widget.partnerdata['foundpartner'], type: type),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Divider(color: Color(0xff827E7E), thickness: 1.5),
                              InkWell(
                                onTap: () {
                                  viewVisible ? hideWidget() : showWidget();
                                  if (!commentsLoaded) loadComment();
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
                                            'ดูรีวิว',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff1D3557),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          viewVisible ? hideWidget() : showWidget();
                                          if (!commentsLoaded) loadComment();
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

                              // กล่องคอมเมนต์
                              if (commentsLoaded)
                                SingleChildScrollView(
                                    child: Container(
                                      height: viewVisible ? 600 : 0,
                                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Color(0xffFFEEC9),
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child : MediaQuery.removePadding(
                                        removeTop: true,
                                        context: context,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const BouncingScrollPhysics(),
                                            itemCount: commentData == null ? 0 : commentData.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return commentItem(
                                                modelid: widget.partnerdata['foundpartner']['_id'],
                                                detail: commentData[index],
                                                id: commentData[index]['id'],
                                                like: commentData[index]['like'],
                                                dislike: commentData[index]['dislike'],
                                                userLiked: commentData[index]['userLiked'],
                                                userDisliked: commentData[index]['userDisliked'],
                                                belongToUser: commentData[index]['belongToUser'],
                                                removeItemFunction: removeDataInList,
                                              );
                                            }),
                                      ),
                                    )
                                )
                              else
                                Container(
                                  height: viewVisible ? 100 : 0,
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              ,
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
    color: Colors.white,
    height: double.infinity,
    width: double.infinity,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,

      alignment: Alignment.center,
    ),
  );

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

