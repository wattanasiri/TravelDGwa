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
  final id;
  final modelid;
  final detail;
  final like;
  final dislike;
  final userLiked;
  final userDisliked;
  final belongToUser;
  final Function removeItemFunction;
  final index;

  commentItem({
    Key key,
    @required this.id,
    @required this.modelid,
    @required this.detail,
    this.like = 0,
    this.dislike = 0,
    this.userLiked = false,
    this.userDisliked = false,
    this.belongToUser = false,
    this.removeItemFunction,
    this.index,
  }) : super(key : key);

  @override
  _itemState createState() => _itemState();
}

class _itemState extends State<commentItem> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController newCommentController = TextEditingController();

  var detail;
  bool debounce = false;
  int like = 0;
  int dislike = 0;
  int index;
  String id;
  String modelid;
  String type;

  double currentEditRating = 3;

  String commentText;
  double commentRating;
  bool userLiked = false;
  bool userDisliked = false;
  bool belongToUser = false;

  bool editingMode = false;

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

  RatingBar _buildRatingSelector() {
    return RatingBar(
      initialRating: currentEditRating,
      minRating: 1,
      itemSize: 40,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: Colors.amber,
        ),
        empty: Icon(
          Icons.star,
          color: Colors.grey,
        ),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        print(rating);
        currentEditRating = rating;
      },
    );
  }

  String formatDate(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    var text = parsedDate.day.toString() + ' ' + getMonthNameStartOne(parsedDate.month) + ' พ.ศ. ' + convertYearToBE(parsedDate.year).toString();
    return text;
  }

  Future editComment() async {

    print(detail);

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
      'id' : modelid,
      'text' : newCommentController.text,
      'rating' : currentEditRating,
    };

    http.Response res = await http.put(
      Uri.parse("$SERVER_URL/comment/$id"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      FocusScope.of(context).unfocus();
      setState(() {
        editingMode = false;
        commentText = newCommentController.text;
        commentRating = currentEditRating;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'ไม่สามารถแก้ไข comment',
            fontSize: 14.0,
          );
        },
      );
    }
  }

  void startDeleteComment() {
    deleteComment();
  }
  Future deleteComment() async {
    // ---------------
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
      'id' : id,
    };

    print('deleting comment');
    http.Response res = await http.delete(
      Uri.parse("$SERVER_URL/comment/$id"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
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
      print('success');
      setState(() {
        widget.removeItemFunction(widget.id);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Success',
            text: 'ลบคอมเมนต์เรียบร้อย',
            fontSize: 14.0,
          );
        },
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Cannot delete comment.',
            fontSize: 14.0,
          );
        },
      );
    }
  }

  Future actionLike() async {
    int newLike;

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
    };

    http.Response res = await http.post(
      Uri.parse("$SERVER_URL/comment/$id/like"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
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
    }
  }

  Future actionDislike() async {

    int newDislike;

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
    };

    http.Response res = await http.post(
      Uri.parse("$SERVER_URL/comment/$id/dislike"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
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
    }
  }

  void initState(){
    detail = widget.detail;
    type = detail['type'];
    like = widget.like;
    dislike = widget.dislike;
    userLiked = widget.userLiked;
    userDisliked = widget.userDisliked;
    belongToUser = widget.belongToUser;
    id = widget.id;
    modelid = widget.modelid;
    commentText = detail['text'];
    commentRating = numberToDouble(detail['rating']);
    currentEditRating = numberToDouble(detail['rating']);
    index = widget.index;
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
                  "TDG",
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
                          if (belongToUser == true)
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                child: PopupMenuButton(
                                    onSelected: (result) {
                                      if (result == 0) {
                                        setState(() {
                                          newCommentController.text = commentText;
                                          editingMode = !editingMode;
                                        });
                                      } else if (result == 1) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return confirmDeleteBox(
                                                detail: detail,
                                                type: 'hotel',
                                                deleteFunction: startDeleteComment,
                                            );
                                          },
                                        );
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xffFFF4DC),
                                        size: 30
                                    ),
                                    color: Colors.white,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Boxicons.bx_edit, color: primaryColor, size: 16,),
                                            SizedBox(width: 5,),
                                            editingMode ? Text("หยุดแก้ไข") : Text("แก้ไข"),
                                          ],
                                        ),
                                        value: 0,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, color: primaryColor, size: 16,),
                                            SizedBox(width: 5,),
                                            Text("ลบรีวิว"),
                                          ],
                                        ),
                                        value: 1,
                                      )
                                    ]
                                ),
                              ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),

                      if (!editingMode) Text(
                        commentText,
                        style: TextStyle(
                          color: Color(0xffFFF4DC),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
          if (editingMode) SizedBox(height: 10,),
          if (editingMode) Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 2),
              //width: 350,
              height: 150,
              decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: const Color(0xff1D3557), width: 2)),
              child: TextFormField(
                minLines: 2,
                maxLines: 5,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'แก้ไขคอมเมนต์',
                  border: InputBorder.none,

                  suffixIcon:
                  IconButton(onPressed: () {
                    if(_formKey.currentState.validate()){
                      editComment();
                    }
                  },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.topRight,
                      icon: Icon(Icons.send, color: Color(0xff1D3557))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาระบุข้อความ';
                  }
                  return null;
                },
                controller: newCommentController,
                onChanged: (value) {
                  //word = value;
                },
              ),
            ),
          ),
          if (editingMode) SizedBox(height: 10,),
          if (editingMode) _buildRatingSelector(),
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
                      color: primaryColor,
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
                      color: primaryColor,
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
              _buildRatingBar(commentRating),
            ],
          ),
        ],
      ),

    );

  }
}
