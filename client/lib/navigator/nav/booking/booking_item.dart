import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:se_app2/constants.dart';
import 'package:http/http.dart' as http;

import 'booking_detail_hotel.dart';

class ResultItem extends StatefulWidget {
  final bookingStatus;
  final bookingSort;
  final bookingData;
  const ResultItem(
      {Key key,
        this.bookingStatus,
        this.bookingSort,
        this.bookingData,
      })
      : super(key: key);
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {

  var itemFound = false;
  var connectionFailed = false;
  var bookingStatus;
  var bookingSort;
  var bookingData;
  var data;

  Future getBookingData() async {
    http.Response res = await http.get(Uri.parse("http://10.0.2.2:8080/shuttle"));
    data = json.decode(res.body);
    data = data['booking'];

    if (res.statusCode == 200) {
      print('success');
      var itemCount = data.length;
      if (itemCount > 0) {
        setState((){
          itemFound = true;
          connectionFailed = false;
        });
      } else {
        setState((){ itemFound = false; connectionFailed = false;});
      }
    }
    else {
      print('failure');
      setState((){
        connectionFailed = true;
      });
    }
  }
  @override
  void initState() {
    getBookingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                print(data[index]),
                print(widget.bookingStatus),
                print(widget.bookingSort),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => hotelDetail(
                            detail: data[index])))
              },
              child: GFCard(
                elevation: 8,
                color: const Color(0xff1D3557),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(alignment: Alignment.bottomRight, children: <Widget>[
                      Row(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          ShaderMask(shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.transparent, Color(0xff1D3557)],
                              ).createShader(Rect.fromLTRB(80, 0, rect.width*1, rect.height));
                            },
                            blendMode: BlendMode.srcATop,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.asset('assets/images/homebg.png',
                                  height: 100,
                                  width: 160,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Flexible(child: Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 5,
                              right: 40,
                            ),
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['username'],
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'SUBTITLEEEEEEEEEEEEEEEEEEEEEEE',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontSize: 12),
                                ),
                                SizedBox(height: 3,),
                                Text(
                                  'DATE1',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffECFAFF),
                                      fontSize: 11),
                                ),
                                Text(
                                  'DATE2',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffECFAFF),
                                      fontSize: 11),
                                ),
                              ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 68,
                          right: 7,
                        ),
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Color(0xffECFAFF),
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Icon(Icons.directions_car,
                            color: Color(0xff1D3557),
                            size: 20),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(
                          bottom: 5,
                          right: 5,
                        ),
                        child: Text(
                          'กดเพื่อดูรายละเอียดเพิ่มเติม >>',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xffECFAFF),
                              fontSize: 9),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
