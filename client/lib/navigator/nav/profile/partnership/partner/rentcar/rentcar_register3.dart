import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:se_app2/navigator/nav/profile/partnership/partner/rentcar/rentcar_request.dart';
class rentcar_register3 extends StatefulWidget {
  rentcar_register3({this.imagecompany,this.province,this.name,this.address,this.company,this.number,this.email,this.dayopen,this.dayopen2,this.timegetcarcontroller,this.timegetcarcontroller2,this.document});
  var name,address,company,number,email,timegetcarcontroller,timegetcarcontroller2,dayopen,dayopen2,province;
  List<TextEditingController> document ;
  File imagecompany;
  @override
  _rentcar_register3State createState() => _rentcar_register3State();
}

class _rentcar_register3State extends State<rentcar_register3> {

  String word = '';
  var numtool= 1;

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();
  FocusNode acFocusNode8 = FocusNode();
  FocusNode acFocusNode9 = FocusNode();

  File imageFile;

  final car_brand = TextEditingController();
  final car_name = TextEditingController();
  final info = TextEditingController();
  final price = TextEditingController();
  final license = TextEditingController();
  List<TextEditingController> tool = [];
  final bigbag = TextEditingController();
  final smallbag = TextEditingController();
  TextEditingController num_seat = TextEditingController(text: '0');

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

