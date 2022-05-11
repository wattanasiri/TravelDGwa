import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:se_app2/Home/Attraction/tourism_result.dart';
import 'package:se_app2/navigator/nav/tripwithAI/trip_continue.dart';

import '../../../Data/data_locations.dart';
import '../../../Data/data_selectcontinue.dart';
import 'Trip_detail.dart';

class triplog extends StatefulWidget {
  List<dynamic> data;
  Map dataquerymap;
  var alltime,title;
  bool statussuccess,statusunsuccess;
  String weather,adventure,sea,confidence,bagpack,budget,social;
  triplog({this.statussuccess,this.statusunsuccess,this.weather,this.adventure,this.sea,this.confidence,this.social,this.bagpack,this.budget,this.data,this.alltime,this.title,this.dataquerymap});
  @override
  _triplogState createState() => _triplogState();
}

class _triplogState extends State<triplog> {
  Map querycontinuedata;
  List<dynamic> selectlocation;

  Future querydatacontinue() async{
    print(querycontinuedata);
    Datalocation data = Datalocation();
    Dataselectcontinue selectdata2 = Dataselectcontinue();
    selectlocation = selectdata2.selectcontinue;
    for (int j =0; j< querycontinuedata['location'].length ; j++) {
      for(int i = 0; i < data.location.length; i++){
        if(data.location[i]['name'] == querycontinuedata['location'][j]){
          selectlocation.add(
              data.location[i]
          );
        }
      }
    }
    print(selectlocation);
    print(selectlocation.length);

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          title: const Text(
            'บันทึกทริป',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //กำลังดำเนินการ
            //ไม่มีทริปที่กำลัง
            //เอาให้ส่วนนี้หายไปเลย
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.statusunsuccess == true)
                  Text(
                    'กำลังดำเนินการ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                if(widget.statusunsuccess == true)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    //สร้างตัวระหว่างทาง
                    itemCount: widget.dataquerymap['foundinfo'].length,
                    itemBuilder: (context,index){
                      return  GestureDetector(
                        onTap: (){
                          querycontinuedata = widget.dataquerymap['foundinfo'][index];
                          querydatacontinue();
                          print(widget.dataquerymap['foundinfo'][index]['_id']);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => tripcontinue(
                            data: widget.dataquerymap['foundinfo'][index],
                            alltime: widget.dataquerymap['foundinfo'][index]['alltime'],
                            title: widget.dataquerymap['foundinfo'][index]['nametrip'],
                            dataquerymap: widget.dataquerymap,
                            datamap: selectlocation,
                            weather : widget.weather,
                            adventure :  widget.adventure,
                            sea : widget.sea,
                            confidence: widget.confidence,
                            bagpack: widget.bagpack,
                            budget: widget.budget,
                            social : widget.social,
                          ),));
                        },
                        child: Column(
                          children: [
                            if(widget.dataquerymap['foundinfo'][index]['status'] == 'unsuccess')
                              Row(
                                children: [
                                  //กล่องด้านหน้าเวลา
                                  Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff1D3557),
                                      /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 6,
                                          offset: const Offset(1, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.dataquerymap['foundinfo'][index]['alltime'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffECFAFF),
                                          ),
                                        ),
                                        Text(
                                          'เวลารวม',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffECFAFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  //ตกแต่ง
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Color(0xff1D3557),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 7,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Color(0xff1D3557),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 7,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Color(0xff1D3557),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 7,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Color(0xff1D3557),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  //กล่องหลังข้อมูลทริป
                                  Container(
                                    width: 225,
                                    height: 80,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff1D3557),
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 6,
                                          offset: const Offset(1, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //ชื่อทริป
                                        Flexible(child: Text(
                                          'ชื่อทริป ' + widget.dataquerymap['foundinfo'][index]['nametrip'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffECFAFF),
                                          ),
                                        ),),
                                        SizedBox(height: 5,),
                                        //สถานที่
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //ต้นทาง
                                            Flexible(child: Text(
                                              widget.dataquerymap['foundinfo'][index]['location'][0],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffECFAFF),
                                              ),
                                            ), ),
                                            Icon(Boxicons.bx_right_arrow_alt,
                                                color: const Color(0xffFF9A62),
                                                size: 30),
                                            //ปลายทาง
                                            Flexible(child: Text(
                                              widget.dataquerymap['foundinfo'][index]['location'][widget.dataquerymap['foundinfo'][index]['location'].length - 1],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffECFAFF),
                                              ),
                                            ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],

                        ),
                      );
                    }
                ),
                const SizedBox(
                  height: 15,
                ),
                if(widget.statussuccess == true)
                Text(
                  'ประวัติการสร้างทริป',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                if(widget.statussuccess == false && widget.statusunsuccess == false)
                  Row(
                    children: [
                      Icon(Icons.map_outlined  ,
                          color: Color(0xff1D3557),
                          size: 30),
                      SizedBox(width: 10,),
                      Text(
                        'ไม่มีประวัติการสร้างทริป',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1D3557),
                        ),
                      ),

                    ],
                  ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    //สร้างตัวระหว่างทาง
                    itemCount: widget.dataquerymap['foundinfo'].length,
                    itemBuilder: (context,index){
                      return  Column(
                        children: [
                          if(widget.dataquerymap['foundinfo'][index]['status'] == 'success')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    //กล่องด้านหน้าเวลา
                                    Container(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xffECFAFF),
                                        /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: const Offset(1, 6),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.dataquerymap['foundinfo'][index]['alltime'],
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1D3557),
                                            ),
                                          ),
                                          Text(
                                            'เวลารวม',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1D3557),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    //ตกแต่ง
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 7,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(0xffECFAFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 6,
                                                offset: const Offset(1, 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 7,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(0xffECFAFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 6,
                                                offset: const Offset(1, 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 7,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(0xffECFAFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 6,
                                                offset: const Offset(1, 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 7,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(0xffECFAFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 6,
                                                offset: const Offset(1, 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    //กล่องหลังข้อมูลทริป
                                    Container(
                                      width: 225,
                                      height: 80,
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xffECFAFF),
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: const Offset(1, 6),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ชื่อทริป
                                          Flexible(child: Text(
                                            'ชื่อทริป ' + widget.dataquerymap['foundinfo'][index]['nametrip'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1D3557),
                                            ),
                                          ),),
                                          SizedBox(height: 5,),
                                          //สถานที่
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              //ต้นทาง
                                              Flexible(child: Text(
                                                widget.dataquerymap['foundinfo'][index]['location'][0],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff1D3557),
                                                ),
                                              ), ),
                                              Icon(Boxicons.bx_right_arrow_alt,
                                                  color: const Color(0xffFF9A62),
                                                  size: 30),
                                              //ปลายทาง
                                              Flexible(child: Text(
                                                widget.dataquerymap['foundinfo'][index]['location'][widget.dataquerymap['foundinfo'][index]['location'].length - 1],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff1D3557),
                                                ),
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                        ],

                      );
                    }
                ),

                SizedBox(height: 45,),
                Container(
                  width: 330,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, '/Navi',
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'กลับไปหน้าหลัก',
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

          ],
        ),
      ),
    );
  }

}