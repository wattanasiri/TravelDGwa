import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'package:se_app2/Home/Attraction/tourism_result.dart';

import '../../Data/data_locations.dart';
import 'Trip_detail.dart';


class tripedit extends StatefulWidget {
  List<dynamic> data;
  var alltime,title;
  Map dataquerymap;
  String weather,adventure,sea,confidence,bagpack,budget,social ;
  tripedit({this.weather,this.adventure,this.sea,this.confidence,this.social,this.bagpack,this.budget,this.data,this.alltime,this.title,this.dataquerymap});

  @override

  _tripeditState createState() => _tripeditState();
}

class _tripeditState extends State<tripedit> {
  // Generating a long list to fill the ListView
  final List<Map> checkbox = List.generate(100,
          (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});

  //เอาไว้สร้างตัวระหว่างทางเพิ่ม
  int btw = 2;
  //เอาไว้สร้างตัวระหว่างทางเพิ่ม
  var currentstarttime,currentendtime;
  Datalocation datalocation = Datalocation();
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
          actions: [
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => tripdetail(
                  data: widget.data,
                  alltime: widget.alltime,
                  title: widget.title,
                  dataquerymap: widget.dataquerymap,
                  weather : widget.weather,
                  adventure :  widget.adventure,
                  sea : widget.sea,
                  confidence: widget.confidence,
                  bagpack: widget.bagpack,
                  budget: widget.budget,
                  social : widget.social,
                ),));
              },
              child: Text(
                'บันทึก',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7BEE99),
                ),
              ),)
          ],
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
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1D3557),
                            ),
                          ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Boxicons.bxs_edit_alt,
                              color: Color(0xff1D3557),
                            ),
                            onPressed: () {},
                          ),
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
                      SizedBox(width: 2,),
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
                              widget.alltime + ' น.',
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

            SizedBox(height: 10,),
            //ต้นทาง
            Column(
              children: [
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Boxicons.bxs_circle,
                                  color: const Color(0xff1BC3FF),
                                  size: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ต้นทาง',
                                    style: TextStyle(fontWeight: FontWeight.w900,
                                        fontSize: 15,color: Color(0xff1D3557) ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 2),
                                    width: 320,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffECFAFF),
                                      border: Border.all(color: const Color(0xff1D3557), width: 4),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: const Offset(2, 4),
                                        ),
                                      ],
                                      /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                                    child: TextFormField(
                                      initialValue: widget.data[0]['name'],
                                      decoration: InputDecoration(
                                        hintText: widget.data[0]['name'],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Color(0xffECFAFF))),
                                        /*suffixIcon:
                                          Icon(Icons.search, color: Color(0xff1D3557))*/
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณาระบุสถานที่ต้นทาง';
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (value) {
                                        print('1');
                                        print(value);
                                        currentstarttime =  widget.data[0]['starttime'];
                                        currentendtime = widget.data[0]['endtime'];
                                        for (int i = 0; i < datalocation.location.length; i++) {
                                          if(value == datalocation.location[i]['name']) {
                                            widget.data[0] = datalocation.location[i];
                                          }
                                        }
                                        widget.data[0]['starttime'] = currentstarttime;
                                        widget.data[0]['endtime'] = currentendtime;
                                        //word = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                          width: 140,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffECFAFF),
                            border: Border.all(color: const Color(0xff1D3557), width: 4),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            decoration:InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              hintText:  widget.data[0]['starttime'],
                              prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'กรุณาระบุเวลา';
                              }
                              return null;
                            },
                            //controller: _timegetcarcontroller,
                            //focusNode: myFocusNode2,
                            onTap: () async {
                              TimeOfDay pickedTime =  await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());

                              if(pickedTime != null ){
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                //_timegetcarcontroller.text = formattedTime.toString();
                                widget.data[0]['starttime'] = formattedTime;

                              }else{
                                print("Time is not selected");
                              }
                            },
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
                          width: 140,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffECFAFF),
                            border: Border.all(color: const Color(0xff1D3557), width: 4),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              hintText: widget.data[0]['endtime'],
                              prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'กรุณาระบุเวลา';
                              }
                              return null;
                            },
                            //controller: _timegetcarcontroller,
                            //focusNode: myFocusNode2,
                            onTap: () async {
                              TimeOfDay pickedTime =  await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());

                              if(pickedTime != null ){
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                //_timegetcarcontroller.text = formattedTime.toString();
                                widget.data[0]['endtime'] = formattedTime;
                              }else{
                                print("Time is not selected");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Icon(Boxicons.bxs_trash,
                        color: const Color(0xffFFF4DC),
                        size: 30),
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
                itemCount: widget.data.length-2,
                itemBuilder: (context,index){
                  return  Column(
                    children: [
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Boxicons.bxs_circle,
                                        color: const Color(0xffFF9A62),
                                        size: 30),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ระหว่างทาง',
                                          style: TextStyle(fontWeight: FontWeight.w900,
                                              fontSize: 15,color: Color(0xff1D3557) ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 2),
                                          width: 320,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffECFAFF),
                                            border: Border.all(color: const Color(0xff1D3557), width: 4),
                                            borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(2, 4),
                                              ),
                                            ],
                                            /*border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)*/),
                                          child: TextFormField(
                                            //controller: name,
                                            initialValue:widget.data[index+1]['name'] ,
                                            decoration: InputDecoration(
                                              hintText: widget.data[index+1]['name'],
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Color(0xffECFAFF))),
                                              /*suffixIcon:
                                          Icon(Icons.search, color: Color(0xff1D3557))*/
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'กรุณาระบุสถานที่ระหว่างทาง';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (value) {
                                              print('1');
                                              print(value);
                                              currentstarttime =  widget.data[index+1]['starttime'];
                                              currentendtime = widget.data[index+1]['endtime'];
                                              for (int i = 0; i < datalocation.location.length; i++) {
                                                if(value == datalocation.location[i]['name']) {
                                                  widget.data[index+1] = datalocation.location[i];
                                                }
                                              }
                                              widget.data[index+1]['starttime'] = currentstarttime;
                                              widget.data[index+1]['endtime'] = currentendtime;
                                              //word = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //จบระหว่างทาง
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
                                width: 140,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  border: Border.all(color: const Color(0xff1D3557), width: 4),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    hintText: widget.data[index+1]['starttime'],
                                    prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'กรุณาระบุเวลา';
                                    }
                                    return null;
                                  },
                                  //controller: _timegetcarcontroller,
                                  //focusNode: myFocusNode2,
                                  onTap: () async {
                                    TimeOfDay pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    if(pickedTime != null ){
                                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                      //_timegetcarcontroller.text = formattedTime.toString();
                                      widget.data[index+1]['starttime'] = formattedTime;
                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
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
                                width: 140,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  border: Border.all(color: const Color(0xff1D3557), width: 4),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    hintText: widget.data[index+1]['endtime'],
                                    prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'กรุณาระบุเวลา';
                                    }
                                    return null;
                                  },
                                  //controller: _timegetcarcontroller,
                                  //focusNode: myFocusNode2,
                                  onTap: () async {
                                    TimeOfDay pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    if(pickedTime != null ){
                                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                      //_timegetcarcontroller.text = formattedTime.toString();
                                      widget.data[index+1]['endtime'] = formattedTime;
                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20,),
                          // Icon(Boxicons.bxs_trash,
                          //     color: const Color(0xffF24E1E),
                          //     size: 30),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                }
            ), //จบเวลา
            /*SizedBox(height: 20,),
            //ปุ่มสร้างที่แวะเพิ่ม
            ElevatedButton(
              /*onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                            shadowColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                        ),*/
              onPressed: () {
                setState(() {
                  btw++;
                });
              },
              style: ElevatedButton.styleFrom(
                onPrimary: const Color(0xff1D3557),
                primary: const Color(0xff1D3557),
                minimumSize: const Size(100, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              child: const Text(
                'เพิ่มที่แวะระหว่างทาง',
                style: TextStyle(color: Color(0xffECFAFF), fontSize: 20),
              ),
            ),
            SizedBox(height: 10,),*/
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Boxicons.bxs_been_here,
                              color: const Color(0xffFF0000),
                              size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ปลายทาง',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 15,color: Color(0xff1D3557) ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                width: 320,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  border: Border.all(color: const Color(0xff1D3557), width: 4),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                  /*border: Border.all(
                                    color: const Color(0xff1D3557), width: 2)*/),
                                child: TextFormField(
                                  //controller: name,
                                  initialValue: widget.data[widget.data.length - 1]['name'],
                                  decoration: InputDecoration(
                                    hintText: widget.data[widget.data.length - 1]['name'],
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xffECFAFF))),
                                    /*suffixIcon:
                                      Icon(Icons.search, color: Color(0xff1D3557))*/
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุสถานที่ต้นทาง';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    currentstarttime =  widget.data[widget.data.length - 1]['starttime'];
                                    currentendtime = widget.data[widget.data.length - 1]['endtime'];
                                    for (int i = 0; i < datalocation.location.length; i++) {
                                      if(value == datalocation.location[i]['name']) {
                                        widget.data[widget.data.length - 1] = datalocation.location[i];
                                      }
                                    }
                                    widget.data[widget.data.length - 1]['starttime'] = currentstarttime;
                                    widget.data[widget.data.length - 1]['endtime'] = currentendtime;
                                    //word = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                      width: 140,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        border: Border.all(color: const Color(0xff1D3557), width: 4),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          hintText: widget.data[widget.data.length - 1]['starttime'],
                          prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent)),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'กรุณาระบุเวลา';
                          }
                          return null;
                        },
                        //controller: _timegetcarcontroller,
                        //focusNode: myFocusNode2,
                        onTap: () async {
                          TimeOfDay pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          FocusScope.of(context)
                              .requestFocus(FocusNode());

                          if(pickedTime != null ){
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            //_timegetcarcontroller.text = formattedTime.toString();
                            widget.data[widget.data.length - 1]['starttime'] = formattedTime;

                          }else{
                            print("Time is not selected");
                          }
                        },
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
                      width: 140,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffECFAFF),
                        border: Border.all(color: const Color(0xff1D3557), width: 4),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          hintText: widget.data[widget.data.length - 1]['endtime'],
                          prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent)),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'กรุณาระบุเวลา';
                          }
                          return null;
                        },
                        //controller: _timegetcarcontroller,
                        //focusNode: myFocusNode2,
                        onTap: () async {
                          TimeOfDay pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          FocusScope.of(context)
                              .requestFocus(FocusNode());

                          if(pickedTime != null ){
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            //_timegetcarcontroller.text = formattedTime.toString();
                            widget.data[widget.data.length - 1]['endtime'] = formattedTime;

                          }else{
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Icon(Boxicons.bxs_trash,
                    color: const Color(0xffFFF4DC),
                    size: 30),
              ],
            ),
            //จบปลายทาง
          ],
        ),
      ),
    );
  }

}