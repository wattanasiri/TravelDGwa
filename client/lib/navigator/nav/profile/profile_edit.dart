import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/changepass.dart';
import 'package:se_app2/navigator/nav/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/constants.dart';

class editpro extends StatefulWidget {
  @override
  _editproState createState() => _editproState();
}

class _editproState extends State<editpro> {

  // Future editProfile() async {
  //   // allRooms = room_detail;
  //   // data = json.encode(allRooms);
  //   var _prefs = await SharedPreferences.getInstance();
  //   var token = _prefs.get('token');
  //   var res = await http.post(Uri.parse("$SERVER_URL/blog"),
  //       headers: <String, String>{
  //         'Context-Type': 'application/json;charSet=UTF-8',
  //         'Accept': 'application/json;charSet=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: <String, String>{
  //         'realname' : realname ,
  //         'surname' : surname ,
  //         'phone' : phone
  //
  //       });
  //   print(res.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
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
            'แก้ไขโปรไฟล์',
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
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  'บันทึก',
                  style: TextStyle(
                    color: Color(0xff7BEE99)
                  ),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFECFAFF),
                    radius: 48,
                    child: Text("SC", style: TextStyle(fontSize: 40, color: Color(0xFF1d3557)),textAlign: TextAlign.start,),
                  ),
                  SizedBox(height: 5,),
                  Text("เปลี่ยนรูปโปรไฟล์", style: TextStyle(fontSize: 17, color: Color(0xFFFF9A62)),textAlign: TextAlign.start,),
                ],
              ),
              SizedBox(height: 10,),
              Divider(thickness: 1, color: Color(0xff827E7E)),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ชื่อ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'ชื่อ',
                                  enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("นามสกุล",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557))),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xff1D3557), width: 2)
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'นามสกุล',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ]
              ),
              Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
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
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: const Color(0xff1D3557), width: 2)
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'เบอร์โทรศัพท์',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xffECFAFF))),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  ]
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: Color(0xff827E7E), width: 1.5))
                ),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                              'เปลี่ยนรหัสผ่าน',
                            style: TextStyle(
                              color: Color(0xff1D3557),
                              fontSize: 16
                            ),
                          )
                      ),
                      Icon(Icons.navigate_next_rounded, color: Color(0xff1D3557))
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
