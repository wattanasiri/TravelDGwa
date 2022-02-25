
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class rentcar_rerceipt extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar,price,pricedestination,namedestination;
  var result_price_extra,result_price_extra_,result_date_time;
  Map data,partnerdata;


  rentcar_rerceipt({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.pricedestination,this.namedestination,this.price,this.result_price_extra,this.result_price_extra_,this.result_date_time});


  @override
  _rentcar_rerceiptState createState() => _rentcar_rerceiptState();
}

class _rentcar_rerceiptState extends State<rentcar_rerceipt> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          children: <Widget>[

            Card(
              color: Color(0xffECFAFF),
              margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
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
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'ชื่อรถ :  ${ widget.data['foundCar']['car_name']}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xff1D3557)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'บริษัท  ${ widget.partnerdata['foundpartner']['namepartner']} ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xff1D3557)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
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
                            SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'ทะเบียนรถ : ${ widget.data['foundCar']['car_license']}',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                            SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'วันที่รับรถ : ${widget.dategetcar} (${widget.timegetcar})',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                width: 290,
                                child: Text(
                                  'วันที่คืนรถ : ${widget.datesentcar} (${widget.timesentcar})',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff1D3557)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                'จุดรับรถ : ' + widget.namedestination,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.library_books,
                                        color: Color(0xff1D3557),
                                      ),
                                      Text(
                                        'รวมประกันภัยพื้นฐาน',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Color(0xff1D3557)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.directions_car,
                                        color: Color(0xff1D3557),
                                      ),
                                      Text(
                                        'บริการรับ  - ส่งรถตามจุดที่ให้บริการ',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Color(0xff1D3557)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                                Column(
                                  children: [
                                    Text(
                                      'ค่าเช่ารถสำหรับ ${widget.result_date_time} วัน',
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
                                      ' THB  ${ widget.data['foundCar']['car_price']*widget.result_date_time}',
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
                          if(widget.result_price_extra != 0)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'ค่าส่วนต่างเวลาคืนรถ ${widget.result_price_extra} นาที',
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
                                      ' THB  ${widget.result_price_extra_}',
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
                                Column(
                                  children: [
                                    Text(
                                      'ค่ารับรถ-ส่งรถ ${widget.namedestination}',
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
                          SizedBox(height: 3,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 18, 5),
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
                                      'THB ' + widget.price,
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
                    padding: const EdgeInsets.all(30.0),
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
