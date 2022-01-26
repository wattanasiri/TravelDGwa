import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'dart:async';

import 'shuttle.dart';
import 'info_driver.dart';

class search_driver extends StatefulWidget {
  String startdate,yourlocation,destination,starttime,typeshuttle,sumprice;
  bool value_booknow;

  search_driver({this.startdate,this.yourlocation,this.destination,this.starttime,this.typeshuttle,this.sumprice,this.value_booknow});
  @override
  _search_driverState createState() => _search_driverState();
}
class _search_driverState extends State<search_driver> {


  @override
  void initState() {
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          driver_info( startdate: widget.startdate,
            typeshuttle: widget.typeshuttle,
            starttime: widget.starttime,
            destination: widget.destination,
            yourlocation: widget.yourlocation,
            sumprice: widget.sumprice,
            value_booknow: widget.value_booknow,
          )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xffFFF4DC),
        appBar: AppBar(
          backgroundColor: Color(0xffFFF4DC),
          toolbarHeight: 70,
          elevation: 0.0,
          title: Text('จองล่วงหน้า'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color(0xff1d3557),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search,
                        size: 150,
                        color: Color(0xff1D3557),
                      ),
                      Text(
                        'กำลังค้นหาคนขับ...',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1D3557)
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              Card(
                color: Color(0xffECFAFF),
                margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        if(widget.value_booknow == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 85,
                              child: Text(
                                'วันที่',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 85,
                                child: Text(widget.startdate,style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                                )
                            ),
                          ],
                        ),
                        if(widget.value_booknow == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 85,
                              child: Text(
                                'เวลา',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 85,
                              child: Text(
                                widget.starttime,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 85,
                              child: Text(
                                'ประเภทรถ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 85,
                              child: Text(
                                widget.typeshuttle,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: Container(
                                    child: Icon(
                                      Icons.location_pin,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: 85,
                                  child: Text(
                                    widget.yourlocation.length > 40 ? widget.yourlocation.substring(0,40)+'...' : widget.yourlocation,
                                    style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 14.0,
                                    ),textAlign: TextAlign.center,

                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xff1D3557),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: Container(
                                    child: Icon(
                                      Icons.flag,
                                      color: Color(0xff1D3557),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: 90,
                                  child: Text(
                                    widget.destination,
                                    style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 14.0,
                                    ),textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Divider(
                            color: Color(0xff1D3557),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 85,
                              child: Text(
                                'ราคา',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.sumprice,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff1D3557)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xff1D3557),
                      width: 2.0,
                    )// <-- Radius
                ),
              ),



              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: AnimatedButton(
                            height: 50,
                            width: 360,
                            isReverse: true,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.LEFT_TO_RIGHT,
                            backgroundColor: const Color(0xffF25B52),
                            borderColor: const Color(0xffFFF4DC),
                            borderRadius: 13,
                            borderWidth: 2,
                            text: "ยกเลิก",
                            onPress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ShuttlePage()));
                            })),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}