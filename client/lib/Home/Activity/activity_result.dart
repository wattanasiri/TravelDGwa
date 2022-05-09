import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Activity/activity_result_reserve.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:convert';

import 'activity.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/Widgets/notif_ok.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Comment/comment_add.dart';
import '../Comment/comment_item.dart';

class activity_result extends StatefulWidget {
  // const activity_result({Key key}) : super(key: key);
  String name,time,day;
  int sum_price;
  Map data;
  activity_result({this.name,
    // this.time,
    // this.day,
    this.data});
  @override
  _activity_resultState createState() => _activity_resultState();

}

class _activity_resultState extends State<activity_result> {

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    print('data destination');
    print(widget.data['foundAcc']);
    print(widget.data['foundAcc']['name']);
    print(widget.data['foundAcc']['image'][0]);
  }

  String word = '';
  // var dayActivity,timeActivity;

  String type = 'activity'; // IMPORTANT
  var commentBody;
  List commentData;
  bool commentsLoaded = false;
  double currentRating = 3;

  final _controller = ScrollController();

  Map data;
  List recdata;

  final day = TextEditingController();
  final time = TextEditingController();
  final number = TextEditingController();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode1 = FocusNode();
  FocusNode acFocusNode2 = FocusNode();

  int activeIndex = 0;

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

  Future getrec() async {
    print("1");
    http.Response res =
    await http.get(Uri.parse("$SERVER_URL/activity/" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    recdata = data['foundactivity'];
    print("this");
    print(recdata);
  }

  Future next() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        activity_reserve(
          dayActivity: day.text,
          timeActivity: time.text,
          data: widget.data,
          number: number.text,
          sum_price: widget.data['foundAcc']['price'] * int.parse(number.text),
          // partnerdata: widget.partnerdata,
          // pricedestination : value_destination,
          // namedestination : value_namedestination,
          // result_price_extra: result_price_extra,
          // result_price_extra_: result_price_extra_,
          // result_date_time : result_date_time,
          // checkpriceextra: checkpriceextra,

        ),));
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
      ("$SERVER_URL/comment/${widget.data['foundAcc']['_id']}/model/$type"),
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          controller: _controller,
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                  Stack(
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height),
                        CarouselSlider.builder(
                          itemCount: widget.data['foundAcc']['image'].length,
                          options: CarouselOptions(
                              height: 400.0,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) =>
                              {setState(() => activeIndex = index)}),
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = widget.data['foundAcc']['image'][index];
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
                                onPressed: () async => {
                                  await getrec(),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => activity(
                                            result : recdata,
                                          )
                                      )
                                  ),}

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
                                    widget.data['foundAcc']['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff1D3557),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      _buildRatingBar(numberToDouble(widget.data['foundAcc']['star'])),
                                      SizedBox(width: 5,),
                                      Text(
                                        '(${formatStar(widget.data['foundAcc']['star'])})',
                                        style: TextStyle(
                                          color: grayColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   alignment: Alignment.topLeft,
                                  //   height: 30,
                                  //   color: Colors.transparent,
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 15, vertical: 5),
                                  //   child: _buildRatingStars(widget.data['foundAcc']['star']),
                                  // ),
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
                                                    Icon(Icons.app_registration, color: Color(0xff1D3557)),
                                                    const SizedBox(width: 15),
                                                    Flexible(
                                                      child: Text(
                                                        'ราคา  :  ${ widget.data['foundAcc']['price']}  บาท',
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
                                                    Icon(Icons.calendar_today_outlined, color: Color(0xff1D3557)),
                                                    const SizedBox(width: 15),
                                                    Flexible(
                                                      child: Text(
                                                        'วันเปิดทำการ  :  ${ widget.data['foundAcc']['open_day']}',
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
                                                    Icon(Icons.schedule_outlined, color: Color(0xff1D3557)),
                                                    const SizedBox(width: 15),
                                                    Flexible(
                                                      child: Text(
                                                        'เวลาทำการ  :  ${ widget.data['foundAcc']['open_time']}',
                                                        style: const TextStyle(
                                                          color: Color(0xff1D3557),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              //   child: Row(
                                              //     crossAxisAlignment: CrossAxisAlignment.start,
                                              //     children: <Widget>[
                                              //       Icon(Icons.shopping_bag_sharp, color: Color(0xffFF9A62)),
                                              //       const SizedBox(width: 15),
                                              //       Flexible(
                                              //         child: Text(
                                              //           'กระเป๋าเล็ก        :     ${ widget.data['foundCar']['car_nunber_smallbag']}',
                                              //           style: const TextStyle(
                                              //             color: Color(0xff1D3557),
                                              //             fontSize: 14,
                                              //           ),
                                              //         ),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

                                              const Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'สิ่งอำนวยความสะดวก',
                                                  style: TextStyle(
                                                    color: Color(0xff1D3557),
                                                    fontSize: 16,
                                                  ),
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
                                                    itemCount: widget.data['foundAcc']['service'].length,
                                                    itemBuilder: (context, int index) =>
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const Icon(Icons.circle, color: const Color(0xff1D3557), size: 5),
                                                            const SizedBox(width: 8),
                                                            Flexible(
                                                                child: Text(
                                                                    widget.data['foundAcc']['service'][index],
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    softWrap: true,
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
                                              const Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'ไฮไลต์',
                                                  style: TextStyle(
                                                    color: Color(0xff1D3557),
                                                    fontSize: 16,
                                                  ),
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
                                                    itemCount: widget.data['foundAcc']['hilight'].length,
                                                    itemBuilder: (context, int index) =>
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top :9.0),
                                                              child: const Icon(Icons.circle,
                                                                color: const Color(0xff1D3557),
                                                                size: 5,),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            Flexible(
                                                                child: Text(
                                                                    widget.data['foundAcc']['hilight'][index],
                                                                    // maxLines: 2,
                                                                    // overflow: TextOverflow.ellipsis,
                                                                    // softWrap: true,
                                                                    // textWidthBasis: TextWidthBasis.longestLine,
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
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10,),
                                  const Divider(color: Color(0xff827E7E), thickness: 1.5),
                                  SizedBox(height: 10,),
                                  commentAdd(detail: widget.data['foundAcc'], type: type),
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
                                                        modelid: widget.data['foundAcc']['_id'],
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

                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'เลือกวันและเวลาการจอง',
                                      style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("วันที่เข้าร่วม",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Color(0xff1D3557))),
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 2),
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffECFAFF),
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: const Color(0xff1D3557), width: 2)),
                                              child: TextFormField(
                                                controller: day,
                                                readOnly: true,
                                                decoration: const InputDecoration(
                                                    hintText: 'วว-ดด-ปปปป',
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: Color(0xffECFAFF))),
                                                    suffixIcon: Icon(Ionicons.calendar_outline,
                                                        color: Color(0xff1D3557))),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'กรุณาระบุวันที่';
                                                  }
                                                  return null;
                                                },
                                                focusNode: acFocusNode1,
                                                onTap: () async {
                                                  DateTime pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101));

                                                  if (pickedDate != null) {
                                                    print(pickedDate);
                                                    String formattedDate =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(pickedDate);
                                                    print(formattedDate);

                                                    setState(() {
                                                      day.text = formattedDate;
                                                    });
                                                  } else {
                                                    print("Date is not selected");
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("เวลาที่เข้าร่วม",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Color(0xff1D3557))),
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 2),
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffECFAFF),
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: const Color(0xff1D3557), width: 2)),
                                              child: TextFormField(
                                                controller: time,
                                                readOnly: true,
                                                decoration: const InputDecoration(
                                                    hintText: '00:00',
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: Color(0xffECFAFF))),
                                                    suffixIcon: Icon(Icons.schedule_outlined,
                                                        color: Color(0xff1D3557))),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'กรุณาระบุวันที่';
                                                  }
                                                  return null;
                                                },
                                                focusNode: acFocusNode2,
                                                onTap: () async {
                                                  TimeOfDay pickedTime =  await showTimePicker(
                                                    initialTime: TimeOfDay.now(),
                                                    context: context,
                                                  );
                                                  FocusScope.of(context)
                                                      .requestFocus(FocusNode());

                                                  if(pickedTime != null ){
                                                    DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                    String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                    time.text = formattedTime.toString();

                                                  }else{
                                                    print("Time is not selected");
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("เลือกจำนวนคนทีเข้าร่วม",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1D3557))),
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 2),
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffECFAFF),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: const Color(0xff1D3557), width: 2)),
                                    child: TextFormField(
                                      controller: number,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'เลือกจำนวน ',
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Color(0xffECFAFF))),
                                        // suffixIcon:
                                        // Icon(Icons.search, color: Color(0xff1D3557))
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty || value == 0) {
                                          return 'กรุณาระบุจำนวน';
                                        }
                                        return null;
                                      },
                                      focusNode: acFocusNode,
                                      onChanged: (value) {
                                        word = value;
                                      },
                                    ),
                                  ),

                                  SizedBox(height: 30,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () async=> {
                                        // activity_partner(),
                                        // update_activity()
                                        // queryactivity(),
                                        next()
                                      },
                                      style: ElevatedButton.styleFrom(
                                        onPrimary: const Color(0xff1D3557),
                                        primary: const Color(0xff1D3557),
                                        minimumSize: const Size(350, 50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                        ),
                                      ),
                                      child: const Text(
                                        'จองกิจกรรม',
                                        style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]
                  ),
                ]
            ),
          ),
        )
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
    count: widget.data['foundAcc']['image'].length,
    effect: ScaleEffect(
        dotWidth: 8,
        dotHeight: 8,
        activeDotColor: const Color(0xffECFAFF),
        dotColor: const Color(0xffECFAFF).withOpacity(0.5)
    ),
  );

}