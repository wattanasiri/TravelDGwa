import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se_app2/Data/data_currentuser.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:se_app2/navigator/nav/profile/partnership/partner/activity/activity_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class activity_register3 extends StatefulWidget {
  activity_register3({this.name,this.number,this.email,this.activityName,this.address,this.number_address,this.province,this.district,this.post_code,this.price});
  var name,number,email,activityName,address,number_address,province,district,post_code,price;
  @override
  _activity_register3State createState() => _activity_register3State();
}

class _activity_register3State extends State<activity_register3> {

  String word = '';
  String dayopen ;
  String dayopen2 ;
  String dropdownValue = 'อาทิตย์';
  var numinfo=1;
  var numservice=1;

  File imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();


  List<TextEditingController> info = [];
  List<TextEditingController> service = [];
  final detail = TextEditingController();
  final _timegetcarcontroller = TextEditingController();
  final _timegetcarcontroller2 = TextEditingController();

  _getFromGallery(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    print(imageFile);
  }
  String fileNames;
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = path.basename(imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child('/$fileName');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
    fileNames = fileName.toString();
  }

  Future activity_partner() async{

    var res = await http.post(Uri.parse('http://10.0.2.2:8080/activity/activity_partner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "name": widget.activityName,
          "location": widget.number_address + widget.address + widget.province + widget.district + widget.post_code,
          "price": widget.price,
          "star": "0",
          "detail": detail.text,
          "opening_day": dayopen.toString()+"-"+dayopen2.toString(),
          "opening_time": _timegetcarcontroller.text+"-"+_timegetcarcontroller2.text,
          "image": fileNames.toString(),
        });
    print(res.body);
  }

