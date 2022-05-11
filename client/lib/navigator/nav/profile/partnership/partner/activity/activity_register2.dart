import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/activity/activity_register3.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/rentcar/rentcar_register3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class activity_register2 extends StatefulWidget {
  activity_register2({this.name,this.number,this.email});
  var name,number,email;

  @override
  _activity_register2State createState() => _activity_register2State();
}

class _activity_register2State extends State<activity_register2> {

  String word = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();

  final activityName = TextEditingController();
  final address = TextEditingController();
  final number_address = TextEditingController();
  final province = TextEditingController();
  final district = TextEditingController();
  final post_code = TextEditingController();
  final price = TextEditingController();

  Future next() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(activityName.text);
    print(number_address.text);
    print(address.text);
    print(province.text);
    print(district.text);
    print(post_code.text);
    print(price.text);
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        activity_register3(
          name: widget.name,
          number : widget.number,
          email : widget.email,
          activityName: activityName.text,
          address: address.text,
          number_address: number_address.text,
          province : province.text,
          district : district.text,
          post_code : post_code.text,
          price : price.text,
        ),));

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
                            const Text("ชื่อสถานที่",
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
                                controller: activityName,
                                decoration: const InputDecoration(
                                  hintText: 'ชื่อ - นามสกุล ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุชื่อ - นามสกุล ';
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
                            const Text("ที่อยู่",
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
                                controller: address,
                                decoration: const InputDecoration(
                                  hintText: 'ที่อยู่',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุที่อยู่';
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
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("เลขที่อยู่, หมายเลขชั้น, ห้อง",
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
                                controller: number_address,
                                decoration: const InputDecoration(
                                  hintText: 'เลขที่อยู่, หมายเลขชั้น, ห้อง',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุเลขที่อยู่, หมายเลขชั้น, ห้อง';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode3,
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
                                const Text("จังหวัด",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff1D3557))),
                                Padding(
                                  padding: const EdgeInsets.only(right: 110),
                                  child: const Text("ตำบล",
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
                                  child: TextFormField(
                                    controller: province,
                                    decoration: const InputDecoration(
                                      hintText: 'จังหวัด',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุจังหวัด';
                                      }
                                      return null;
                                    },
                                    focusNode: acFocusNode4,
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
                                    controller: district,
                                    decoration: const InputDecoration(
                                      hintText: 'ตำบล',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุตำบล';
                                      }
                                      return null;
                                    },
                                    focusNode: acFocusNode5,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("รหัสไปรษณีย์",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff1D3557))),
                                Padding(
                                  padding: const EdgeInsets.only(right: 110),
                                  child: const Text("ราคา",
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
                                  child: TextFormField(
                                    controller: post_code,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(5)
                                    ],
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'รหัสไปรษณีย์',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุรหัสไปรษณีย์';
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
                                    controller: price,

                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'ราคา',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุราคา';
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
                            // airport_partner(),
                            next(),
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_register3(
                            //
                            // ),)),
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
