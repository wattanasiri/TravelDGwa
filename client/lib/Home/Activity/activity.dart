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
          "name": "มหานคร สกายวอล์ค",
          "location": "มหานคร สกายวอล์ค อาคาร คิง เพาเวอร์ มหานคร (King Power Mahanakhon) ตั้งอยู่ที่ถนนนราธิวาสราชนครินทร์ แขวงสีลม เขตบางรัก",
          "price": "690",
          "star": "5",
          "opening_day": "จันทร์ - อาทิตย์",
          "opening_time": "10.00 - 24.00",
        });
    print(res.body);
  }
  
  Future update_activity() async{

    print('update partner');
    List<String> hilight = ["ชมทิวทัศน์ของเมืองหลวงที่ไม่มีวันหลับไหลแบบ 360 องศา บนอาคารที่สูงที่สุดในประเทศไทยด้วยความสูงกว่า 314 เมตร นอกจากการได้ชมวิวทิวทัศน์ขรอบเมืองกรุงเทพฯแล้ว คุณจะได้พบกับสิ่งมหัศจรรย์ต่างๆ ไม่ว่าจะเป็นลิฟท์ความเร็วสูงที่จะพาคุณขึ้นไปชั้น 74 ภายใน 50 วินาที ประกอบกับการชมวิดีโอเสมือนจริงแบบรอบทิศทาง, ตู้ไปรษณีย์ที่สูงที่สุดในประเทศไทย และพื้นกระจกใสที่ทำให้คุณได้มองเห็นพื้นข้างล่างเสมือนลอยอยู่กลางอากาศ สัมผัสประสบการณ์ที่ไม่เหมือนใครได้ที่มหานครสกายวอล์ค","ภายในชั้น 74 ยังมีร้านไอศกรีม และร้านชานมไข่มุก ไว้คอยบริการคนที่ท้องว่างอยู่ หรือถ้าอยากมีระดับขึ้นไปกว่านี้ เราแนะนำสกายบาร์ที่ชั้น 78 มีเครื่องดื่ม/ค๊อกเทลมากมายให้เลือกสรร","ไทย เทสต์ ฮับ มหานคร คิวบ์ ตั้งอยู่ที่บริเวณชั้น 1 ของตึกมหานคร คิวบ์ ที่เชื่อมต่อกับรถไฟฟ้าบีทีเอส สถานีช่องนนทรี (ทางออก3) เป็นสตรีทฟู้ดแห่งใหม่ที่อยู่ใจกลางเมืองย่านสาทร-สีลม ครั้งแรกกับการรวบรวมร้านอาหารชื่อดังของเมืองไทยที่การันตีความอร่อยจากมิชลิน เช่น ร้านเผ็ดเผ็ดเฮ่! , ลิ้ม เหล่า ซา , ผัดไทไฟทะลุ และยังมีให้เลือกถึง 12 ร้านด้วยกัน ให้บริการตั้งแต่ 10:00 - 20:30 น."];
    List<String> service = ["ห้องพยาบาล","ห้องน้ำ","ที่จอดรถ","Wi - Fi","ลิฟต์"];
    List<String> image = ["https://th.bing.com/th/id/OIP.tYIM25JsvJ-jh0_okPGomwHaE8?w=288&h=192&c=7&r=0&o=5&pid=1.7","https://th.bing.com/th/id/OIP.NVmUE1p25iRxoo7YKcxgTAHaE8?pid=ImgDet&rs=1"];
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
    word = selectid;
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('querycar');
    names = name.text.toString();
    //กรุงเทพ
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/activity/" + names + '/queryactivity'));
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
            onPressed: () => Navigator.of(context).pop(),
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
                        activity_partner(),
                        update_activity()
                        // queryactivity(),
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
                                selectid = widget.result[index]["_id"];
                                queryactivity();
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