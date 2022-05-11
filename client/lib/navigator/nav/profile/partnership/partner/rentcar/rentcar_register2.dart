import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'dart:io';
import 'package:path/path.dart'as path;
import 'package:se_app2/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/rentcar/rentcar_register3.dart';

class rentcar_register2 extends StatefulWidget {
  rentcar_register2({this.name,this.address,this.company,this.number,this.email,this.province});
  var name,address,company,number,email,province;


  @override
  _rentcar_register2State createState() => _rentcar_register2State();
}

class _rentcar_register2State extends State<rentcar_register2> {
  String word = '';
  String dayopen ;
  String dayopen2 ;
  String dropdownValue = 'อาทิตย์';
  var numinfo = 1;

  File imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();
  FocusNode acFocusNode8 = FocusNode();

  final _timegetcarcontroller = TextEditingController();
  final _timegetcarcontroller2 = TextEditingController();
  final district = TextEditingController();
  final info = TextEditingController();
  List<TextEditingController> _controllers = [];
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
  Future next() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(widget.name);
    print(dayopen);
    print(dayopen2);
    print(fileNames);
    for(int i=0;i<_controllers.length;i++)print(_controllers[i].text);
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        rentcar_register3(
          name: widget.name,
          address: widget.address,
          company: widget.company,
          number : widget.number,
          email : widget.email,
          province : widget.province,
          timegetcarcontroller : _timegetcarcontroller.text,
          timegetcarcontroller2 : _timegetcarcontroller2.text,
          dayopen : dayopen.toString(),
          dayopen2 : dayopen2.toString(),
          document : _controllers,
        ),));

  }

  // Future save_partner() async {
  //   var _prefs = await SharedPreferences.getInstance();
  //   var token = _prefs.get('token');
  //   String username = '';
  //   print('savepartner');
  //
  //   fileName = fileName.split("/")[-1];
  //   print(fileName);
  //   var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/register_rentcarpartner'),
  //       headers:{
  //         'Context-Type': 'application/json;charSet=UTF-8',
  //         'Accept': 'application/json;charSet=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: <String, String>{
  //         "usernameID" : '$token',
  //         "companyName": widget.company,
  //         "phone": widget.number.toString(),
  //         "email": widget.email,
  //         "dayopen": dayopen.toString(),
  //         "dayopen2" : dayopen2.toString(),
  //         "timeopen": _timegetcarcontroller.text,
  //         "timeopen2" : _timegetcarcontroller2.text,
  //         "image" : fileName.toString(),
  //         // "imagecompany": widget.imagecompany,
  //       });
  //   print(res.body);
  // }

  Future update_partner() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('update partner');
    for(int i = 0;i < numinfo ; i++){
      print({"document[$i]":_controllers[i].text});
    }
    List<String> name;

    // print(fileNames);
    // fileNames = fileNames.split("/").last;
    print(fileNames);
    List<String> name_extrapay = ["05:30 - 08.59","21:01 - 23:59","บริการรับส่งนอกสถานที่"];
    List<String> price_extrapay = ["300","300","100"];
    // List<String> image = ["https://www.luvdrive.com/assets/img/logo/new-logo.png","https://lh5.googleusercontent.com/p/AF1QipNf5_4r5eeUBPNb_sT5IcZ7u_luULYk5L2iFJBe=w1080-k-no"];
    Map<String,String> data;
    data={
      "name[]": name.toString(),
      "document[]": _controllers.toString(),
      "name_extrapay[]": name_extrapay.toString(),
      "price_extrapay[]": price_extrapay.toString(),
    };
    int a=0;
    data.addAll({"name[$a]":widget.company});a++;
    data.addAll({"name[$a]":widget.number});a++;
    data.addAll({"name[$a]":widget.email});a++;
    data.addAll({"name[$a]":dayopen.toString()});a++;
    data.addAll({"name[$a]":dayopen2.toString()});a++;
    data.addAll({"name[$a]":_timegetcarcontroller.text});a++;
    data.addAll({"name[$a]":_timegetcarcontroller2.text});a++;
    data.addAll({"name[$a]":fileNames.toString()});
    // print(numinfo.toString());

    for(int i = 0;i < name_extrapay.length ; i++){
      data.addAll({"name_extrapay[$i]":name_extrapay[i]});
    }
    for(int i = 0;i < price_extrapay.length ; i++){
      data.addAll({"price_extrapay[$i]":price_extrapay[i]});
    }
    for(int i = 0;i < numinfo ; i++){
      data.addAll({"document[$i]":_controllers[i].text});
    }
    // "image": imageFile.toString(),
    // for(int i = 0;i < image.length ; i++){
    //   data.addAll({"image[$i]":image[i]});
    // }
    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/update_register_rentcarpartner'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
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
              'สมัครพาร์ทเนอร์รถรับ - ส่ง',
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
                            const Text("รูปภาพบริษัท ",
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
                      const SizedBox(height: 10),
                      //
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
                                    focusNode: acFocusNode2,
                                    validator: (value) {
                                      if (value.isEmpty || value == null) {
                                        return 'กรุณาระบุวัน';
                                      }
                                      return null;
                                    },
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
                                    focusNode: acFocusNode3,
                                    validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'กรุณาระบุวัน';
                                    }
                                    return null;
                                  },
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
                                    focusNode: acFocusNode4,
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
                                    focusNode: acFocusNode5,
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
                            const Text("เอกสารประกอบการเช่าที่แจ้งต่อลูกค้า",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numinfo,
                              itemBuilder: (BuildContext context, int index) {
                                _controllers.add(new TextEditingController());
                                return GestureDetector(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 2),
                                        width: 350,
                                        // height: 150,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffECFAFF),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: const Color(0xff1D3557), width: 2)),
                                        child: TextFormField(
                                          controller:   _controllers[index],
                                          decoration: const InputDecoration(
                                            hintText: 'ข้อมูลที่แจ้งต่อลูกค้า',
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Color(0xffECFAFF))),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'กรุณาระบุข้อมูลที่แจ้งต่อลูกค้า';
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
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle,
                                    color: Color(0xff1D3557),),
                                  Text("เพิ่มข้อมูลที่แจ้งลูกค้า",
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

                      SizedBox(height: 10,),
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
                            next(),
                            await uploadImageToFirebase(context),
                            // await save_partner(),
                            await update_partner(),
                            // activity_partner(),
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
                            'ถัดไป',
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