  Future update_activity() async{

    print('update partner');
    // List<String> hilight = ["ซาฟารีปาร์ค ซึ่งเป็นสวนสัตว์เปิด มีสัตว์ต่างๆ เช่น ม้าลาย กวาง ยีราฟ นก เสือ สิงโต หมี ฯลฯ ให้นักท่องเที่ยวได้นั่งรถชมชีวิตความเป็นอยู่ของสัตว์ตามธรรมชาติโดยรถส่วนตัว หรือรถบริการพร้อมผู้บรรยายของซาฟารีเวิลด์","มารีนปาร์ค หรือสวนน้ำ มีสัตว์น้ำ และสัตว์ชนิดต่างๆ ที่หาดูให้ชมยาก รวมทั้งการแสดงต่างๆ เช่น การแสดงของปลาโลมา, นก, แมวน้ำ และลิง เป็นต้น","การแสดงแต่ละอย่างจะเปิดให้นักท่องเที่ยวได้เข้าไปจับจองที่นั่งกัน ครึ่งชั่วโมง ก่อนการแสดงเริ่มนะค่ะ เพราะว่าฉะนั้น อยากดูการแสดงไหน ก็ต้องไปจับจองที่นั่งกันก่อน นอกจากการแสดงแล้วก็ยังมีกิจกรรมต่างๆ ให้เด็กๆ ได้สนุกกันด้วยค่ะ เช่นการขี่ม้าแคระ การถ่ายรูปกับลูกเสือ ยิงปืน โยนบ่วง และ เกมส์ต่างๆ"];
    // List<String> service = ["ห้องพยาบาล","ห้องน้ำ","ที่จอดรถ","ร้านอาหาร","รถเดินทางในซาฟารี"];
    // List<String> image = ["https://th.bing.com/th/id/OIP.rK1WUrjCgr9XbcMTQSqsWgHaEH?w=295&h=180&c=7&r=0&o=5&pid=1.7","https://th.bing.com/th/id/OIP.c1IWuCEIPfLbaG2esI_GWAHaE8?w=273&h=182&c=7&r=0&o=5&pid=1.7"];
    Map<String,String> data;
    data={
      "hilight[]": info.toString(),
      "service[]": service.toString(),
      // "image[]": imageFile.toString(),
    };
    for(int i = 0;i < numinfo ; i++){
      data.addAll({"hilight[$i]":info[i].text});
    }
    for(int i = 0;i < numservice ; i++){
      data.addAll({"service[$i]":service[i].text});
    }
    // for(int i = 0;i < image.length ; i++){
    //   data.addAll({"image[$i]":image[i]});
    // }
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/activity/update_activity'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: data,
    );
    print(res.body);
  }

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
              onPressed: () =>  Navigator.pushNamed(
                context, '/Navi',
              ),
            ),
            title: const Text(
              'สมัครพาร์ทเนอร์กิจกรรม',
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
                          const Text("ประเภทกิจกรรม",
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
                                controller: detail,
                                decoration: const InputDecoration(
                                  hintText: 'ประเภทกิจกรรม',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุประเภทกิจกรรม';
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("รูปภาพ ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              child: imageFile != null
                                  ?ClipRect(
                                child: Image.file(imageFile),
                              )
                                  :Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                width: 350,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color(0xff1D3557), width: 2)),
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    _getFromGallery(context);
                                  },
                                ),


                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("รายละเอียดสถานที่",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numinfo,
                              itemBuilder:  (BuildContext context, int index){
                                info.add(new TextEditingController());
                                return GestureDetector(
                                  child: Column(
                                    children: [
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
                                          controller: info[index],
                                          decoration: const InputDecoration(
                                            hintText: 'รายละเอียดสถานที่',
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Color(0xffECFAFF))),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'กรุณาระบุรายละเอียดสถานที่';
                                            }
                                            return null;
                                          },
                                          autofocus: false,
                                          onChanged: (value) {
                                            word = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),);
                              },
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle,
                                    color: Color(0xff1D3557),),
                                  Text("เพิ่มรายละเอียดสถานที่",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1D3557)))
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  print("Setting state");
                                  numinfo++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("สิ่งอำนวยความสะดวก",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numservice,
                              itemBuilder:  (BuildContext context, int index){
                                service.add(new TextEditingController());
                                return GestureDetector(
                                  child: Column(
                                    children: [
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
                                          controller: service[index],
                                          decoration: const InputDecoration(
                                            hintText: 'สิ่งอำนวยความสะดวก',
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Color(0xffECFAFF))),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'กรุณาระบุสิ่งอำนวยความสะดวก';
                                            }
                                            return null;
                                          },
                                          autofocus: false,
                                          onChanged: (value) {
                                            word = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),);
                              },
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle,
                                    color: Color(0xff1D3557),),
                                  Text("เพิ่มสิ่งอำนวยความสะดวก",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1D3557)))
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  print("Setting state");
                                  numservice++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("เวลาเปิด-ปิด",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffECFAFF),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color(0xff1D3557), width: 2)),
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                      hintText: ' 00:00',
                                      prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                      errorStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value == null) {
                                        return 'กรุณาระบุเวลารับรถ';
                                      }
                                      return null;
                                    },
                                    controller: _timegetcarcontroller,
                                    focusNode: acFocusNode2,
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
                                        _timegetcarcontroller.text = formattedTime.toString();

                                      }else{
                                        print("Time is not selected");
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffECFAFF),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color(0xff1D3557), width: 2)),
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                      hintText: ' 00:00',
                                      prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                                      errorStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value == null) {
                                        return 'กรุณาระบุเวลารับรถ';
                                      }
                                      return null;
                                    },
                                    controller: _timegetcarcontroller2,
                                    focusNode: acFocusNode3,
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
                                        _timegetcarcontroller2.text = formattedTime.toString();

                                      }else{
                                        print("Time is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("วันทำการ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffECFAFF),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color(0xff1D3557), width: 2)),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today_rounded,color: Color(0xff1D3557),),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    hint: const Text('วันทำการ',style: TextStyle(color: Color(0xff1D3557)),),
                                    value: dayopen,
                                    focusNode: acFocusNode4,
                                    iconSize: 16,
                                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xff1D3557),),
                                    isExpanded: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dayopen = newValue;
                                      });
                                    },
                                    items: <String>['อาทิตย์','จันทร์','อังคาร','พุธ','พฤหัสบดี','ศุกร์','เสาร์'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffECFAFF),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color(0xff1D3557), width: 2)),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today_rounded,color: Color(0xff1D3557),),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    hint: const Text('วันทำการ',style: TextStyle(color: Color(0xff1D3557)),),
                                    value: dayopen2,
                                    focusNode: acFocusNode5,
                                    iconSize: 16,
                                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xff1D3557),),
                                    isExpanded: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dayopen2 = newValue;
                                      });
                                    },
                                    items: <String>['อาทิตย์','จันทร์','อังคาร','พุธ','พฤหัสบดี','ศุกร์','เสาร์'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
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
                        child: ElevatedButton(
                          onPressed: () async=> {
                            activity_partner(),
                            uploadImageToFirebase(context),
                            update_activity(),
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_request(

                            ),)),
                          },
                          style: ElevatedButton.styleFrom(
                            animationDuration: const Duration(milliseconds: 1000),
                            onPrimary: const Color(0xffECFAFF),
                            primary: const Color(0xff1D3557),
                            minimumSize: const Size(350, 55),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          child: const Text(
                            'สมัครเป็นพาร์ทเนอร์กิจกรรม',
                            style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                )
              ],
            )

        )

    );
  }
}
