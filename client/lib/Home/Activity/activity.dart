import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'dart:convert';

import 'package:se_app2/Home/Activity/activity_result.dart';

class activity extends StatefulWidget {
  // const activity({Key key}) : super(key: key);

  final result;
  activity({this.result});

  @override
  _activityState createState() => _activityState();
}

class _activityState extends State<activity> {


  String word = '';
  String selectid = '';

  Future activity_partner() async{

    var res = await http.post(Uri.parse('http://10.0.2.2:8080/activity/activity_partner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "name": "สวนสัตว์เปิดซาฟารีเวิลด์",
          "location": "99 ถนน ปัญญาอินทรา แขวงสามวาตะวันตก กรุงเทพมหานคร",
          "price": "750",
          "star": "4",
          "detail": "one day trip",
          "opening_day": "จันทร์ - อาทิตย์",
          "opening_time": "09.00 - 23.00",
        });
    print(res.body);
  }

  Future update_activity() async{

    print('update partner');
    List<String> hilight = ["ซาฟารีปาร์ค ซึ่งเป็นสวนสัตว์เปิด มีสัตว์ต่างๆ เช่น ม้าลาย กวาง ยีราฟ นก เสือ สิงโต หมี ฯลฯ ให้นักท่องเที่ยวได้นั่งรถชมชีวิตความเป็นอยู่ของสัตว์ตามธรรมชาติโดยรถส่วนตัว หรือรถบริการพร้อมผู้บรรยายของซาฟารีเวิลด์","มารีนปาร์ค หรือสวนน้ำ มีสัตว์น้ำ และสัตว์ชนิดต่างๆ ที่หาดูให้ชมยาก รวมทั้งการแสดงต่างๆ เช่น การแสดงของปลาโลมา, นก, แมวน้ำ และลิง เป็นต้น","การแสดงแต่ละอย่างจะเปิดให้นักท่องเที่ยวได้เข้าไปจับจองที่นั่งกัน ครึ่งชั่วโมง ก่อนการแสดงเริ่มนะค่ะ เพราะว่าฉะนั้น อยากดูการแสดงไหน ก็ต้องไปจับจองที่นั่งกันก่อน นอกจากการแสดงแล้วก็ยังมีกิจกรรมต่างๆ ให้เด็กๆ ได้สนุกกันด้วยค่ะ เช่นการขี่ม้าแคระ การถ่ายรูปกับลูกเสือ ยิงปืน โยนบ่วง และ เกมส์ต่างๆ"];
    List<String> service = ["ห้องพยาบาล","ห้องน้ำ","ที่จอดรถ","ร้านอาหาร","รถเดินทางในซาฟารี"];
    List<String> image = ["https://th.bing.com/th/id/OIP.rK1WUrjCgr9XbcMTQSqsWgHaEH?w=295&h=180&c=7&r=0&o=5&pid=1.7","https://th.bing.com/th/id/OIP.c1IWuCEIPfLbaG2esI_GWAHaE8?w=273&h=182&c=7&r=0&o=5&pid=1.7"];
    Map<String,String> data;
    data={
      "hilight[]": hilight.toString(),
      "service[]": service.toString(),
      "image[]": image.toString(),
    };
    for(int i = 0;i < hilight.length ; i++){
      data.addAll({"hilight[$i]":hilight[i]});
    }
    for(int i = 0;i < service.length ; i++){
      data.addAll({"service[$i]":service[i]});
    }
    for(int i = 0;i < image.length ; i++){
      data.addAll({"image[$i]":image[i]});
    }
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/activity/update_activity'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: data,
    );
    print(res.body);
  }

  Map dataafterquery;
  String names;
  Future queryactivity() async {
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
    print('querycar');
    names = name.text.toString();
    //กรุงเทพ
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/activity/" + names + '/queryactivity'));
    dataafterquery = json.decode(res.body);
    //print(dataafterquery);
    //print(dataafterquery['foundAcc']);
    //print(dataafterquery['foundAcc']['name']);
    // print(dataafterquery['foundAcc'][0]['name']);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_result(
      name: name.text,
      // day: day.text,
      // time: time.text,
      data : dataafterquery,

    ),));
  }

  Future queryrec() async {
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
    print('queryrec');
    //กรุงเทพ
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/activity/" + selectid + '/queryactivity'));
    dataafterquery = json.decode(res.body);
    print(dataafterquery);
    print(dataafterquery['foundAcc']);
    print(dataafterquery['foundAcc']['name']);
    // print(dataafterquery['foundAcc'][0]['name']);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_result(
      name: name.text,
      // day: day.text,
      // time: time.text,
      data : dataafterquery,

    ),));
  }

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode1 = FocusNode();
  FocusNode acFocusNode2 = FocusNode();


  List recdata;
  final name = TextEditingController();
  // final day = TextEditingController();
  // final time = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState(){
    super.initState();
    print("result");
    print(widget.result);
    // // recdata = widget.result;
    // print(recdata.length);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFFF4DC),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff1D3557),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () =>  Navigator.pushNamed(
                context, '/Navi',
              ),
            ),
            title: const Text(
              'กิจกรรม',
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
        body:SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("เลือกสถานที่หรือชื่อกิจกรรม",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              width: 350,
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: const Color(0xff1D3557), width: 2)),
                              child: TextFormField(
                                controller: name,
                                decoration: const InputDecoration(
                                    hintText: 'สถานที่ หรือ กิจกรรมที่ต้องการเข้าร่วม ',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xffECFAFF))),
                                    suffixIcon:
                                    Icon(Icons.search, color: Color(0xff1D3557))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุสถานที่';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode,
                                onChanged: (value) {
                                  word = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Text("วันที่เข้าร่วม",
                      //               style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.normal,
                      //                   color: Color(0xff1D3557))),
                      //           const SizedBox(height: 5),
                      //           Container(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16, vertical: 2),
                      //             width: 150,
                      //             decoration: BoxDecoration(
                      //                 color: const Color(0xffECFAFF),
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 border: Border.all(
                      //                     color: const Color(0xff1D3557), width: 2)),
                      //             child: TextFormField(
                      //               controller: day,
                      //               readOnly: true,
                      //               decoration: const InputDecoration(
                      //                   hintText: 'วว-ดด-ปปปป',
                      //                   enabledBorder: UnderlineInputBorder(
                      //                       borderSide:
                      //                       BorderSide(color: Color(0xffECFAFF))),
                      //                   suffixIcon: Icon(Ionicons.calendar_outline,
                      //                       color: Color(0xff1D3557))),
                      //               validator: (value) {
                      //                 if (value == null || value.isEmpty) {
                      //                   return 'กรุณาระบุวันที่';
                      //                 }
                      //                 return null;
                      //               },
                      //               focusNode: acFocusNode1,
                      //               onTap: () async {
                      //                 DateTime pickedDate = await showDatePicker(
                      //                     context: context,
                      //                     initialDate: DateTime.now(),
                      //                     firstDate: DateTime(2000),
                      //                     lastDate: DateTime(2101));
                      //
                      //                 if (pickedDate != null) {
                      //                   print(pickedDate);
                      //                   String formattedDate =
                      //                   DateFormat('dd-MM-yyyy')
                      //                       .format(pickedDate);
                      //                   print(formattedDate);
                      //
                      //                   setState(() {
                      //                     day.text = formattedDate;
                      //                   });
                      //                 } else {
                      //                   print("Date is not selected");
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Text("เวลาที่เข้าร่วม",
                      //               style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.normal,
                      //                   color: Color(0xff1D3557))),
                      //           const SizedBox(height: 5),
                      //           Container(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16, vertical: 2),
                      //             width: 150,
                      //             decoration: BoxDecoration(
                      //                 color: const Color(0xffECFAFF),
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 border: Border.all(
                      //                     color: const Color(0xff1D3557), width: 2)),
                      //             child: TextFormField(
                      //               controller: time,
                      //               readOnly: true,
                      //               decoration: const InputDecoration(
                      //                   hintText: '00:00',
                      //                   enabledBorder: UnderlineInputBorder(
                      //                       borderSide:
                      //                       BorderSide(color: Color(0xffECFAFF))),
                      //                   suffixIcon: Icon(Ionicons.calendar_outline,
                      //                       color: Color(0xff1D3557))),
                      //               validator: (value) {
                      //                 if (value == null || value.isEmpty) {
                      //                   return 'กรุณาระบุวันที่';
                      //                 }
                      //                 return null;
                      //               },
                      //               focusNode: acFocusNode2,
                      //               onTap: () async {
                      //                 TimeOfDay pickedTime =  await showTimePicker(
                      //                   initialTime: TimeOfDay.now(),
                      //                   context: context,
                      //                 );
                      //                 FocusScope.of(context)
                      //                     .requestFocus(FocusNode());
                      //
                      //                 if(pickedTime != null ){
                      //                   DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //                   String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      //                   time.text = formattedTime.toString();
                      //
                      //                 }else{
                      //                   print("Time is not selected");
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: ElevatedButton(
                          onPressed: () async=> {
                            // activity_partner(),
                            // update_activity()
                            queryactivity(),
                          },
                          style: ElevatedButton.styleFrom(
                            onPrimary: const Color(0xff1D3557),
                            primary: const Color(0xff1D3557),
                            minimumSize: const Size(350, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          child: const Text(
                            'ค้นหากิจกรรม',
                            style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Divider(
                          thickness: 1.5,
                          // indent: 25,
                          // endIndent: 25,
                          color: Color(0xff827E7E),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 15, left: 30),
                            child: const Text(
                              "กำลังเป็นที่นิยม",
                              style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                            ),
                          ),
                          SizedBox(
                            height: 150.0,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: const EdgeInsets.only( left: 20, right: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.result == null ? 0 : widget.result.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectid = widget.result[index]["name"];
                                    queryrec();
                                  },
                                  child: Card(
                                    child: Container(
                                      width: 280,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${widget.result[index]['image'][0]}"),
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black54, BlendMode.darken)),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "THB ${widget.result[index]['price']}",
                                                  style: TextStyle(
                                                      color: Color(0xffECFAFF),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // _buildRatingStars(5),
                                                Text(
                                                  "${widget.result[index]['name']}",
                                                  style: TextStyle(
                                                      color: Color(0xffECFAFF),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 5),
                                                      child: Icon(Icons.location_pin,
                                                          color: Color(0xffECFAFF),
                                                          size: 18),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${widget.result[index]['location']}",
                                                        style: TextStyle(
                                                            color: Color(0xffECFAFF),
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )

        )

    );
  }
}