    Future save_partner2() async {
      var _prefs = await SharedPreferences.getInstance();
      var token = _prefs.get('token');
      String username = '';
      print('savepartner');

      var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/register_carinfo_rentcarpartner'),
          headers:{
            'Context-Type': 'application/json;charSet=UTF-8',
            'Accept': 'application/json;charSet=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: <String, String>{
             // "imagecar": imageFile.toString(),
             "PartnerName": widget.company,
             "address": widget.address,
             "province": widget.province,
             "car_brand": car_brand.text,
             "car_name": car_name.text,
             "num_seat": num_seat.text,
             "price": price.text,
             "year": info.text,
             "license": license.text,
             "price_minute": "2",
             "bigbag": bigbag.text,
             "smallbag": smallbag.text,
             "imagecar": imageFile.toString(),
            "car_rating": "0",
            "nameOfUser": widget.name,

          });
      print(res.body);
    }
  Future update_carinfo_partner() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('update carinfo partner');
    // List<String> image = ["https://www.toyota.co.th/media/product/feature/large/e8d2cc60fa1d5467bc3a8b2b944677faa9c42502.jpg","https://s.isanook.com/au/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2F1LzAvdWQvMTYvODEyODAveWFyaXNfYXRpdl8zMi5qcGc=.jpg"];
    // List<String> name_service = ["FM/AM Radio","Bluetooth","USB/AUX","CD/MP3"];
    List<String> locationpickup = ["มารับด้วยตนเอง","มารับด้วยตนเอง","ท่าอากศยานสุวรรณภูมิ","ท่าอากศยานดินเมือง"];
    List<String> pricelocationpickup = ["0","0","500","800"];
    Map<String,String> data;
    List<String> name;
    data={
      // "image[]": image.toString(),
      "name[]": name.toString(),
      "name_service[]": tool.toString(),
    };
    // for(int i = 0;i < image.length ; i++){
    //   data.addAll({"image[$i]":image[i]});
    // }

    // fileNames = fileNames.split("/").last;
    int a=0;
    data.addAll({"name[$a]":widget.company});a++;
    data.addAll({"name[$a]":widget.address});a++;
    data.addAll({"name[$a]":widget.province});a++;
    data.addAll({"name[$a]":car_brand.text});a++;
    data.addAll({"name[$a]":car_name.text});a++;
    data.addAll({"name[$a]":num_seat.text});a++;
    data.addAll({"name[$a]":price.text});a++;
    data.addAll({"name[$a]":info.text});a++;
    data.addAll({"name[$a]":license.text});a++;
    data.addAll({"name[$a]":"2"});a++;
    data.addAll({"name[$a]":bigbag.text});a++;
    data.addAll({"name[$a]":smallbag.text});a++;
    data.addAll({"name[$a]":fileNames.toString()});a++;
    data.addAll({"name[$a]":"0"});a++;
    data.addAll({"name[$a]":widget.name});
    for(int i = 0;i < numtool ; i++){
      data.addAll({"name_service[$i]":tool[i].text});
    }
    for(int i = 0;i < locationpickup.length ; i++){
      data.addAll({"locationpickup[$i]":locationpickup[i]});
    }
    for(int i = 0;i < pricelocationpickup.length ; i++){
      data.addAll({"pricelocationpickup[$i]":pricelocationpickup[i]});
    }

    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/update_register_rentcarinfo'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: data,
    );
    print(res.body);
  }
  // Future save_partner3() async {
  //   var _prefs = await SharedPreferences.getInstance();
  //   var token = _prefs.get('token');
  //   String username = '';
  //   print('savepartner');
  //
  //   var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/update_register_rentcarinfo'),
  //       headers:{
  //         'Context-Type': 'application/json;charSet=UTF-8',
  //         'Accept': 'application/json;charSet=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: <String, String>{
  //         "image": imageFile.toString(),
  //         "tool": tool.toString(),
  //       });
  //   print(res.body);
  // }
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
                            // Image.file(widget.imagecompany),
                            const Text("ยี่ห้อของรถเช่า",
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
                                controller: car_brand,
                                decoration: const InputDecoration(
                                    hintText: 'ยี่ห้อของรถเช่า',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุยี่ห้อของรถเช่า';
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("รุ่นของรถเช่า",
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
                                controller: car_name,
                                decoration: const InputDecoration(
                                  hintText: 'รุ่นของรถเช่า(กรุณาระบุปี)',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุรุ่นของรถเช่า';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode8,
                                onChanged: (value) {
                                  word = value;
                                },
                              ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("จำนวนที่นั่ง",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff1D3557))),
                                Padding(
                                  padding: const EdgeInsets.only(right: 45),
                                  child: const Text("ราคาเช่าต่อวัน",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1D3557))),
                                ),
                              ],
                            ),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Icon(Icons.remove_circle,
                                          color: Color(0xff1D3557),),
                                        onTap: (){
                                          int currentValue = int.parse(num_seat.text);
                                          setState(() {
                                            print("Setting state");
                                            currentValue--;
                                            num_seat.text =
                                                (currentValue > 0 ? currentValue : 0)
                                                    .toString(); // decrementing value
                                          });
                                        },
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(2)
                                            ],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(8.0),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(0),
                                              ),
                                            ),
                                            controller: num_seat,
                                            keyboardType: TextInputType.numberWithOptions(
                                              decimal: false,
                                              signed: true,
                                            ),
                                          ),
                                      ),
                                      InkWell(
                                        child: Icon(Icons.add_circle,
                                        color: Color(0xff1D3557),),
                                        onTap: (){
                                          int currentValue = int.parse(num_seat.text);
                                          setState(() {
                                            print("Setting state");
                                            currentValue++;
                                            num_seat.text =
                                                (currentValue > 0 ? currentValue : 0)
                                                    .toString(); // decrementing value
                                          });
                                        },
                                      ),
                                    ],
                                  )
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
                                    controller: price,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: 'ราคาเช่าต่อวัน',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุราคาเช่าต่อวัน';
                                      }
                                      return null;
                                    },
                                    focusNode: acFocusNode2,
                                    onChanged: (value) {
                                      word = value;
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
                            const Text("รูปภาพ ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            // ListView.builder(
                            //   physics: NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //   itemCount: numimage,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return GestureDetector(
                            //       child:
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
                            //     );
                            //   },
                            // ),
                            // if(numimage<=2)
                            // InkWell(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(Icons.add_circle,
                            //         color: Color(0xff1D3557),),
                            //       Text("เพิ่มรูป",
                            //           style: TextStyle(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.normal,
                            //               color: Color(0xff1D3557)))
                            //     ],
                            //   ),
                            //   onTap: (){
                            //     setState(() {
                            //       print("Setting state");
                            //       numimage++;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ทะเบียนรถ",
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
                                controller: license,
                                decoration: const InputDecoration(
                                  hintText: 'ทะเบียนรถ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุทะเบียนรถ';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode9,
                                onChanged: (value) {
                                  word = value;
                                },
                              ),
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
                            const Text("ปีที่จดทะเบียนรถ",
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
                                controller: info,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: true,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'ปีที่จดทะเบียนรถ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุปีที่จดทะเบียนรถ';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode4,
                                onChanged: (value) {
                                  word = value;
                                },
                              ),
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
                            const Text("จำนวนกระเป๋าที่สามารถนำไปได้",
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
                                    controller: bigbag,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: 'กระเป๋าใบใหญ่',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุจำนวนกระเป๋าใบใหญ่';
                                      }
                                      return null;
                                    },
                                    focusNode: acFocusNode6,
                                    onChanged: (value) {
                                      word = value;
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
                                    controller: smallbag,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: 'กระเป๋าใบเล็ก',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุจำนวนกระเป๋าใบเล็ก';
                                      }
                                      return null;
                                    },
                                    focusNode: acFocusNode7,
                                    onChanged: (value) {
                                      word = value;
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
                            const Text("อุปกรณ์ภายในรถ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numtool,
                              itemBuilder:  (BuildContext context, int index){
                                tool.add(new TextEditingController());
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
                                        controller: tool[index],
                                        decoration: const InputDecoration(
                                          hintText: 'Bluetooth, USB/AUX, CD/MP3, FM/AM Radio',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Color(0xffECFAFF))),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณาระบุอุปกรณ์ภายในรถ';
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
                                  Text("เพิ่มอุปกรณ์",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1D3557)))
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  print("Setting state");
                                  numtool++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

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
                             // save_partner(),
                             // await save_partner2(),
                             update_carinfo_partner(),
                             // save_partner3(),
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => rentcar_request(

                            ),)),
                            // activity_partner(),
                            uploadImageToFirebase(context),
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
