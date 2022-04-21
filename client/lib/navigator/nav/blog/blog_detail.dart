import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/Home/Attraction/tourism_result.dart';
import 'package:se_app2/Home/Attraction/tourist_attraction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:se_app2/Home/Comment/comment_add.dart';
import 'package:se_app2/Home/Comment/comment_item.dart';

import 'blogpost/add_post_detail.dart';
class Blogdetail extends StatefulWidget {
  final detail;
  bool userFavourited;
  final Function favFunction;
  var resultIndex;
  Blogdetail({
    Key key,this.detail,
    this.userFavourited,
    this.favFunction,
    @required this.resultIndex,
  }) : super(key:key);

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
  var type = 'blog'; // IMPORTANT
  bool viewVisible = false;
  int activeIndex = 0;
  var detail;
  Map author;

  var commentBody;
  List commentData;

  bool commentsLoaded = false;

  bool userFavourited = false;

  TextEditingController commentController = TextEditingController();

  Future getAuthor() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/blog/author/" + widget.detail['authorId']));
    author = json.decode(res.body);
    setState(() {
      author = author;
    });
  }

  // use this while delete comment
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

  final _controller = ScrollController();

  Future actionFavourite() async {

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
    };

    http.Response res = await http.post(
      Uri.parse("http://10.0.2.2:8080/blog/${widget.detail['_id']}/favourite"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      if (widget.resultIndex != -1) {
        widget.favFunction(widget.resultIndex);
      }
      setState(() {
        userFavourited = !userFavourited;
      });
    }
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
      print(commentData);
    }

  }
  // ---------------

  @override
  void initState() {
    super.initState();
    detail = widget.detail;
    getAuthor();
    userFavourited = widget.userFavourited;
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
                                  GestureDetector(
                                    onTap: () => {
                                      actionFavourite(),
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: userFavourited ?
                                        Icon(Icons.favorite_outlined, color: pinkColor, size: 30,) :
                                        Icon(Icons.favorite_border_rounded, color: Color(0xff1D3557), size: 30,)
                                    ),
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
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '${author['realname']} ${author['surname']}',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '30 พฤษจิกายน พศ. 2564 เวลา 00:00 น. ',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 12,
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
                              //กล่องเพิ่มความเห็น
                              SizedBox(height: 10,),
                              commentAdd(detail: widget.detail, type: type),
                              SizedBox(height: 10,),
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
                                  SizedBox(height: 10,),
                                  const Divider(color: Color(0xff827E7E), thickness: 1.5),
                                  SizedBox(height: 10,),
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
                              )
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
