import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class receipt extends StatefulWidget {
  String startdate,yourlocation,destination,starttime,typeshuttle,sumprice;
  bool value_booknow;

  receipt({this.startdate,this.yourlocation,this.destination,this.starttime,this.typeshuttle,this.sumprice,this.value_booknow});
  @override
  _receiptState createState() => _receiptState();
}

class _receiptState extends State<receipt> {


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
                                    'บริการเช่ารถรับ - ส่ง TravelDGwa',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xff1D3557)
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '#0001TH',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xff827E7E)
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
                          if(widget.value_booknow == false)
                            SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'วันที่ : ' + widget.startdate,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          if(widget.value_booknow == false)
                            SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                'เวลา : ' + widget.starttime,
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
                                  'จาก : ' + widget.yourlocation,
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
                                'ไป: ' + widget.destination,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                'ชื่อคนขับ : นายสมปอง ดองงาน',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                'รถรุ่น : ฮอนด้า',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                'ทะเบียน : ฟฟ6207',
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
                                      'ค่าบริการเช่ารถรับ - ส่งสนามบิน',
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
                                      widget.sumprice,
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
                                      widget.sumprice,
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