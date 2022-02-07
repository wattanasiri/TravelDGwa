import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_driver.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '/data/data_airport.dart';


class ShuttlePage extends StatefulWidget {

  const ShuttlePage({Key key}) : super(key: key);

  @override
  _ShuttlePageState createState() => _ShuttlePageState();
}

class _ShuttlePageState extends State<ShuttlePage> {
  ValueNotifier<String> price = ValueNotifier('--');
  double distanceImMeter = 0.0;
  Data data = Data();
  bool checklocation = false;
  bool value_booknow = false;
  bool value_advance = true;

  Future _checklocation(String address) async {
    try{
      List<Location> locations = await locationFromAddress(address);
      checklocation = true;
      print('check location');
      print(locations);
    }on Exception catch (_){
      checklocation = false;
      print('error');
    }
  }

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final item = ['รถเก๋ง','รถตู้'];
  final item_airport = ['ท่าอากาศยานสุวรรณภูมิ','ท่าอากาศยานดอนเมือง','ท่าอากาศยานนานาชาติเชียงใหม่'];
  String destination;
  String valuetype ;
  String typeshuttle = 'รถเก๋ง';

  TextEditingController
  _timecontroller,
      _startdatecontroller,
      _yourlocationcontroller;

  @override
  void initState() {
    // save();
    super.initState();
    _timecontroller = TextEditingController();
    _yourlocationcontroller = TextEditingController();
    _startdatecontroller = TextEditingController();

  }

