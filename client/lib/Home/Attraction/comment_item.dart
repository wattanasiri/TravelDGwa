import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:se_app2/Widgets/notif_ok.dart';

import 'comment_delete.dart';


class commentItem extends StatefulWidget {
  final detail;
  final like;
  final dislike;
  final userLiked;
  final userDisliked;
  final belongToUser;

  commentItem({
    Key key,
    @required this.detail,
    this.like = 0,
    this.dislike = 0,
    this.userLiked = false,
    this.userDisliked = false,
    this.belongToUser = false,
  }) : super(key : key);

  @override
  _itemState createState() => _itemState();
}

class _itemState extends State<commentItem> {

  var detail;
  int like = 0;
  int dislike = 0;

  bool userLiked = false;
  bool userDisliked = false;
  bool belongToUser = false;

  bool optionsVisible = false;

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

  String formatDate(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = parsedDate.day.toString() + ' ' + getMonthName(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }

  Future actionLike() async {
    int newLike;
    if (userDisliked) {
      setState((){
        dislike -= 1;
        userDisliked = !userDisliked;
      });
    }
    if (userLiked) {
      newLike = like -= 1;
    } else {
      newLike = like += 1;
    }
    setState(() {
      newLike;
      userLiked = !userLiked;
    });
    // Insert code
  }

  Future actionDislike() async {
    int newDislike;
    if (userLiked) {
      setState((){
        like -= 1;
        userLiked = !userLiked;
      });
    }
    if (userDisliked) {
      newDislike = dislike -= 1;
    } else {
      newDislike = dislike += 1;
    }
    setState(() {
      newDislike;
      userDisliked = !userDisliked;
    });
    // Insert code
  }

  void initState(){
    detail = widget.detail;
    like = widget.like;
    dislike = widget.dislike;
    userLiked = widget.userLiked;
    userDisliked = widget.userDisliked;
    belongToUser = widget.belongToUser;

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${detail['username']}",
                                    style: TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${formatDate(detail['date'])}, เวลา ${detail['time']} น.',
                                    style: TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontSize: 10,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => {},
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.all(0),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 30
                              ),
                              color: Color(0xffFFF4DC),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      Text(
                        '${detail['text']}',
                        style: TextStyle(
                          color: Color(0xffFFF4DC),
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
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
                  GestureDetector(
                    onTap: () {
                      actionLike();
                    },
                    child: Container(
                      child:
                      Row(
                        children: [
                          userLiked ?
                          const Icon(Icons.thumb_up_alt, color: Color(0xffFFF4DC), size: 20,) :
                          const Icon(Icons.thumb_up_alt_outlined, color: Color(0xffFFF4DC), size: 20,),

                          SizedBox(width: 7,),
                          Text(
                              "$like",
                              style: TextStyle(
                                  color: Color(0xffFFF4DC), fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 7,),
                  GestureDetector(
                    onTap: () {
                      actionDislike();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          userDisliked ?
                          const Icon(Icons.thumb_down, color: Color(0xffFFF4DC), size: 20,) :
                          const Icon(Icons.thumb_down_alt_outlined, color: Color(0xffFFF4DC), size: 20,),
                          SizedBox(width: 7,),
                          Text(
                              "$dislike" ,
                              style: TextStyle(
                                  color: Color(0xffFFF4DC), fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              _buildRatingBar(numberToDouble(detail['rating'])),
            ],
          ),
        ],
      ),

    );

  }
}
