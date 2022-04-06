import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Accommodation/accommodation_room.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/Widgets/notif_ok.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Comment/comment_add.dart';
import '../Comment/comment_item.dart';

class AccommodationDetail extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final detail;
  const AccommodationDetail(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.detail})
      : super(key: key);

  @override
  _AccommodationDetailState createState() => _AccommodationDetailState();
}

class _AccommodationDetailState extends State<AccommodationDetail> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var detail;

  String id;
  Map data;
  List accommodationRoomData;
  String hotelName;

  String type = 'hotel'; // IMPORTANT
  var commentBody;
  List commentData;
  bool commentsLoaded = false;
  TextEditingController commentController = TextEditingController();

  final _controller = ScrollController();

  Future getRoom() async {
    http.Response res =
        await http.get(Uri.parse("http://10.0.2.2:8080/hotel/" + id + '/room'));
    data = json.decode(res.body);
    accommodationRoomData = data['rooms']['room'];
    hotelName = data['rooms']['name'];
  }

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

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
      ("http://10.0.2.2:8080/comment/${widget.detail['_id']}/model/$type"),
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
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.detail['_id'];
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
    detail = widget.detail;
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
                                  detail['name'],
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
                          Row(
                            children: [
                              _buildRatingBar(numberToDouble(widget.detail['star'])),
                              SizedBox(width: 5,),
                              Text(
                                '(${formatStar(widget.detail['star'])})',
                                style: TextStyle(
                                  color: grayColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          detail['location'],
                                          style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '${detail['desc']}',
                                          style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          const Divider(color: Color(0xff827E7E), thickness: 1.5),
                          SizedBox(height: 10,),
                          commentAdd(detail: detail, type: type),
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
                                                modelid: widget.detail['_id'],
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

                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () async => {
                                await getRoom(),

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AccommodationRoom(
                                            checkInHolder: checkInEdit.text,
                                            checkOutHolder: checkOutEdit.text,
                                            numberOfPeopleHolder:
                                                numberOfPeopleEdit.text,
                                            numberOfRoomsHolder:
                                                numberOfRoomsEdit.text,
                                            rooms: accommodationRoomData,
                                            hotel_name: hotelName)))
                              },
                              style: ElevatedButton.styleFrom(
                                onPrimary: const Color(0xff1D3557),
                                primary: const Color(0xff1D3557),
                                minimumSize: const Size(350, 60),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                              child: const Text(
                                'จองห้องพัก',
                                style: TextStyle(
                                    color: Color(0xffFFF4DC), fontSize: 20),
                              ),
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
