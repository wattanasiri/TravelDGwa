import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:se_app2/Data/data_currentuser.dart';

import '/data/data_airport.dart';
import 'Rentcar_info.dart';

class rentcar extends StatefulWidget {
  const rentcar({Key key}) : super(key: key);
  @override
  _rentcarState createState() => _rentcarState();
}

class _rentcarState extends State<rentcar> {

  Future save_partner() async {
    print('savepartner');
    Datauser datauser = Datauser();
    print('id');
    print(datauser.id);

    var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/register_rentcarpartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "usernameID" : datauser.id,
          "image": "https://www.luvdrive.com/assets/img/logo/new-logo.png",
          "phone": "095-2911766",
          "email": "aoy35085@hotmail.com",

        });
    print(res.body);
  }

  Future update_partner() async{

    print('update partner');
    List<String> document = ["บัตรประชาชน / Passport","ใบขับขี่ / Driving License"];
    List<String> name_extrapay = ["05:30 - 08.59","31:01 - 23:59","บริการรับส่งนอกสถานที่"];
    List<String> price_extrapay = ["300","300","100"];
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
    print(data);
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/update_register_rentcarpartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: data,
    );
    print(res.body);
  }
  Future save_carinfo_partner() async{

    print('save carinfo partner');

    var res = await http.post(Uri.parse('http://10.0.2.2:8080/rentcar/register_carinfo_rentcarpartner'),
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

        });
    print(res.body);
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

  @override
  void initState() {
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
                  child: Text("สถานที่ที่จะเช่ารถ", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
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
                          hintText: 'จังหวัด',
                          prefixIcon: Icon(Icons.fmd_good,color: Colors.black,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: _yourlocationcontroller,
                        onFieldSubmitted: (String newvalue) {
                          // _price(_yourlocationcontroller.text);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'กรุณาระบุสถานที่';
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
                            hintText: ' วว-ดด-ปป',
                            prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'กรุณาระบุวันเดินทาง';
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
                            var formattedDate =
                                "${date.day}-${date.month}-${date.year}";
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            hintText: ' 00:00',
                            prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'กรุณาระบุเวลา';
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
                            hintText: ' วว-ดด-ปป',
                            prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'กรุณาระบุวันเดินทาง';
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
                                "${date.day}-${date.month}-${date.year}";
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            hintText: ' 00:00',
                            prefixIcon: Icon(Icons.access_time_outlined,color: Colors.black,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'กรุณาระบุเวลา';
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
                          onPressed: () {
                            save_partner();
                            update_partner();
                            save_carinfo_partner();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Rentcar_info(
                              dategetcar: _dategetcarcontroller.text,
                              timegetcar: _timegetcarcontroller.text,
                              datesentcar: _datesentcarcontroller.text,
                              timesentcar: _timesentcarcontroller.text,
                              yourlocation: _yourlocationcontroller.text,
                            ),));

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
