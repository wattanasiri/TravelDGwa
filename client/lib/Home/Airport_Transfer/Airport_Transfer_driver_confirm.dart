import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/Home/Airport_Transfer/Airport_Transfer_driver_receipt.dart';

class summary extends StatefulWidget {
  String startdate,yourlocation,destination,starttime,typeshuttle,sumprice;
  bool value_booknow;

  summary({this.startdate,this.yourlocation,this.destination,this.starttime,this.typeshuttle,this.sumprice,this.value_booknow});
  @override
  _summaryState createState() => _summaryState();
}

class _summaryState extends State<summary> {

  Future save_invoice() async {
    Datauser datauser = Datauser();
    print('id');
    print(datauser.id);
    String typereserve,username = '';
    print('saveinvoice');
    if(widget.value_booknow){
      typereserve = 'จองเดี๋ยวนี้';
    }else{
      typereserve = 'จองล่วงหน้า';
    }
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/airport_transfer/save_invoice'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "username" : datauser.id,
          "typereserve": typereserve,
          "typeshuttle": widget.typeshuttle,
          "yourlocation": widget.yourlocation,
          "destination": widget.destination,
          "startdate": widget.startdate,
          "starttime": widget.starttime,
          "sum_price": widget.sumprice,
        });
    print(res.body);
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
                                'บริการเรียกรถรับส่ง TravelDGwa',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          if(widget.value_booknow == false)
                          Row(
                            children: [
                              Text(
                                'วันที่ : ' +  widget.startdate,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ],
                          ),
                          if(widget.value_booknow == false)
                          Row(
                            children: [
                              Text(
                                'เวลา : ' + widget.starttime,
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
                          Row(
                            children: [
                              Text(
                                'ไป : ' + widget.destination,
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
                                'ชื่อคนขับ : นายสมปอง ดองงาน',
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
                                'รถรุ่น : ฮอนด้า',
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
                                'ยกเลิกการจองฟรีจนถึงวันที่ 31 ธันวาคม พ.ศ. 2564',
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
                          widget.sumprice,
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
                              'ค่าบริการเรียกรถรับส่ง',
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
                        save_invoice();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                            receipt( startdate: widget.startdate,
                              typeshuttle: widget.typeshuttle,
                              starttime: widget.starttime,
                              destination: widget.destination,
                              yourlocation: widget.yourlocation,
                              sumprice: widget.sumprice,
                              value_booknow: widget.value_booknow,
                            )));
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
            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: <Widget>[
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //           padding: const EdgeInsets.only(left: 25, bottom: 20),
            //           child: AnimatedButton(
            //               height: 50,
            //               width: 360,
            //               isReverse: true,
            //               selectedTextColor: Colors.black,
            //               transitionType: TransitionType.LEFT_TO_RIGHT,
            //               backgroundColor: const Color(0xff1D3557),
            //               borderColor: const Color(0xffFFF4DC),
            //               borderRadius: 13,
            //               borderWidth: 2,
            //               text: "ยืนยันการชำระเงิน",
            //               onPress: () {
            //                 save_invoice();
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
            //                     receipt( startdate: widget.startdate,
            //                       typeshuttle: widget.typeshuttle,
            //                       starttime: widget.starttime,
            //                       destination: widget.destination,
            //                       yourlocation: widget.yourlocation,
            //                       sumprice: widget.sumprice,
            //                       value_booknow: widget.value_booknow,
            //                     )));
            //               })),
            //     ],
            //   ),
            // )

          ],
        ),
      ),
    );
  }
}