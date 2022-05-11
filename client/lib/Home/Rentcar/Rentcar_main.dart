import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import '../../../Data/data_currentuser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Rentcar_info.dart';

class rentcar extends StatefulWidget {
  const rentcar({Key key}) : super(key: key);
  @override
  _rentcarState createState() => _rentcarState();
}

class _rentcarState extends State<rentcar> {
  String id;
// กรุงเทพ
  Map dataafterquery;
  Future getdataid() async {
    Datauser datauser = Datauser();
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('getuserid');
    http.Response res = await http.get(
      Uri.parse('http://10.0.2.2:8080/map/getuserid'),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(json.decode(res.body));
    datauser.id = json.decode(res.body);
  }
  Future save_partner() async {
    print('savepartner');
    Datauser datauser = Datauser();
    print('id');
    print(datauser.id);

    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/register_rentcarpartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "partnername": "Luv Driver Car Rent",
          "usernameID" : datauser.id,
          "phone": "095-2911766",
          "email": "aoy35085@hotmail.com",
          "opening_day": "จันทร์ - ศุกร์",
          "opening_time": "09.00 - 21.00",
        });
    print(res.body);
  }
  Future update_partner() async{

    print('update partner');
    List<String> document = ["บัตรประชาชน / Passport","ใบขับขี่ / Driving License"];
    List<String> name_extrapay = ["05:30 - 08.59","31:01 - 23:59","บริการรับส่งนอกสถานที่"];
    List<String> price_extrapay = ["300","300","100"];
    List<String> image = ["https://www.luvdrive.com/assets/img/logo/new-logo.png","https://lh5.googleusercontent.com/p/AF1QipNf5_4r5eeUBPNb_sT5IcZ7u_luULYk5L2iFJBe=w1080-k-no"];
    Map<String,String> data;
    data={
      "document[]": document.toString(),
      "name_extrapay[]": name_extrapay.toString(),
      "price_extrapay[]": price_extrapay.toString(),
    };
    for(int i = 0;i < document.length ; i++){
      data.addAll({"document[$i]":document[i]});
    }
    for(int i = 0;i < name_extrapay.length ; i++){
      data.addAll({"name_extrapay[$i]":name_extrapay[i]});
    }
    for(int i = 0;i < price_extrapay.length ; i++){
      data.addAll({"price_extrapay[$i]":price_extrapay[i]});
    }
    for(int i = 0;i < image.length ; i++){
      data.addAll({"image[$i]":image[i]});
    }
    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/update_register_rentcarpartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: data,
    );
    print(res.body);
  }
  Future save_carinfo_partner() async{
    print('save carinfo partner');
    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/register_carinfo_rentcarpartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{

          "carname": "Toyota yaris",
          "carbrand": "Toyota",
          "year": "2564",
          "numsit": "4",
          "bigbag": "1",
          "smallbag": "2",
          "selfpick": "0",
          "sentcar": "500",
          "country": "bangkok",
          "location" : "703 อาคารรัชฎาสวีท ถนนวงศ์สว่าง แขวงวงศ์สว่าง เขตบางซื่อ กทม 10800",
          "price": "1500",
          "partnername" : "Luv Driver Car Rent",
          "price_minute": "2",
          "license": "กท32020",
          "car_rating": "4",

        });
    print(res.body);

  }
  Future update_carinfo_partner() async{
      print('update carinfo partner');
      List<String> image = ["https://www.toyota.co.th/media/product/feature/large/e8d2cc60fa1d5467bc3a8b2b944677faa9c42502.jpg","https://s.isanook.com/au/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2F1LzAvdWQvMTYvODEyODAveWFyaXNfYXRpdl8zMi5qcGc=.jpg"];
      List<String> name_service = ["FM/AM Radio","Bluetooth","USB/AUX","CD/MP3"];
      List<String> locationpickup = ["มารับด้วยตนเอง","ท่าอากศยานสุวรรณภูมิ","ท่าอากศยานดินเมือง"];
      List<String> pricelocationpickup = ["0","500","800"];
      Map<String,String> data;
      data={
        "image[]": image.toString(),
        "name_service[]": name_service.toString(),
      };
      for(int i = 0;i < image.length ; i++){
        data.addAll({"image[$i]":image[i]});
      }
      for(int i = 0;i < name_service.length ; i++){
        data.addAll({"name_service[$i]":name_service[i]});
      }
      for(int i = 0;i < locationpickup.length ; i++){
        data.addAll({"locationpickup[$i]":locationpickup[i]});
      }
      for(int i = 0;i < pricelocationpickup.length ; i++){
        data.addAll({"pricelocationpickup[$i]":pricelocationpickup[i]});
      }

      var res = await http.post(Uri.parse('$SERVER_URL/rentcar/update_register_rentcarinfo'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: data,
      );
      print(res.body);
  }
  Future regis_carinfo_partner() async{
    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/regis_rentcarinfo'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{

          "carname": "Toyota Camry (ASV70R)",
          "carbrand": "Toyota",
          "year": "2561",
          "numsit": "4",
          "bigbag": "1",
          "smallbag": "2",
          "selfpick": "0",
          "sentcar": "1000",
          "country": "อุดรธานี",
          "location" : "703 อาคารรัชฎาสวีท ถนนวงศ์สว่าง แขวงวงศ์สว่าง เขตบางซื่อ กทม 10800",
          "price": "1500",
          "price_minute": "2",
          "partnername" : "Luv Driver Car Rent",
          "license": "กท32020",
          "car_rating": "5",

        });
    print(res.body);
  }
  Future update_regis_carinfo_partner() async{

    List<String> image = ["https://upload.wikimedia.org/wikipedia/commons/a/ac/2018_Toyota_Camry_%28ASV70R%29_Ascent_sedan_%282018-08-27%29_01.jpg","https://upload.wikimedia.org/wikipedia/commons/c/cb/2018_Toyota_Camry_%28ASV70R%29_Ascent_sedan_%282018-08-27%29_02.jpg"];
    List<String> name_service = ["FM/AM Radio","Bluetooth","USB/AUX","CD/MP3"];
    List<String> locationpickup = ["มารับด้วยตนเอง","ท่าอากศยานสุวรรณภูมิ","ท่าอากศยานดินเมือง"];
    List<String> pricelocationpickup = ["0","500","800"];
    Map<String,String> data;
    data={
      "image[]": image.toString(),
      "name_service[]": name_service.toString(),
    };
    for(int i = 0;i < image.length ; i++){
      data.addAll({"image[$i]":image[i]});
    }
    for(int i = 0;i < name_service.length ; i++){
      data.addAll({"name_service[$i]":name_service[i]});
    }
    for(int i = 0;i < locationpickup.length ; i++){
      data.addAll({"locationpickup[$i]":locationpickup[i]});
    }
    for(int i = 0;i < pricelocationpickup.length ; i++){
      data.addAll({"pricelocationpickup[$i]":pricelocationpickup[i]});
    }
    var res = await http.post(Uri.parse('$SERVER_URL/rentcar/update_regis_rentcarinfo'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: data,
    );
    print(res.body);
  }
  Future querycar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('querycar');
    id = _yourlocationcontroller.text.toString();
    //กรุงเทพ,อุดรธานี
    http.Response res =
    await http.get(Uri.parse("$SERVER_URL/rentcar/" + id + '/queryrentcar'));
    dataafterquery = json.decode(res.body);
    print('dataafterquery');
    print(dataafterquery);
    print(dataafterquery.runtimeType);
    print(dataafterquery['foundCar']);
    print(dataafterquery['foundCar'].runtimeType);
    getdataid();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Rentcar_info(
      dategetcar: _dategetcarcontroller.text,
      timegetcar: _timegetcarcontroller.text,
      datesentcar: _datesentcarcontroller.text,
      timesentcar: _timesentcarcontroller.text,
      yourlocation: _yourlocationcontroller.text,
      data : dataafterquery,

    ),));
  }

  TextEditingController
  _timegetcarcontroller,
      _timesentcarcontroller,
      _dategetcarcontroller,
      _datesentcarcontroller,
      _yourlocationcontroller;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void test() async{
    // AIzaSyC4gc3Gu8CQIetCYBatxK4sF7xv653fEJM
    var googlePlace = GooglePlace("AIzaSyC4gc3Gu8CQIetCYBatxK4sF7xv653fEJM");
    var result = await googlePlace.search.getNearBySearch(
        Location(lat: -33.8670522, lng: 151.1957362), 1500,
        type: "restaurant", keyword: "cruise");
    print(result);
    print(result.status);

  }
  @override
  void initState() {
    test();
    getdataid();
    // save();
    super.initState();

    _timegetcarcontroller = TextEditingController();
    _timesentcarcontroller = TextEditingController();
    _yourlocationcontroller = TextEditingController();
    _dategetcarcontroller = TextEditingController();
    _datesentcarcontroller = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('รถเช่า'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              children:[
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(right: 215),
                  child: Text("จังหวัดที่จะเช่ารถ", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0,left: 0),
                  child: Container(
                      width: 358,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          hintText: 'จังหวัด',
                          prefixIcon: Icon(Icons.fmd_good,color: Colors.black,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2.0)),

                        ),
                        controller: _yourlocationcontroller,

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'กรุณาระบุจังหวัด';
                          }
                          return null;
                        },
                        focusNode: myFocusNode,
                      )
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0 , right: 105),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "วันรับรถ",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "เวลารับรถ",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Row(
                    children: [
                      Container(
                        width: 165,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                        ),
                        child:  TextFormField(
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            hintText: ' ปปปป-ดด-วว',
                            prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 2.0)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'กรุณาระบุวันรับรถ';
                            }
                            return null;
                          },
                          controller: _dategetcarcontroller,
                          focusNode: myFocusNode1,
                          onTap: () async {
                            DateTime date = DateTime(1900);

                            FocusScope.of(context)
                                .requestFocus(FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            print(date);
                            var formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);
                            print('formattedDate');
                            print(formattedDate);
                            _dategetcarcontroller.text =
                                formattedDate.toString();
                          },
                        ),

                      ),

                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 162,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                        ),
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
                          focusNode: myFocusNode2,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0 , right: 85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันส่งคืนรถ",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        "เวลาส่งคืนรถ",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Row(
                    children: [
                      Container(
                        width: 165,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                        ),
                        child:  TextFormField(
                          decoration: const InputDecoration(
                            hintText: ' ปปปป-ดด-วว',
                            prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'กรุณาระบุวันส่งคืนรถ';
                            }
                            return null;
                          },
                          controller: _datesentcarcontroller,
                          focusNode: myFocusNode3,
                          onTap: () async {
                            DateTime date = DateTime(1900);

                            FocusScope.of(context)
                                .requestFocus(FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            var formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);
                            _datesentcarcontroller.text =
                                formattedDate.toString();
                          },
                        ),

                      ),

                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 162,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                        ),
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
                              return 'กรุณาระบุเวลาส่งคืนรถ';
                            }
                            return null;
                          },
                          controller: _timesentcarcontroller,
                          focusNode: myFocusNode4,
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
                              _timesentcarcontroller.text = formattedTime.toString();

                            }else{
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RaisedButton(
                          onPressed: () async =>  {
                            await querycar(),
                            //
                            // await getdetailcar(),
                            // await getdetailpartnercar(),


                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ค้นหารถเช่า',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffFFF4DC)
                              ),
                            ),
                          ),
                          color: Color(0xff1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
