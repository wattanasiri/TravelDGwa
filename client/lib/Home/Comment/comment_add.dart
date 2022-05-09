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

class commentAdd extends StatefulWidget {
  final detail;
  final type;
  final Future loadComment;

  commentAdd({
    Key key,
    @required this.detail,
    @required this.type,
    @required this.loadComment
  }) : super(key: key);

  @override
  _itemState createState() => _itemState();
}

class _itemState extends State<commentAdd> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController commentController = TextEditingController();


  var detail;
  bool debounce = false;
  String type;
  Future loadComment;

  double currentRating = 3;

  RatingBar _buildRatingSelector() {
    return RatingBar(
      initialRating: currentRating,
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
        currentRating = rating;
      },
    );
  }

  Future postComment() async {
    // ---------------
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');

    final now = DateTime.now();

    var dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(now);

    var timeFormat = DateFormat('HH:mm'); // uppercase H for 24h format
    String formattedTime = timeFormat.format(now);

    final body = {
      "id": widget.detail['_id'],
      "type": type, // IMPORTANT: CHANGE THIS WHEN YOU COPY THIS CODE
      "text": commentController.text,
      "date": formattedDate,
      "time": formattedTime,
      "rating": currentRating,
    };

    http.Response res = await http.post(
      Uri.parse("$SERVER_URL/comment/${widget.detail['_id']}/model/$type"),
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
      commentController.text = "";
      FocusScope.of(context).unfocus();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Success',
            text: 'comment เรียบร้อย',
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
    else if (res.statusCode != 408) {
      print('failure');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return notifBox(
            title: 'Error',
            text: 'Cannot post comment.',
            fontSize: 14.0,
          );
        },
      );
    }
  }

  void initState() {
    detail = widget.detail;
    type = widget.type;
    loadComment = widget.loadComment;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 10.0),
              height: 150,
              decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xff1D3557), width: 2)),
              child: TextFormField(
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'เขียนรีวิวและให้คะแนน...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  suffix: IconButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          postComment();
                          loadComment;
                        }
                      },
                      alignment: Alignment.topRight,
                      icon: Icon(
                        Icons.send,
                        color: Color(0xff1D3557),
                        size: 24,
                      )),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาระบุข้อความ';
                  }
                  return null;
                },
                controller: commentController,
                onChanged: (value) {
                },
              ),
            ),
          ),

//จบกล่องเพิ่มความเห็น
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: _buildRatingSelector(),
          ),
        ],
      ),
    );
  }
}