  Future save() async {
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/shuttle/register_shuttlepartner'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "username" : 'franky',
          "display_name": 'นายสมปอง ดองงาน',
          "car_brand": 'ฮอนด้า',
          "car_registration": 'ฟฟ6207',
          "phone": '097-3182012',
          "email": 'franky123@gmail.com',
        });
    print(res.body);
  }


  Future _price(String address) async{
    print('price');
    double sum_price;
    try{
      if(((_timecontroller.text != '' && _startdatecontroller.text != '')|| value_booknow) && _yourlocationcontroller != null && destination != null){
        print('price change');
        print(address);
        List<Location> locations = await locationFromAddress(address);
        try{
          for (int i = 0; i < data.airport.length; i++) {
            double storelat = data.airport[i]['lat'];
            double storelng = data.airport[i]['lng'];
            distanceImMeter = await Geolocator.distanceBetween(
              locations[0].latitude,
              locations[0].longitude,
              storelat,
              storelng,
            );
            var distance = distanceImMeter?.round().toInt();
            data.airport[i]['distance'] = (distance / 1000 );
            if(data.airport[i]['name'] == destination){
              print(data.airport[i]['distance']);
              if(typeshuttle == 'รถเก๋ง'){
                sum_price = (35 + data.airport[i]['distance'] * 3);
              }
              if(typeshuttle == 'รถตู้'){
                sum_price = 100 + data.airport[i]['distance'] * 5;
              }
              price.value = sum_price.toStringAsFixed(2).toString();
              print('price');
              print(price);
            }
            setState(() {});
          }
        }catch(e){
          print('----');

        }
      }
    }catch(e){
      print('error');
      print(e);
      price.value = '--';

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('รถรับ - ส่งสนามบิน'),
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
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0 , right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children:[
                            Checkbox(
                              shape: CircleBorder(),
                              value: this.value_advance,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value_advance = value;
                                  this.value_booknow = false;
                                });
                              },
                            ),
                            Text(
                              "จองล่วงหน้า",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Checkbox(
                              shape: CircleBorder(),
                              value: this.value_booknow,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value_booknow = value;
                                  this.value_advance = false;
                                });
                              },
                            ),
                            Text(
                              "จองเดี๋ยวนี้",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 25,
                  endIndent: 25,
                  color: Color(0xFF757575),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Text("เลือกประเภทรถ", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    width: 362,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:  Border.all(color:const Color(0xFFB0BEC5),width: 1),
                    ),
                    child:  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.airport_shuttle,color: Colors.black,),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      hint: const Text(' รถเก๋ง',style: TextStyle(color: Colors.black),),
                      value: valuetype,
                      iconSize: 16,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                      isExpanded: true,
                      items: item.map(buildMenuItem).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          valuetype = newValue;
                          typeshuttle = valuetype;
                          _price(_yourlocationcontroller.text);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 275),
                  child: Text("จาก (ที่อยู่)", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                      width: 362,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: ' เลขที่ ซอย ตำบล รหัสไปรษณีย์',
                          prefixIcon: Icon(Icons.fmd_good,color: Colors.black,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: _yourlocationcontroller,
                        onFieldSubmitted: (String newvalue) {
                           _checklocation(newvalue);
                          _price(_yourlocationcontroller.text);
                        },
                        validator: (value) {
                          _checklocation(value);
                          if (value.isEmpty) {
                            return 'กรุณาระบุที่พัก';
                          }else if( checklocation == false ){
                            print('checklocation2');
                            return 'ไม่มีสถานที่ที่ท่านเลือก';
                          }
                          return null;
                        },
                        focusNode: myFocusNode1,
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text("ไป (ที่ตั้งสนามบิน)", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    width: 362,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:  Border.all(color:const Color(0xFFB0BEC5),width: 1),
                    ),
                    child:  Container(
                      child:
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: ' กรุณาระบุที่ตั้งสนามบิน',
                          prefixIcon: Icon(Icons.airplanemode_active,color: Colors.black,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        // hint: const Text('กรุณาระบุที่ตั้งสนามบิน',style: TextStyle(color: Color(0xFF757575)),),
                        value: destination,
                        iconSize: 16,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                        isExpanded: true,
                        items: item_airport.map(buildMenuItem).toList(),
                        validator: (value) => value == null ? "Select a country" : null,
                        onChanged: (String newValue) {
                          setState(() {
                            destination = newValue;
                            _price(_yourlocationcontroller.text);
                          });
                        },
                      ),
                    )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if(value_booknow == false)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0 , right: 145),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันเดินทาง",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        "เวลา",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                if(value_booknow == false)
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
                          controller: _startdatecontroller,
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
                            _startdatecontroller.text =
                                formattedDate.toString();
                            _price(_yourlocationcontroller.text);
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
                          controller: _timecontroller,
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
                              _timecontroller.text = formattedTime.toString();
                              _price(_yourlocationcontroller.text);
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
                  height: 5,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 25,
                  endIndent: 25,
                  color: Color(0xFF757575),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0 , right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ราคา",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 18),
                      ),
                      ValueListenableBuilder(
                        valueListenable: price,
                        builder: (BuildContext context,String newValue,Widget child) {
                          return Text(
                            newValue + '   THB',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RaisedButton(
                          onPressed: () {
                            saveOrder();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ยืนยันการชำระเงิน',
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
                // Padding(
                //     padding: const EdgeInsets.only(right: 0),
                //     child: AnimatedButton(
                //         height: 50,
                //         width: 360,
                //         isReverse: true,
                //         selectedTextColor: Colors.black,
                //         transitionType: TransitionType.LEFT_TO_RIGHT,
                //         backgroundColor: const Color(0xff1d3557),
                //         borderColor: const Color(0xffFFF4DC),
                //         borderRadius: 13,
                //         borderWidth: 2,
                //         text: "ค้นหา",
                //         onPress: () {
                //           saveOrder();
                //         })),
              ],
            )
        ),
      ),
    );
  }

  void saveOrder(){
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _checklocation(_yourlocationcontroller.text);
    print('save');
    print(_startdatecontroller.text);
    print(typeshuttle);
    print(destination);
    print(_timecontroller.text);
    print(_yourlocationcontroller.text);
    print('value_booknow');
    print(value_booknow);
    Navigator.push(context, MaterialPageRoute(builder: (context) => search_driver(
        startdate: _startdatecontroller.text,
        typeshuttle: typeshuttle,
        starttime: _timecontroller.text,
        destination: destination,
        yourlocation: _yourlocationcontroller.text,
        sumprice: price.value,
        value_booknow: value_booknow,

    ),

    ));

  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,style: const TextStyle(fontSize: 14),));

}
