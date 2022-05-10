import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:ffi';
import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:se_app2/navigator/nav/profile/partnership/mainpartnership.dart';

class accom_register extends StatefulWidget {

  @override
  _accom_registerState createState() => _accom_registerState();
}

class _accom_registerState extends State<accom_register> {

  File imageFile;

  // _getFromGallery(context) async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  //   print(imageFile);
  //   var res = await uploadImage(imageFile.path, 'http://10.0.2.2:8080/activity/activity_partner');
  // }
  //
  // Future<String> uploadImage(filename, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8080/activity/upload'));
  //   request.files.add(await http.MultipartFile.fromPath('picture', filename));
  //   var res = await request.send();
  //   return res.reasonPhrase;
  // }

  String word = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();

  final name = TextEditingController();
  final desc = TextEditingController();
  final address = TextEditingController();
  final number_address = TextEditingController();
  final province = TextEditingController();
  final district = TextEditingController();
  final post_code = TextEditingController();

  bool isloaded = false;
  File _image;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("0");
        print("_image");
        print(_image);

      } else {
        print('No image selected.');
      }
    });
  }
  upload(File imageFile) async {
    print("1");

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
              'รายละเอียดที่พัก',
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
                      children: <Widget>[
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            children: [
                              Container(
                                child: Image.network('https://firebasestorage.googleapis.com/v0/b/traveldgwa.appspot.com/o/uploads%2Fimage_picker7843821902443234175.jpg?alt=media&token=19077167-1d5a-4bd4-9dcb-756fa4669d78'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),]
            )
        )
    );
  }
}