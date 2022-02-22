import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_deatil_partner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class result_reserve extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar,price,pricedestination,namedestination;
  Map data,partnerdata;


  result_reserve({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.pricedestination,this.namedestination,this.price});

  @override
  _result_reserveState createState() => _result_reserveState();
}

class _result_reserveState extends State<result_reserve> {
  @override
  void initState() {
    super.initState();
    print('result');
    print(widget.pricedestination);
    print(widget.price);
    print(widget.namedestination);

    // print(widget.data['foundCar']['car_price']);
    // print(widget.data['foundCar']['car_name']);
    // print(widget.data['foundCar']['car_image'][0]);
    // print(widget.data['foundCar']['car_image'].length);
    // print('datapartner');
    // print(widget.partnerdata);
    // print(widget.partnerdata['foundpartner']['namepartner']);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                              Text(
                                'บริษัท  ${ widget.partnerdata['foundpartner']['namepartner']} ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'วันที่รับรถ : ${ widget.dategetcar} (${widget.timegetcar}) ',
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
                                'วันที่ส่งรถ : ${ widget.datesentcar} (${widget.timesentcar}) ',
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
                                  'ชื่อรถ :  ${ widget.data['foundCar']['car_name']}',
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
                                'ชื่อรุ่น : ${ widget.data['foundCar']['car_brand']}',
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
                                'จุดรับ - ส่งรถ :  ${ widget.namedestination}',
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
                          'บริษัท :  ${ widget.partnerdata['foundpartner']['namepartner']}',
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
                          'เบอร์โทรศัพท์ : ${ widget.partnerdata['foundpartner']['phone']}',
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
                          'อีเมล :  ${ widget.partnerdata['foundpartner']['email']}',
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
                          'THB  ${widget.price}',
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

            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'รถ ${ widget.data['foundCar']['car_name']}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xff1D3557)
                              ),
                            ),
                            Text(
                              '${ widget.namedestination}',
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
                              'THB   ${ widget.data['foundCar']['car_price']}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xff1D3557)
                              ),
                            ),
                            Text(
                              'THB  ${widget.pricedestination}',
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
                  color: Color(0xffFFEEC9),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RaisedButton(
                      onPressed: () {

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                        //     receipt( startdate: widget.startdate,
                        //       typeshuttle: widget.typeshuttle,
                        //       starttime: widget.starttime,
                        //       destination: widget.destination,
                        //       yourlocation: widget.yourlocation,
                        //       sumprice: widget.sumprice,
                        //       value_booknow: widget.value_booknow,
                        //     )));
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
