import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/airport_tranfer/airport_tranfer_request.dart';

class airport_tranfer_register extends StatefulWidget {


  @override
  _airport_tranfer_registerState createState() => _airport_tranfer_registerState();
}

class _airport_tranfer_registerState extends State<airport_tranfer_register> {

  String word = '';
  String valuetype ;
  String dropdownValue = 'รถเก๋ง';

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();
  FocusNode acFocusNode8 = FocusNode();

  final name = TextEditingController();
  final address = TextEditingController();
  final province = TextEditingController();
  final district = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final car_registration = TextEditingController();
  final brand = TextEditingController();

  Future airport_partner() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    String username = '';
    print('saveinvoice');

    Datauser datauser = Datauser();
    print(datauser.id);
    var res = await http.post(Uri.parse('$SERVER_URL/airport_transfer/register_shuttlepartner'),
        headers: {
          'Context-Type': 'application/json;charSet=UTF-8',
          'Accept': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          "usernameID" : '$token',
          "username": name.text,
          "car_brand" : brand.text,
          "car_registration" : car_registration.text,
          "phone": number.text,
          "email": email.text,
          "address": address.text,
          "province": province.text,
          "district": district.text,
        });
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
                            const Text("ชื่อ - นามสกุล ",
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
                            const Text("ที่อยู่ (ติดต่อคนขับ)",
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
                            const Text("บริเวณที่รับ - ส่ง (พื้นที่ให้บริการ)",
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
                                    focusNode: acFocusNode3,
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
                                      hintText: 'เขต/อำเภอ',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุเขต/อำเภอ';
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("เบอร์โทรศัพท์",
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
                                controller: number,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'เบอร์โทรศัพท์',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุเบอร์โทรศัพท์';
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
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("อีเมล",
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
                                controller: email,
                                decoration: const InputDecoration(
                                  hintText: 'อีเมล',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุอีเมล';
                                  }
                                  return null;
                                },
                                focusNode: acFocusNode6,
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
                            const Text("รุ่นของรถที่ขับ",
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
                                controller: brand,
                                decoration: const InputDecoration(
                                  hintText: 'รุ่นของรถที่ขับ',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุรุ่นของรถที่ขับ';
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
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const Text("ประเภทของรถที่ขับ",
                      //           style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.normal,
                      //               color: Color(0xff1D3557))),
                      //       const SizedBox(height: 5),
                      //       Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 16, vertical: 2),
                      //         width: 350,
                      //         decoration: BoxDecoration(
                      //             color: const Color(0xffECFAFF),
                      //             borderRadius: BorderRadius.circular(15),
                      //             border: Border.all(
                      //                 color: const Color(0xff1D3557), width: 2)),
                      //         child: DropdownButtonFormField<String>(
                      //             decoration: const InputDecoration(
                      //               prefixIcon: Icon(Icons.airport_shuttle,color: Color(0xff1D3557),),
                      //               enabledBorder: UnderlineInputBorder(
                      //                   borderSide: BorderSide(color: Color(0xffECFAFF))),
                      //             ),
                      //             hint: const Text(' รถเก๋ง',style: TextStyle(color: Color(0xff1D3557)),),
                      //             value: valuetype,
                      //             iconSize: 16,
                      //             icon: const Icon(Icons.arrow_drop_down, color: Color(0xff1D3557),),
                      //             isExpanded: true,
                      //             onChanged: (String newValue) {
                      //               setState(() {
                      //               dropdownValue = newValue;
                      //               });
                      //             },
                      //             items: <String>['รถตู้','รถเก๋ง'].map<DropdownMenuItem<String>>((String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(value),
                      //                 );
                      //         }).toList(),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                controller: car_registration,
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
                            airport_partner(),
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => airport_tranfer_request(

                          ),)),
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
                            'สมัครเป็นพาร์ทเนอร์รถรับ - ส่ง',
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
