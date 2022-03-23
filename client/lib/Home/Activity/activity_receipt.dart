import 'package:se_app2/Home/Activity/activity_result_reserve.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/Home/Activity/activity_receipt.dart';
import 'package:se_app2/Home/Activity/activity_result_reserve.dart';

class activity_receipt extends StatefulWidget {
  // const activity_receipt({Key? key}) : super(key: key);
  activity_receipt({this.day,this.time,this.name,this.number,this.price,this.sum_price,this.detail});
  var number,day,time,name,price,sum_price,detail;

  @override
  _activity_receiptState createState() => _activity_receiptState();
}

class _activity_receiptState extends State<activity_receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: Text('ใบเสร็จ'),
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
          children: [
            Card(
              color: Color(0xffECFAFF),
              margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ใบเสร็จ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D3557),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 230,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 15.0,
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xff1D3557)
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '#0001TH',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff827E7E)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                            'ข้อมูลเพิ่มเติม',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff827E7E)
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          'วันที่ : ' + widget.day,
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text(
                          'เวลา : ' + widget.time,
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xff1D3557)
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
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
                                'แสดงใบเสร็จที่หน้าร้าน เพื่อเข้าใช้บริการ',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Color(0xff1D3557),
                              ),
                              Text(
                                'ใบเสร็จจะหมดอายุทันทีเมื่อพ้นเวลาที่จองเอาไว้',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color(0xff1D3557),
                              ),
                              Text(
                                'เวลาที่ระบุทั้งหมดเป็นเวลา ท้องถิ่น',
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
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Divider(
                        color: Color(0xff1D3557),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 25, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'รายละเอียด',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(0xff1D3557)
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'ราคา',
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width : 230,
                                  child: Text(
                                      // '${widget.name} (${widget.number})',
                                    '${widget.detail} (${widget.number.toString()})',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                        color: Color(0xff1D3557)
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    widget.price.toString(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff1D3557)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 18, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'รวม',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1D3557)
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.sum_price.toString(),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
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

                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 2, 30, 0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, '/Navi',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'กลับไปที่การจองของฉัน',
                          style: TextStyle(
                              fontSize: 19.0,
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
