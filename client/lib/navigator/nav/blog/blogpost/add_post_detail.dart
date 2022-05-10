import 'dart:io';
import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/blog/blogpost/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class Addpostdetail extends StatefulWidget {
  bool check;
  @override
  State<Addpostdetail> createState() => _AddpostdetailState();
}
Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text(stars);
}

class _AddpostdetailState extends State<Addpostdetail> {

  final topic = TextEditingController();
  final location = TextEditingController();
  final desc = TextEditingController();
  FocusNode topicFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();


  Future addBlog() async {
    // allRooms = room_detail;
    // data = json.encode(allRooms);
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var res = await http.post(Uri.parse("http://10.0.2.2:8080/blog"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Accept': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          'image' : fileNames.toString(),
          'topic' : topic.text,
          'location' : location.text,
          'desc' : desc.text,
          'date' : DateTime.now().toString()
        });
    print(res.body);
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


  /// Variables
  File imageFile;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor : Color(0xFF1D3557),
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
            'เขียนบล็อค',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  addBlog();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'โพสต์',
                  style: TextStyle(
                      color: Color(0xff7BEE99)
                  ),
                ))
          ],
        ),
      ),
      body: Container(

        child: SingleChildScrollView(
          //physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

          child: Column(
            children: <Widget>[
              //AddPostAppBar(screenName: 'gallery', height: 45),
              //รูปใหญ่ด้านบน
              Container(
                height: 370,
                color: Color(0xff1D3557),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                        /*child: Image(
                          image: NetworkImage(Utils.listOfImageUrl.elementAt(0)),
                          fit: BoxFit.cover,
                        ),*/
                        child: imageFile == null
                            ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Color(0xff7BEE99),
                                onPressed: () {
                                  _getFromGallery();
                                },
                                child: Text("Add Image from gallery"),
                              ),
                              Container(
                                height: 40.0,
                              ),
                              RaisedButton(
                                color: Color(0xffFF9A62),
                                onPressed: () {
                                  _getFromCamera();
                                },
                                child: Text("         Take a picture         "),
                              )
                            ],
                          ),
                        ): Container(
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        )
                    ),
                  ],
                ),
              ),
              //รูปใหญ่ด้านบน
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child : Column(
                  children: [
                    //ส่วนหัวข้อ
                    Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("หัวข้อ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffECFAFF),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'หัวข้อ',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffECFAFF))),
                                        ),
                                        controller: topic,
                                        focusNode: topicFocusNode,
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนหัวข้อ
                    //ส่วนที่่ตั้ง
                    Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("ที่ตั้ง",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffECFAFF),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'ที่ตั้ง',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffECFAFF))),
                                        ),
                                        controller: location,
                                        focusNode: locationFocusNode,
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนที่่ตั้ง
                    //ส่วนเนื้อหา
                    Row(
                        children: [
                          Expanded(
                            child: Container(

                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("เนื้อหา",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                        height: 200,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffECFAFF),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                        ),
                                        child: TextFormField(
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            hintText: 'เนื้อหา ',

                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffECFAFF))),
                                          ),
                                          controller: desc,
                                          focusNode: descFocusNode,
                                        )
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนเนื้อหา
                  ],),),
            ],
          ),
        ),
      ),
    );
  }
  /// Get from gallery
  _getFromGallery() async {
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
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

