import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../Data/data_currentuser.dart';
import 'Trip_log.dart';
import 'map.dart';
import 'mapmain.dart';
class tripcontinue extends StatefulWidget {
  var alltime,title;
  List<dynamic> datamap;
  String weather,adventure,sea,confidence,bagpack,budget,social ;
  Map dataquerymap,data;
  tripcontinue({this.datamap,this.weather,this.adventure,this.sea,this.confidence,this.social,this.bagpack,this.budget,this.data,this.alltime,this.title,this.dataquerymap});
  @override

  _tripcontinueState createState() => _tripcontinueState();
}

class _tripcontinueState extends State<tripcontinue> {
  // Generating a long list to fill the ListView
  Map querydata2;
  bool begincheck = false;
  bool sdiecheck = false;
  bool endcheck = false;
  List<bool> checkboxs = [false, false, false, false, false, false, false, false, false];
  // Generating a long list to fill the ListView
  final List<Map> checkbox = List.generate(100,
          (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});
  //เอาไว้สร้างตัวระหว่างทางเพิ่ม
  int btw = 0;
  //เอาไว้สร้างตัวระหว่างทางเพิ่ม
  bool statussuccess,statusunsuccess = false;

  Future querydata() async{
    Datauser datauser = Datauser();
    print('querydata2');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydataandupdatstatus/' + widget.data['_id']));
    querydata2 = json.decode(res.body);
    print(querydata2);
    for(int i=0 ; i < querydata2['foundinfo'].length ; i ++){
      if(querydata2['foundinfo'][i]['status'] == 'success'){
        statussuccess = true;
      }
      if(querydata2['foundinfo'][i]['status'] == 'unsuccess'){
        statusunsuccess = true;
      }

    }
  }

  Future querydatafromcancel() async{
    Datauser datauser = Datauser();
    print('querydatafromcancel');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydatamap'));
    querydata2 = json.decode(res.body);
    print(querydata2);
    for(int i=0 ; i < querydata2['foundinfo'].length ; i ++){
      if(querydata2['foundinfo'][i]['status'] == 'success'){
        statussuccess = true;
      }
      if(querydata2['foundinfo'][i]['status'] == 'unsuccess'){
        statusunsuccess = true;
      }

    }
  }
  Future check() async {
    print('check');
    for(int i=1 ; i< widget.data['location'].length-1;i++){
      print(checkboxs[i]);
      sdiecheck = true;
      if(checkboxs[i] == false){
        sdiecheck = false;
      }
    }
    if(endcheck == true && sdiecheck == true && begincheck == true){
      // save();
      await querydata();
      Navigator.push(context, MaterialPageRoute(builder: (context) => triplog(
        statussuccess: statussuccess,
        statusunsuccess: statusunsuccess,
        weather : widget.weather,
        adventure :  widget.adventure,
        sea : widget.sea,
        confidence: widget.confidence,
        bagpack: widget.bagpack,
        budget: widget.budget,
        social : widget.social,
        dataquerymap: querydata2,
      ),));
    }
  }

