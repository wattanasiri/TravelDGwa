import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/Home/Activity/activity_receipt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class activity_reserve extends StatefulWidget {
  // const activity_reserve({Key key}) : super(key: key);
  activity_reserve({this.dayActivity,this.timeActivity,this.data,this.number,this.sum_price});
  Map data;
  var timeActivity,dayActivity,number,sum_price;

  @override
  _activity_reserveState createState() => _activity_reserveState();
}

class _activity_reserveState extends State<activity_reserve> {

  Future save_invoice() async {
    String username = '';
    print('saveinvoice');
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    Datauser datauser = Datauser();
    print(datauser.id);
    var res = await http.post(Uri.parse('$SERVER_URL/activity/save_invoice'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Accept': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          "username" : datauser.id,
          "number": widget.number.toString(),
          "name": widget.data['foundAcc']['name'],
          "day": widget.dayActivity,
          "time": widget.timeActivity,
          "price": widget.data['foundAcc']['price'].toString(),
          "sum_price": widget.sum_price.toString(),
          "detail" : widget.data['foundAcc']['detail'],
          "image": widget.data['foundAcc']['image'][0],
        });
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: Text('กรอกรายละเอียด'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
              child: Text(
                'สรุปการจอง',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xff1D3557)
                ),
              ),
            ),

            Card(
              color: Color(0xffECFAFF),
              margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Color(0xff1D3557),
                    width: 2.0,
                  )// <-- Radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${ widget.data['foundAcc']['name']} ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff1D3557)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'วันที่เข้าร่วมกิจกรรม : ${ widget.dayActivity} ',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'เวลาที่เข้าร่วมกิจกรรม : ${widget.timeActivity} ',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Divider(
                        color: Color(0xff1D3557),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 290,
                                child: Text(
                                  'บริการ :  ${ widget.data['foundAcc']['detail']}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff1D3557)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'ราคาต่อคน : ${ widget.data['foundAcc']['price']} THB',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'จำนวน : ${ widget.number} คน',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'ป้ายทะเบียนรถ : ${ widget.data['foundCar']['car_license']}',
                          //       style: TextStyle(
                          //           fontSize: 14.0,
                          //           color: Color(0xff1D3557)
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: [
                          //     Text(
                          //       'จุดรับ - ส่งรถ :  ${ widget.namedestination}',
                          //       style: TextStyle(
                          //           fontSize: 14.0,
                          //           color: Color(0xff1D3557)
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Divider(
                        color: Color(0xff1D3557),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: Color(0xff1D3557),
                              ),
                              Text(
                                'ยกเลิกการจองฟรีจนถึงวันที่ 31 ธันวาคม พ.ศ. 2565',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
              child: Text(
                'ข้อมูลติดต่อ',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xff1D3557)
                ),
              ),
            ),


            Card(
              color: Color(0xffECFAFF),
              margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Color(0xff1D3557),
                  width: 2.0,
                ),// <-- Radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'ชื่อ : Sedtawut Chalothornnarumit',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'อีเมล : sedtawut.62-50@gmail.com',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'เบอร์โทรศัพท์ : 09-8765-4321',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
              child: Text(
                'วิธีชำระเงิน',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xff1D3557)
                ),
              ),
            ),

            Card(
              color: Color(0xffECFAFF),
              margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Color(0xff1D3557),
                  width: 2.0,
                ),// <-- Radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              size: 30.0,
                              color: Color(0xff1D3557),
                            ),
                            SizedBox(width: 10.0,),
                            Text(
                              'เสฎฐวุฒิ ชโลธรนฤมิต',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xff1D3557)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'เปลี่ยนบัตร',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                color: Color(0xff1D3557),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'ราคารวม',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'THB  ${widget.sum_price}',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                color: Color(0xff1D3557),
              ),
            ),

            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            //     child: Card(
            //       child: Padding(
            //         padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 10),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               children: [
            //                 Text(
            //                   'ราคาต่อวัน (${widget.dategetcar}-${widget.datesentcar})',
            //                   style: TextStyle(
            //                       fontSize: 14.0,
            //                       color: Color(0xff1D3557)
            //                   ),
            //                 ),
            //                 if(widget.result_price_extra != 0)
            //                   Text(
            //                     'ราคาส่วนต่างเวลา (${widget.timegetcar}-${widget.timesentcar})',
            //                     style: TextStyle(
            //                         fontSize: 14.0,
            //                         color: Color(0xff1D3557)
            //                     ),
            //                   ),
            //                 Text(
            //                   '${ widget.namedestination}',
            //                   style: TextStyle(
            //                       fontSize: 14.0,
            //                       color: Color(0xff1D3557)
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               children: [
            //                 Text(
            //                   'THB ${ widget.data['foundCar']['car_price']*widget.result_date_time}',
            //                   style: TextStyle(
            //                       fontSize: 14.0,
            //                       color: Color(0xff1D3557)
            //                   ),
            //                 ),
            //                 if(widget.result_price_extra != 0)
            //                   Text(
            //                     'THB  ${widget.result_price_extra_}',
            //                     style: TextStyle(
            //                         fontSize: 14.0,
            //                         color: Color(0xff1D3557)
            //                     ),
            //                   ),
            //                 Text(
            //                   'THB  ${widget.pricedestination}',
            //                   style: TextStyle(
            //                       fontSize: 14.0,
            //                       color: Color(0xff1D3557)
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //
            //       ),
            //       color: Color(0xffFFEEC9),
            //     ),
            //   ),
            // ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RaisedButton(
                      onPressed: () {
                        save_invoice();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                            activity_receipt(
                        number: widget.number,
                        name: widget.data['foundAcc']['name'],
                        day: widget.dayActivity,
                        time: widget.timeActivity,
                        price: widget.data['foundAcc']['price'],
                        sum_price: widget.sum_price,
                        detail: widget.data['foundAcc']['detail'],
                            ),));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ยืนยันการชำระเงิน',
                          style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFF4DC)
                          ),
                        ),
                      ),
                      color: Color(0xff1D3557),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
