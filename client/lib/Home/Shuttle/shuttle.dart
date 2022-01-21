import 'package:animated_textformfields/animated_textformfield/animated_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/Data/data_airport.dart';
import 'package:se_app2/main.dart';
import 'package:se_app2/navigator/nav.dart';
import '../../main.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class shuttle extends StatefulWidget {
  @override
  _shuttleState createState() => _shuttleState();
}

class _shuttleState extends State<shuttle> {

  static ValueNotifier<String> enteredValue = ValueNotifier('');

  // Position _currentUserPosition;
  double distanceImMeter = 0.0;
  Data data = Data();
  double price ;
  bool checklocation = false;

  Future _checklocation(String address) async {

    try{
      List<Location> locations = await locationFromAddress(address);
      print('location');
      print(locations);
      checklocation = true;
    }on Exception catch (_){
      print('error');

    }


  }

  Future _getTheDistance(String address) async {
    List<Location> locations = await locationFromAddress(address);
    print('location');
    print(locations);

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
      // print('distance');
      // print(distance);
      data.airport[i]['distance'] = (distance / 1000 );
      // print('data');
      // print(data.airport[i]['distance']);
      if(data.airport[i]['name'] == destination){
        print(data.airport[i]['distance']);
        if(typeshuttle == 'รถเก๋ง'){
          price = 35 + data.airport[i]['distance'] * 3;

        }
        if(typeshuttle == 'รถตู้'){
          price = 100 + data.airport[i]['distance'] * 3;

        }
        print('price');
        print(price);
      }

      setState(() {});
    }
  }

  String Address = 'search';

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(13.7965, 100.3115477);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.country}';
    print('address ' + Address);
    setState(()  {
    });
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
    super.initState();
    _timecontroller = TextEditingController();
    _yourlocationcontroller = TextEditingController();
    _startdatecontroller = TextEditingController();

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
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0 , right: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "จองล่วงหน้า",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        "จองเดี๋ยวนี้",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 15),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border:  Border.all(color:const Color(0xFFB0BEC5),width: 1),
                      ),
                      child:  DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                        ),
                        hint: const Text('รถเก๋ง',style: TextStyle(color: Colors.black),),
                        value: valuetype,
                        iconSize: 16,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                        isExpanded: true,
                        items: item.map(buildMenuItem).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            valuetype = newValue;
                            typeshuttle = valuetype;
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'เลขที่ ซอย ตำบล รหัสไปรษณีย์',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      controller: _yourlocationcontroller,
                      validator: (value) {
                        _checklocation(value);
                        if (value.isEmpty) {
                          return 'กรุณาระบุที่พัก';
                        }else if( checklocation == false ){
                          return 'ไม่มีสถานที่ที่ท่านเลือก';
                        }
                        return null;
                      },
                      focusNode: myFocusNode1,


                    )
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.only(right: 0),
                //     child: AnimatedTextFormField(
                //       backgroundColor: Colors.white,
                //       width: MediaQuery.of(context).size.width * 0.875,
                //       height: 48.0,
                //       inputType: TextInputType.text,
                //       hintText: 'เลขที่ ซอย ตำบล รหัสไปรษณีย์',
                //       textStyle: const TextStyle(
                //         color: Color(0xFF757575),
                //         fontSize: 16.0,
                //       ),
                //       controller: _yourlocationcontroller,
                //       validator: (value) {
                //         if (value.isEmpty || value == null) {
                //           return 'กรุณาระบุที่พัก';
                //         }
                //         return null;
                //       },
                //       focusNode: myFocusNode1,
                //       cornerRadius: BorderRadius.circular(14.0),
                //     )),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:  Border.all(color:const Color(0xFFB0BEC5),width: 1),
                    ),
                    child:  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      hint: const Text('กรุณาระบุที่ตั้งสนามบิน',style: TextStyle(color: Color(0xFF757575)),),
                      value: destination,
                      iconSize: 16,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                      isExpanded: true,
                      items: item_airport.map(buildMenuItem).toList(),
                      validator: (value) => value == null ? "Select a country" : null,
                      onChanged: (String newValue) {
                        setState(() {
                          destination = newValue;
                        });
                      },
                    ),
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.only(right: 0),
                //     child: AnimatedTextFormField(
                //       backgroundColor: Colors.white,
                //       width: MediaQuery.of(context).size.width * 0.875,
                //       height: 48.0,
                //       inputType: TextInputType.text,
                //       hintText: "ที่ตั้งสนามบิน",
                //       textStyle: TextStyle(
                //         color: Color(0xFF757575),
                //         fontSize: 16.0,
                //       ),
                //       controller: _airportlocationcontroller,
                //       validator: (value) {
                //         if (value.isEmpty || value == null) {
                //           return 'กรุณาระบุที่ตั้งสนามบิน';
                //         }
                //         return null;
                //       },
                //
                //       focusNode: myFocusNode2,
                //       cornerRadius: BorderRadius.circular(14.0),
                //
                //     )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0 , right: 145),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      AnimatedTextFormField(
                        backgroundColor: Colors.white,
                        width: 150,
                        height: 48.0,
                        inputType: TextInputType.text,
                        hintText: "วว-ดด-ปป",
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'กรุณาระบุวันเดินทาง';
                          }
                          return null;
                        },
                        textStyle: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16.0,
                        ),
                        controller: _startdatecontroller,
                        focusNode: myFocusNode3,
                        cornerRadius: BorderRadius.circular(14.0),
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
                        },
                      ),
                      const SizedBox(
                        width: 34,
                      ),
                      AnimatedTextFormField(
                        backgroundColor: Colors.white,
                        width: 150,
                        height: 48.0,
                        inputType: TextInputType.text,
                        hintText: "00:00",
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'กรุณาระบุเวลา';
                          }
                          return null;
                        },
                        textStyle: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16.0,
                        ),
                        controller: _timecontroller,
                        focusNode: myFocusNode4,
                        cornerRadius: BorderRadius.circular(14.0),
                        onTap: () async {
                          TimeOfDay pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          FocusScope.of(context)
                              .requestFocus(FocusNode());
                          if(pickedTime != null ){
                            // print(pickedTime.format(context));   //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            // print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            // print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.
                            _timecontroller.text = formattedTime.toString();
                            // print('time = ' + _timecontroller.text);
                            // setState(() {
                            //   //set the value of text field.
                            // });
                          }else{
                            print("Time is not selected");
                          }
                        },
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
                      // ValueListenableBuilder(
                      //     valueListenable: enteredValue,
                      //     builder: builder)

                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: AnimatedButton(
                        height: 50,
                        width: 360,
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        backgroundColor: const Color(0xff1d3557),
                        borderColor: const Color(0xffFFF4DC),
                        borderRadius: 13,
                        borderWidth: 2,
                        text: "ค้นหา",
                        onPress: () {

                          saveOrder();
                        })),

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
    _getTheDistance(_yourlocationcontroller.text);
    print('save');
    print(_startdatecontroller.text);
    print(typeshuttle);
    print(destination);
    print(_timecontroller.text);
    print(_yourlocationcontroller.text);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Nav()));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,style: const TextStyle(fontSize: 14),));

}
