import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_receipt.dart';

class result_reserve extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar,price,pricedestination,namedestination;
  var result_price_extra,result_price_extra_,result_date_time;
  Map data,partnerdata;
  bool checkpriceextra;


  result_reserve({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.pricedestination,this.namedestination,this.price,this.result_price_extra,this.result_price_extra_,this.result_date_time,this.checkpriceextra});

  @override
  _result_reserveState createState() => _result_reserveState();
}

class _result_reserveState extends State<result_reserve> {

  Future save() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    Datauser datauser = Datauser();
    print('id');
    print(datauser.id);
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/save_transaction'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Accept': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{

          "usernameid": datauser.id,
          "partnername": widget.partnerdata['foundpartner']['namepartner'],
          "car_name": widget.data['foundCar']['car_name'],
          "car_license" : widget.data['foundCar']['car_license'],
          "date_sentcar": widget.datesentcar,
          "date_getcar": widget.dategetcar,
          "time_getcar": widget.timegetcar,
          "time_sentcar": widget.timesentcar,
          "location": widget.yourlocation,
          "detail_pricedate": "${widget.dategetcar}->${widget.datesentcar}",
          "detail_pricetime": "${widget.timegetcar}->${widget.timesentcar}",
          "detail_pricelocation": widget.namedestination,
          "sum_detail_pricedate": "${widget.data['foundCar']['car_price']*widget.result_date_time}",
          "sum_detail_pricetime": "${widget.result_price_extra_}",
          "sum_detail_pricelocation": "${widget.pricedestination}",
          "total_price": widget.price.toString(),
          "carid": widget.data['foundCar']['_id'],
        });
    print('res');
    print(res);
    //กรุงเทพ
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        rentcar_rerceipt(
          dategetcar: widget.dategetcar,
          timegetcar: widget.timegetcar,
          datesentcar: widget.datesentcar,
          timesentcar: widget.timesentcar,
          yourlocation: widget.yourlocation,
          price: widget.price,
          data: widget.data,
          partnerdata: widget.partnerdata,
          pricedestination : widget.pricedestination,
          namedestination : widget.namedestination,
          result_price_extra: widget.result_price_extra,
          result_price_extra_: widget.result_price_extra_,
          result_date_time : widget.result_date_time,

        ),));
  }
  void initState() {
    super.initState();
    print(widget.result_price_extra);
    print(widget.result_price_extra_);

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
                          Row(
                            children: [
                              Text(
                                'ป้ายทะเบียนรถ : ${ widget.data['foundCar']['car_license']}',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'ราคาต่อวัน (${widget.dategetcar}->${widget.datesentcar})',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                              if(widget.result_price_extra != 0)
                                Text(
                                  'ราคาส่วนต่างเวลา (${widget.timegetcar}->${widget.timesentcar})',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xff1D3557)
                                  ),
                                ),
                              Text(
                                'ราคาส่งรถที่ ${ widget.namedestination}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'THB ${ widget.data['foundCar']['car_price']*widget.result_date_time}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                              if(widget.result_price_extra != 0)
                                Text(
                                  'THB  ${widget.result_price_extra_}',
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
                      onPressed: () => {
                        save(),


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
