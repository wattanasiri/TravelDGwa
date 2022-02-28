import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'dart:convert';

import 'package:se_app2/Home/Activity/activity_result.dart';

class activity extends StatefulWidget {
  const activity({Key key}) : super(key: key);

  @override
  _activityState createState() => _activityState();
}

class _activityState extends State<activity> {


  String word = '';

  Future activity_partner() async{

    var res = await http.post(Uri.parse('http://10.0.2.2:8080/activity/activity_partner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "name": "Health Land Pradit Manutham Spa Treatments",
          "location": "288 ถนนประดิษฐ์มนูธรรม แขวงพลับพลา, เขตวังทองหลาง, กรุงเทพมหานคร 10310 ",
          "price": "600",
          "star": "5",
          "opening_day": "จันทร์ - อาทิตย์",
          "opening_time": "09.00 - 21.00",
        });
    print(res.body);
  }
  
  Future update_activity() async{

    print('update partner');
    List<String> hilight = ["จองช่วงเวลาที่คุณต้องการได้อย่างง่ายดายเพื่อเพลิดเพลินกับทรีตเมนต์ที่ดีที่สุดที่ Health Land","ฟื้นฟูร่างกาย จิตใจ และจิตวิญญาณด้วยการนวดผ่อนคลายโดยใช้เทคนิคไทย อโรมา หรืออายุรเวท","คืนความอ่อนเยาว์ให้กับผิวหน้าด้วยทรีตเมนต์พิเศษที่เน้นดวงตา ริ้วรอย ร่องลึก และอื่นๆ","สัมผัสความสมบูรณ์แบบของสุขภาพและความสมบูรณ์ของร่างกายที่ Health Land Spa ใกล้บ้านคุณทั่วประเทศ"];
    List<String> service = ["ห้องพยาบาล","ห้องน้ำ","ที่จอดรถ","Wi - Fi","ห้องเปลี่ยนเสื้อผ้า"];
    List<String> image = ["https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/2000785513283/Health%2520Land%2520Pradit%2520Manutham%2520Spa%2520Treatments-f3388649-4fee-4630-8c1c-cec1fd1f36f7.jpeg?_src=imagekit&tr=c-at_max","https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/2000785513256/Health%2520Land%2520Rama%25202%2520Spa%2520Treatments-d86bb661-a1a4-49d0-9e1d-f535f923a928.jpeg?_src=imagekit&tr=dpr-3"];
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



  final name = TextEditingController();
  // final day = TextEditingController();
  // final time = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
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
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15, left: 30),
                        child: const Text(
                          "พักผ่อนกายสบายใจ",
                          style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                        ),
                      ),
                      SizedBox(
                        height: 150.0,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15, left: 30),
                        child: const Text(
                          "เที่ยวเกาะหนีคนใจร้าย ;-;",
                          style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                        ),
                      ),
                      SizedBox(
                        height: 150.0,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://placeimg.com/640/480/any'),
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
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'THB ' + '399.00',
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
                                            const Text(
                                              'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              children: const <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.location_pin,
                                                      color: Color(0xffECFAFF),
                                                      size: 18),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    'รัชดา, กรุงเทพมหานคร',
                                                    style: TextStyle(
                                                        color: Color(0xffECFAFF),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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