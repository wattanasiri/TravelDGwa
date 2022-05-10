import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:se_app2/Widgets/notif_ok.dart';

import 'package:se_app2/Home/Accommodation/accommodation_detail.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:se_app2/Home/Restaurant/restau_detail.dart';
import 'package:se_app2/navigator/nav/blog/blog_detail.dart';
import '../profile.dart';

class mainfavourite extends StatefulWidget {
  @override
  _mainfavouriteState createState() => _mainfavouriteState();
}

class _mainfavouriteState extends State<mainfavourite> {
  bool done = false;
  List list1 = ['sub', 'sub2'];

  RatingBarIndicator _buildRatingBar(double rating){
    return RatingBarIndicator(
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 0.2),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 18.0,
    );
  }
  var data;
  var hotelData;
  var attractionData;
  var restaurantData;
  var blogData;

  Future getFavData() async {

    // ---------------
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(Uri.parse("$SERVER_URL/favourite"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
      onTimeout: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return notifBox(
              title: 'Error',
              text: 'Request timeout.',
              fontSize: 14.0,
            );
          },
        );
        return http.Response('Error', 408);
      },)
    ;

    if (res.statusCode == 200) {
      data = json.decode(res.body);
      print(data['hotelList']);
      setState(() {
        hotelData = data['hotelList'];
        attractionData = data['attractionList'];
        restaurantData = data['restaurantList'];
        blogData = data['blogList'];
        done = true;
      });
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
      setState((){
      });
    }
  }

  Future getAccommodation(id) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(
      Uri.parse("$SERVER_URL/hotel/getData/" + id),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return notifBox(
                title: 'Error',
                text: 'Request timeout.',
                fontSize: 14.0,
              );
            },
          );
          return http.Response('Error', 408);
        });
    if (res.statusCode == 200) {
      var bodyData = json.decode(res.body);
      var detail = bodyData['foundObject'];
      print(detail);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AccommodationDetail(
                checkInHolder: '',
                checkOutHolder: '',
                numberOfPeopleHolder: '',
                numberOfRoomsHolder: '',
                detail: detail,
                resultIndex: -1,

              )));
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
    }
  }

  Future getAttraction(id) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(
      Uri.parse("$SERVER_URL/attraction/getData/" + id),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return notifBox(
                title: 'Error',
                text: 'Request timeout.',
                fontSize: 14.0,
              );
            },
          );
          return http.Response('Error', 408);
        });
    if (res.statusCode == 200) {
      var bodyData = json.decode(res.body);
      var detail = bodyData['foundAttraction'];
      bool userFavourited = bodyData['userFavourited'];
      print(detail);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Attractiondetail(
            word : '',
            data : detail,
            check : false,
            userFavourited : userFavourited,
            // favFunction: actionFavouriteChild,
            // resultIndex: index,
            resultIndex: -1,
          ))
      );
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
    }
  }
  Future getRestaurant(id) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(
      Uri.parse("$SERVER_URL/restaurant/querydata/" + id),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return notifBox(
                title: 'Error',
                text: 'Request timeout.',
                fontSize: 14.0,
              );
            },
          );
          return http.Response('Error', 408);
        });
    if (res.statusCode == 200) {
      var bodyData = json.decode(res.body);
      var detail = bodyData['foundRestaurant'];
      bool userFavourited = bodyData['userFavourited'];
      print(detail);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Restaudetail(
            data : detail,
            userFavourited : userFavourited,
            // favFunction: actionFavouriteChild,
            resultIndex: -1,
          ))
      );
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
    }
  }

  Future getBlog(id) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    http.Response res = await http.get(
      Uri.parse("$SERVER_URL/blog/getData/" + id),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return notifBox(
                title: 'Error',
                text: 'Request timeout.',
                fontSize: 14.0,
              );
            },
          );
          return http.Response('Error', 408);
        });
    if (res.statusCode == 200) {
      var bodyData = json.decode(res.body);
      var detail = bodyData['foundBlog'];
      bool userFavourited = bodyData['userFavourited'];
      print(detail);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Blogdetail(
          detail: detail,
          userFavourited: userFavourited,
          // favFunction: actionFavouriteChildRecent,
          resultIndex: -1,
        ),
      ));
    }
    else if (res.statusCode == 401) {
      Navigator.pushReplacementNamed(context, '/login',);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Invalid token.',
            fontSize: 14.0,
          );
        },
      );
    }
    else {
      print('failure');
    }
  }

  void initState() {
    super.initState();
    getFavData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'รายการโปรด',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!done)
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(child: CircularProgressIndicator()),
              ),
            if (done && hotelData.length > 0)
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                  child: Text(
                    "ที่พัก",
                    style: GoogleFonts.poppins(
                        color: const Color(0xff1D3557),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.only(left:10, right: 40),
                    scrollDirection: Axis.horizontal,
                    itemCount: hotelData == null ? 0 : hotelData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(hotelData[index]);
                            getAccommodation(hotelData[index]['_id']);
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 3,
                                color: const Color(0xffECFAFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Container(
                                  height: 140,
                                  width: 320,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: SizedBox(
                                          width: 110,
                                          height: 110,
                                          child: Image.network(
                                              "${hotelData[index]['image']}",
                                              width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Flexible(child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment : CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                "${hotelData[index]['name']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.4,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(height: 3,),
                                            Row(
                                              children: [
                                                _buildRatingBar(numberToDouble(hotelData[index]['star'])),
                                                SizedBox(width: 3,),
                                                Text(
                                                  '(${formatStar(hotelData[index]['star'])})',
                                                  style: TextStyle(
                                                    color: grayColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3,),
                                            SizedBox(
                                              child: Text(
                                                "${hotelData[index]['location']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                const Divider(
                  height: 5,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: grayColor,
                ),
              ],
            ),
            if (done && attractionData.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                    child: Text(
                      "สถานที่ท่องเที่ยว",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff1D3557),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only(left:10, right: 40),
                      scrollDirection: Axis.horizontal,
                      itemCount: attractionData == null ? 0 : attractionData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              getAttraction(attractionData[index]["_id"]);
                            },
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: const Color(0xffECFAFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: 140,
                                    width: 320,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: Image.network(
                                                "${attractionData[index]['image'][0]}",
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Flexible(child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  "${attractionData[index]['name']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1.4,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                children: [
                                                  _buildRatingBar(numberToDouble(attractionData[index]['star'])),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    '(${formatStar(attractionData[index]['star'])})',
                                                    style: TextStyle(
                                                      color: grayColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 3,),
                                              SizedBox(
                                                child: Text(
                                                  "${attractionData[index]['location']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: grayColor,
                  ),
                ],
              ),
            if (done && restaurantData.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                    child: Text(
                      "ร้านอาหาร",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff1D3557),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only(left:10, right: 40),
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantData == null ? 0 : restaurantData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              getRestaurant(restaurantData[index]['_id']);
                            },
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: const Color(0xffECFAFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: 140,
                                    width: 320,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: Image.network(
                                                "${restaurantData[index]['image'][0]}",
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Flexible(child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  "${restaurantData[index]['name']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1.4,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                children: [
                                                  _buildRatingBar(numberToDouble(restaurantData[index]['star'])),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    '(${formatStar(restaurantData[index]['star'])})',
                                                    style: TextStyle(
                                                      color: grayColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 3,),
                                              SizedBox(
                                                child: Text(
                                                  "${restaurantData[index]['location']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: grayColor,
                  ),
                ],
              ),
            if (done && blogData.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                    child: Text(
                      "บล็อค",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff1D3557),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only(left:10, right: 40),
                      scrollDirection: Axis.horizontal,
                      itemCount: blogData == null ? 0 : blogData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              getBlog(blogData[index]['_id']);
                            },
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: const Color(0xffECFAFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: 140,
                                    width: 320,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: Image.network(
                                              // TODO: actually get blog image from url
                                                "https://static.wikia.nocookie.net/narnia/images/9/91/Narniadawntreader.png/revision/latest?cb=20101128130243",
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Flexible(child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  "${blogData[index]['topic']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1.4,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(height: 3,),
                                              // Row(
                                              //   children: [
                                              //     _buildRatingBar(numberToDouble(attractionData[index]['star'])),
                                              //     SizedBox(width: 3,),
                                              //     Text(
                                              //       '(${formatStar(attractionData[index]['star'])})',
                                              //       style: TextStyle(
                                              //         color: grayColor,
                                              //         fontSize: 12,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 3,),
                                              SizedBox(
                                                child: Text(
                                                  "${blogData[index]['location']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: grayColor,
                  ),
                ],
              ),


          ],
        ),
      ),
    );
  }
}
