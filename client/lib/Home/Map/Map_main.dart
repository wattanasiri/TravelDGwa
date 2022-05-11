


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/Home/Map/Map_result.dart';

import '../../Data/data_locations.dart';
import '../../Data/data_selectlocation.dart';

class Mapinput extends StatefulWidget {

  @override
  State<Mapinput> createState() => _MapinputState();
}

class _MapinputState extends State<Mapinput> {
  TextEditingController
  _locationcontroller,_destinationcontroller;
  List<TextEditingController> info = [];
  String word = '';
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  var numinfo = 1;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future query() async {
   print(info);
   print(info[0].text);
   print(numinfo);
   try{
     List<Location> locations = await locationFromAddress('สถานีเพาะเลี้ยงสัตว์ป่าบางละมุง');
     print('check location');
     print(locations);
   }on Exception catch (_){
     print('error');
   }
   Datalocation data = Datalocation();
   List<dynamic> selectlocation;
   Dataselectlocation selectdata = Dataselectlocation();
   selectlocation = selectdata.selectlocation;
   for (int j =0; j< numinfo ; j++) {
     for(int i = 0; i < data.location.length; i++){
       if(info[j].text == data.location[i]['name']){
         selectlocation.add(
             data.location[i]
         );
       }
     }
   }
   print(selectdata);
   Navigator.push(context, MaterialPageRoute(builder: (context) => MapResult(
     data: selectlocation,
   ),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('แผนที่'),
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("สถานที่ที่ต้องการค้นหา",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff1D3557))),
                      const SizedBox(height: 25),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: numinfo,
                        itemBuilder:  (BuildContext context, int index){
                          info.add(new TextEditingController());
                          return GestureDetector(
                            child: Column(
                              children: [
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
                                    controller: info[index],
                                    decoration: const InputDecoration(
                                      hintText: 'ชื่อสถานที่',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุชื่อสถานที่';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    onChanged: (value) {
                                      word = value;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),);
                        },
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,
                              color: Color(0xff1D3557),),
                            Text("เพิ่มสถานที่",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1D3557)))
                          ],
                        ),
                        onTap: (){
                          setState(() {
                            print("Setting state");
                            numinfo++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 0,left: 0),
                //   child: Container(
                //       width: 358,
                //       margin: const EdgeInsets.all(10),
                //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                //       decoration: BoxDecoration(
                //         color:Colors.white,
                //         borderRadius: BorderRadius.circular(14),
                //         border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                //       ),
                //       child: TextFormField(
                //         decoration: const InputDecoration(
                //           errorStyle: TextStyle(
                //             color: Colors.red,
                //             fontSize: 12,
                //           ),
                //           hintText: 'สถานที่ต้นทาง',
                //           prefixIcon: Icon(Icons.fmd_good,color: Colors.black,),
                //           enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.white,width: 2.0)),
                //
                //         ),
                //         controller: _locationcontroller,
                //
                //         validator: (value) {
                //           if (value.isEmpty) {
                //             return 'กรุณาสถานที่ต้นทาง';
                //           }
                //           return null;
                //         },
                //         focusNode: myFocusNode,
                //       )
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 215),
                //   child: Text("สถานที่ปลายทาง", style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 0,left: 0),
                //   child: Container(
                //       width: 358,
                //       margin: const EdgeInsets.all(10),
                //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                //       decoration: BoxDecoration(
                //         color:Colors.white,
                //         borderRadius: BorderRadius.circular(14),
                //         border:  Border.all(color:Color(0xFFB0BEC5),width: 1),
                //       ),
                //       child: TextFormField(
                //         decoration: const InputDecoration(
                //           errorStyle: TextStyle(
                //             color: Colors.red,
                //             fontSize: 12,
                //           ),
                //           hintText: 'สถานที่ปลายทาง',
                //           prefixIcon: Icon(Icons.fmd_good,color: Colors.black,),
                //           enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.white,width: 2.0)),
                //
                //         ),
                //         controller: _destinationcontroller,
                //
                //         validator: (value) {
                //           if (value.isEmpty) {
                //             return 'กรุณาระบุสถานที่ปลายทาง';
                //           }
                //           return null;
                //         },
                //         focusNode: myFocusNode1,
                //       )
                //   ),
                // ),
                SizedBox(height: 10,),

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RaisedButton(
                          onPressed: () async =>  {
                            await query()
                            //
                            // await getdetailcar(),
                            // await getdetailpartnercar(),


                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ค้นหา',
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