  @override
  void initState() {
    super.initState();
    print('data');
    // widget.data.removeAt(0);
  }

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
            'ข้อมูลทริป',
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
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //ชื่อทริป
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30,),
                    Text(
                      'ชื่อ  ทริป',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1D3557),
                      ),
                    ),
                    SizedBox(width: 50,),
                    Flexible(
                      child:Row(
                        children: [
                          Flexible(child: Text(
                            widget.data['nametrip'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1D3557),
                            ),
                          ),
                          ),
                          // IconButton(
                          //   icon: const Icon(
                          //     Boxicons.bxs_edit_alt,
                          //     color: Color(0xff1D3557),
                          //   ),
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                //จบชื่อทริป
                SizedBox(height: 10,),
                //เวลารวม
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'เวลารวมของทริป',
                        style: TextStyle(fontWeight: FontWeight.w900,
                            fontSize: 17,color: Color(0xff1D3557) ),
                      ),
                      Container(
                        width: 170,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_outlined,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text(
                              widget.data['alltime'] + ' น.',
                              style: TextStyle(fontWeight: FontWeight.w900,
                                  fontSize: 17,color: Color(0xff1D3557) ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //จบเวลารวม
            SizedBox(height: 10,),
            //แผนที่
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'เส้นทางและแผนที่',
                    style: TextStyle(fontWeight: FontWeight.w900,
                        fontSize: 17,color: Color(0xff1D3557) ),
                  ),
                  //ปุ่มเปิดแผนที่
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => {
                          print(widget.datamap),
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample(
                            data: widget.datamap,
                          ),))

                        },
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15),
                          width: 168,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xff1D3557),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.map_rounded,
                                  color: Color(0xffFF9A62)),
                              SizedBox(width: 10),
                              Text(
                                'เปิดแผนที่',
                                style: TextStyle(
                                    color: Color(0xffECFAFF),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //จบปุ่มเปิดแผนที่
                ],
              ),
            ),
            //จบแผนที่
            SizedBox(height: 10,),
            //ต้นทาง
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 2),
                      child: Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ต้นทาง',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xff1D3557) ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Boxicons.bxs_circle,
                        color: const Color(0xff1BC3FF),
                        size: 30),
                    SizedBox(width: 2,),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      width: 320,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffFCD88D),
                        borderRadius: BorderRadius.circular(25),

                        /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                      child:Row(
                        children : [
                          Text(
                            widget.data['location'][0].length > 32 ? widget.data['location'][0].substring(0,32)+'...' : widget.data['location'][0],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w900,
                                fontSize: 17,color: Color(0xff1D3557) ,decoration: begincheck ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //จบต้นทาง
                SizedBox(height: 10,),
                //เวลา
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Boxicons.bx_dots_vertical_rounded,
                        color: const Color(0xff1D3557),
                        size: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาเริ่มต้น',
                          style: TextStyle(fontWeight: FontWeight.w900,
                              fontSize: 15,color: Color(0xff1D3557)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          width: 135,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.access_time_outlined,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text(
                                '${widget.data['starttime'][0]} น.',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 17,color: Color(0xff1D3557),decoration: begincheck ? TextDecoration.lineThrough : null ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาสิ้นสุด',
                          style: TextStyle(fontWeight: FontWeight.w900,
                              fontSize: 15,color: Color(0xff1D3557) ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          width: 135,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.access_time_outlined,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text(
                                '${widget.data['endtime'][0]} น.',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 17,color: Color(0xff1D3557),decoration: begincheck ? TextDecoration.lineThrough : null ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: begincheck,
                      onChanged: (begincheck){
                        setState(() {
                          this.begincheck = begincheck;
                        });
                        begincheck = true;
                        check();
                      },
                    )
                  ],
                ),
              ],
            ),
            //จบเวลา
            SizedBox(height: 10,),
            //ระหว่างทาง
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //สร้างตัวระหว่างทาง
                itemCount: widget.data['location'].length - 2,
                itemBuilder: (context,index){
                  return  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 2),
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ระหว่างทาง',
                                        style: TextStyle(fontWeight: FontWeight.w900,
                                            fontSize: 15,color: Color(0xff1D3557) ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_circle,
                              color: const Color(0xffFF9A62),
                              size: 30),
                          SizedBox(width: 2,),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            width: 320,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD88D),
                              borderRadius: BorderRadius.circular(25),

                              /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                            child:Row(
                              children : [
                                Text(
                                  widget.data['location'][index+1].length > 32 ? widget.data['location'][index+1].substring(0,32)+'...' : widget.data['location'][index+1],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 17,color: Color(0xff1D3557),decoration: checkboxs[index+1] ? TextDecoration.lineThrough : null ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //จบต้นทาง
                      SizedBox(height: 10,),
                      //เวลา
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bx_dots_vertical_rounded,
                              color: const Color(0xff1D3557),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาเริ่มต้น',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '${widget.data['starttime'][index+1]} น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557),decoration: checkboxs[index+1] ? TextDecoration.lineThrough : null  ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาสิ้นสุด',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '${widget.data['endtime'][index+1]} น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557),decoration: checkboxs[index+1] ? TextDecoration.lineThrough : null ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: checkboxs[index+1],
                            onChanged: (sdiecheck)
                            {
                              setState(() {
                                this.checkboxs[index+1] = sdiecheck;
                              });
                              check();

                            },
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                }
            ), //จบเวลา
            SizedBox(height: 10,),
            //ปลายทาง
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 2),
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ปลายทาง',
                                        style: TextStyle(fontWeight: FontWeight.w900,
                                            fontSize: 15,color: Color(0xff1D3557) ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_been_here,
                              color: const Color(0xffFF0000),
                              size: 30),
                          SizedBox(width: 2,),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            width: 320,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD88D),
                              borderRadius: BorderRadius.circular(25),

                              /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                            child:Row(
                              children : [
                                Text(
                                  widget.data['location'][widget.data['location'].length - 1].length > 32 ? widget.data['location'][widget.data['location'].length - 1].substring(0,32)+'...' : widget.data['location'][widget.data['location'].length - 1],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 17,color: Color(0xff1D3557),decoration: endcheck ? TextDecoration.lineThrough : null  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //จบต้นทาง
                      SizedBox(height: 10,),
                      //เวลา
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bx_dots_vertical_rounded,
                              color: const Color(0xff1D3557),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาเริ่มต้น',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '${widget.data['starttime'][widget.data['starttime'].length - 1]} น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557),decoration: endcheck ? TextDecoration.lineThrough : null   ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เวลาสิ้นสุด',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                width: 135,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time_outlined,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(
                                      '${widget.data['endtime'][widget.data['endtime'].length - 1]} น.',
                                      style: TextStyle(fontWeight: FontWeight.w900,
                                          fontSize: 17,color: Color(0xff1D3557),decoration: endcheck ? TextDecoration.lineThrough : null   ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: endcheck,
                            onChanged: (endcheck) {
                              setState(() {
                                this.endcheck = endcheck;
                              });
                              endcheck = true;
                              check();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //จบปลายทาง
            SizedBox(height: 20,),
            // ปุ่มกดเพิ่ม
            // ปุ่มกดสร้าง
            ElevatedButton(
              /*onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                            shadowColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                        ),*/
              onPressed: () async {
                await querydatafromcancel();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Mapmain(
                  statussuccess: statussuccess,
                  statusunsuccess: statusunsuccess,
                  dataquerymap: querydata2,
                  weather : widget.weather.toString(),
                  adventure :  widget.adventure.toString(),
                  sea : widget.sea.toString(),
                  confidence: widget.confidence.toString(),
                  bagpack: widget.bagpack.toString(),
                  budget: widget.budget.toString(),
                  social : widget.social.toString(),
                ),));
              },
              style: ElevatedButton.styleFrom(
                onPrimary: const Color(0xff7BEE99),
                primary: const Color(0xff7BEE99),
                minimumSize: const Size(350, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              child: const Text(
                'ยกเลิกทริป',
                style: TextStyle(color: Color(0xff1D3557), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

}