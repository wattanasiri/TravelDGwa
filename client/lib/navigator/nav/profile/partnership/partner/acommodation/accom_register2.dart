import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/acommodation/accom_register3.dart';

class accom_register2 extends StatefulWidget {
  accom_register2({this.image});
  var image;


  @override
  _accom_register2State createState() => _accom_register2State();
}

class _accom_register2State extends State<accom_register2> {

  File _imageFile;
  _getFromGallery(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    print(_imageFile);
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child('/$fileName');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }
  String word = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  String valueChoose;
  List listItem = [
    "Normal","Suite"
  ];
  TextEditingController person = TextEditingController(text: '0');

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();

  final name = TextEditingController();
  final size = TextEditingController();

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
            'รายละเอียดห้องพัก',
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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Form(
              key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ชนิดของห้องพัก",
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
                            child: DropdownButton(
                              hint: Text('ชนิดของห้องพัก'),
                              dropdownColor: Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: Color(0xff1D3557),
                              ),
                              value: valueChoose,
                              onChanged: (newValue){
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: listItem.map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                    child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ขนาดห้องพัก",
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
                              controller: size,
                              inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3)
                            ],
                              decoration: const InputDecoration(
                                hintText: 'ขนาดห้อง(ตรม.)',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffECFAFF))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาระบุชขนาดห้อง';
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
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("จำนวนคนที่เข้าพัก",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(Icons.remove_circle,
                                    color: Color(0xff1D3557),),
                                  onTap: (){
                                    int currentValue = int.parse(person.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue--;
                                      person.text =
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
                                    controller: person,
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
                                    int currentValue = int.parse(person.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue++;
                                      person.text =
                                          (currentValue > 0 ? currentValue : 0)
                                              .toString(); // decrementing value
                                    });
                                  },
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ขนาดห้องพัก",
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
                              controller: size,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3)
                              ],
                              decoration: const InputDecoration(
                                hintText: 'ขนาดห้อง(ตรม.)',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffECFAFF))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาระบุชขนาดห้อง';
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
                            child: _imageFile != null
                                ?ClipRect(
                              child: Image.file(_imageFile),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => accom_register3(

                          ),)),
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


                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
