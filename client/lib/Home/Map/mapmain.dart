
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:se_app2/Data/data_selectlocation.dart';
import 'package:se_app2/Home/Map/map.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../Data/data_currentuser.dart';
import '../../Data/data_locations.dart';
import '../../Data/data_selectlocation2.dart';
import 'Trip_detail.dart';

class Mapmain extends StatefulWidget {
  Map datalifestyle;
  Mapmain({this.datalifestyle});
  @override
  State<Mapmain> createState() => _MapmainState();
}

class _MapmainState extends State<Mapmain> {
  List<dynamic> selectlocation;
  List<dynamic> selectlocation2;
  Map<String,dynamic> datalocation;
  List<String> typelocation = <String>[];
  List<int> listtarget = <int>[];
  Map dataafterquery;
  double group;
  bool checklifestyleis;
  TextEditingController
  startlocationcontroller,endlocationcontroller,stattimecontroller,endtimecontroller;

  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  Future model() async{
    final rawCsvContent = await rootBundle.loadString("assets/dataset/diabetes.csv");
    // print(rawCsvContent);
    final samples = DataFrame.fromRawCsv(rawCsvContent);
    final targetColumnName = 'Group';
    final splits = splitData(samples, [0.7]);
    final validationData = splits[0];
    final testData = splits[1];
    final validator = CrossValidator.kFold(validationData, numberOfFolds: 5);
    final createClassifier = (DataFrame samples) =>
        KnnClassifier(
          samples,
          targetColumnName,
          3,
        );
    final scores = await validator.evaluate(createClassifier, MetricType.accuracy);
    final accuracy = scores.mean();
    print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');
    final testSplits = splitData(testData, [0.8]);
    final classifier = createClassifier(testSplits[0]);
    final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);
    print('accuracy on k fold validation: ${finalScore.toStringAsFixed(2)}');
    print(classifier);
    // class 1 = park
    // class 2 = cafe,village,museum
    int userweather = widget.datalifestyle['foundinfo'][0]['Weather']*200;
    int useradventure = widget.datalifestyle['foundinfo'][0]['Adventure']*200;
    int usersea = widget.datalifestyle['foundinfo'][0]['Sea']*200;
    int userconfidence = widget.datalifestyle['foundinfo'][0]['Confidence']*200;
    int userbagpack = widget.datalifestyle['foundinfo'][0]['BagPack']*200;
    int userbudget = widget.datalifestyle['foundinfo'][0]['Budget']*200;
    int usersocial = widget.datalifestyle['foundinfo'][0]['social']*200;
    final unlabelledData = DataFrame(<Iterable<num>>[
      // [0,1000,200,400,400,600,800],
      // [1000,1000,200,400,400,600,800],
      // [1000,0,200,400,400,600,800],
      [userweather,useradventure,usersea,userconfidence,userbagpack,userbudget,usersocial]
    ], headerExists: false);
    final prediction = classifier.predict(unlabelledData);
    print(prediction);
    print(prediction.rows.first.first);
    group = prediction.rows.first.first as double;
    print('group');
    print(group);
    typelocation.clear();
    if (group == 1.0){
      typelocation.add("park");
      typelocation.add("golf course");
      typelocation.add("Museum of zoology");
      typelocation.add("shooting range");
      typelocation.add("Tourist attraction");
    }else{
      typelocation.add('cafe');
      typelocation.add('museum');
      typelocation.add('village');
      typelocation.add('temple');
      typelocation.add('cafe');
      typelocation.add('cafe');
    }
    print(typelocation);
    calculatelocation();
  }

  Future calculatelocation() async {
    print('check list');
    List<int> values = [1, 2, 3, 4];
    print(values.contains(1));
    print(values.contains(99));
    print('time');
    var date_time_starttime,date_time_endtime,date_time_default;
    var timedefault = '00:00';
    var starttime = '10:00';
    var endtime = '17:00';
    // var starttime = stattimecontroller.text;
    // var endtime = endtimecontroller.text;
    var alltime;
    int numlocation;
    date_time_default = '0000-00-00 ' + timedefault;
    date_time_starttime = '0000-00-00 ' + starttime;
    date_time_endtime = '0000-00-00 ' + endtime;
    DateTime dt2 = DateTime.parse(date_time_default);
    DateTime dt1 = DateTime.parse(date_time_starttime);
    Duration diff = dt1.difference(dt2);
    print('dif startime');
    print(diff.inMinutes);
    print(durationToString(diff.inMinutes));
    DateTime dt3 = DateTime.parse(date_time_default);
    DateTime dt4 = DateTime.parse(date_time_endtime);
    Duration diff2 = dt4.difference(dt3);
    print('dif endtime');
    print(diff2.inMinutes);
    print(durationToString(diff2.inMinutes));
    alltime = diff2.inMinutes - diff.inMinutes;
    print('alltime');
    print(alltime);
    print(durationToString(alltime));
    if (group == 1.0){
      // 90 min + 20 min journey
      numlocation = ((alltime + 20*2)/110).toInt() - 2;
      print(numlocation);
    }else{
      // 60 min
      numlocation = ((alltime+ 20*2)/80).toInt() - 2;
      print(numlocation);
    }
    print('calculate location');
    print(typelocation);
    print(typelocation[0]);
    double distanceImMeter = 0.0;
    String picklocation = 'เดอะเซียนวิวคาเฟ่';
    double storelat,storeendlat = 0.0;
    double storelng,storeendlng = 0.0;
    String endlocation = 'Aran Café จอมเทียน';
    int target = 0;
    Datalocation data = Datalocation();
    Dataselectlocation selectdata = Dataselectlocation();
    selectlocation = selectdata.selectlocation;
    Dataselectlocation2 selectdata2 = Dataselectlocation2();
    selectlocation2 = selectdata2.selectlocation2;
    for (int i = 0; i < data.location.length; i++) {
      if(picklocation == data.location[i]['name']) {
        storelat = data.location[i]['lat'];
        storelng = data.location[i]['lng'];
        selectlocation.add(
            data.location[i]
        );
      }
    }
    //endlocation
    for (int i = 0; i < data.location.length; i++) {
      if(endlocation == data.location[i]['name']) {
        storeendlat = data.location[i]['lat'];
        storeendlng = data.location[i]['lng'];
      }
    }
    listtarget.clear();
    for(int j = 0 ; j < numlocation ; j++){
      double currentdistance = 100.0;
      print('for loop first');
      print(typelocation[j]);
      for (int i = 0; i < data.location.length; i++) {
        if (typelocation[j] == data.location[i]['category'] && data.location[i]['name'] != picklocation && data.location[i]['name'] != endlocation && (!listtarget.contains(i))) {
          print('for loop second');
          print('correct');
          print(i);
          distanceImMeter = await Geolocator.distanceBetween(
            data.location[i]['lat'],
            data.location[i]['lng'],
            storelat,
            storelng,
          );
          double distance = distanceImMeter /1000;
          data.location[i]['distance'] = distance;
          if(distance < currentdistance){
            currentdistance = distance;
            target = i;
          }
        }
      }
      listtarget.add(target);
      currentdistance = 100.0;
    }
    print('listtarget');
    print(listtarget);
    //query ai location
    for(int i =0 ; i < listtarget.length ; i++){
      selectlocation2.add(
          data.location[listtarget[i]]
      );
    }
    //sort distance
    selectlocation2.sort((a, b) => a['distance'].compareTo(b['distance']) as int);
    print('selection 2');
    for (int i = 0; i < selectlocation2.length; i++) {
      selectlocation.add(
          selectlocation2[i]
      );
    }
    //endlocation
    for (int i = 0; i < data.location.length; i++) {
      if(endlocation == data.location[i]['name']) {
        selectlocation.add(
            data.location[i]
        );
      }
    }
    date_time_default = '0000-00-00 ' + timedefault;
    date_time_starttime = '0000-00-00 ' + starttime;
    date_time_endtime = '0000-00-00 ' + endtime;
    DateTime dt7 = DateTime.parse(date_time_default);
    DateTime dt8 = DateTime.parse(date_time_starttime);
    Duration diff3 = dt8.difference(dt7);
    print('dif endtime');
    print(durationToString(diff3.inMinutes));
    print('print(numlocation)');
    numlocation = numlocation +2;
    print(numlocation);
    var alltime2 = alltime - 20*(numlocation-1);
    alltime2 = alltime2/numlocation;
    alltime2 = alltime2.toInt();
    print(alltime2.toInt());
   //select time
    for (int i = 0; i < selectlocation.length; i++) {
      if(group == 2.0){
        if(i == 0) {
          selectlocation[i]['starttime'] = starttime;
          selectlocation[i]['endtime'] = durationToString(diff3.inMinutes + alltime2);
        }else{
          starttime = selectlocation[i-1]['endtime'];
          date_time_default = '0000-00-00 ' + timedefault;
          date_time_starttime = '0000-00-00 ' + starttime;
          DateTime dt7 = DateTime.parse(date_time_default);
          DateTime dt8 = DateTime.parse(date_time_starttime);
          Duration diff4 = dt8.difference(dt7);
          selectlocation[i]['starttime'] = durationToString(diff4.inMinutes + 20);
          selectlocation[i]['endtime'] = durationToString(diff4.inMinutes + 20 + alltime2);
        }
      }else{
        if(i == 0) {
          selectlocation[i]['starttime'] = starttime;
          selectlocation[i]['endtime'] = durationToString(diff3.inMinutes + alltime2);
        }else{
          starttime = selectlocation[i-1]['endtime'];
          date_time_default = '0000-00-00 ' + timedefault;
          date_time_starttime = '0000-00-00 ' + starttime;
          DateTime dt7 = DateTime.parse(date_time_default);
          DateTime dt8 = DateTime.parse(date_time_starttime);
          Duration diff4 = dt8.difference(dt7);
          selectlocation[i]['starttime'] = durationToString(diff4.inMinutes + 20);
          selectlocation[i]['endtime'] = durationToString(diff4.inMinutes + 20 + alltime2);
        }
      }

    }

    print('result selection');
    print(selectlocation);
    print(selectlocation[selectlocation.length-1]);
    print(selectlocation.length);
    date_time_default = '0000-00-00 ' + timedefault;
    date_time_starttime = '0000-00-00 ' + selectlocation[0]['starttime'];
    date_time_endtime = '0000-00-00 ' + selectlocation[selectlocation.length-1]['endtime'];
    DateTime dt10 = DateTime.parse(date_time_default);
    DateTime dt11 = DateTime.parse(date_time_starttime);
    Duration diff5 = dt11.difference(dt10);
    print(diff5.inMinutes);
    print(durationToString(diff5.inMinutes));
    DateTime dt12 = DateTime.parse(date_time_default);
    DateTime dt13 = DateTime.parse(date_time_endtime);
    Duration diff6 = dt13.difference(dt12);
    print('dif endtime');
    print(diff6.inMinutes);
    print(durationToString(diff6.inMinutes));
    alltime = diff6.inMinutes - diff5.inMinutes;
    print('alltime');
    print(alltime);
    print(durationToString(alltime));
    Navigator.push(context, MaterialPageRoute(builder: (context) => tripdetail(
      data: selectlocation,
      alltime: durationToString(alltime),
    ),));
    // ${widget.data[widget.data.length - 1]['name']}
  }

  Future _submit() async{
    print('submit');
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
    print(widget.datalifestyle);
    print(startlocationcontroller.text);
    print(endlocationcontroller.text);
    print(stattimecontroller.text);
    print(endtimecontroller.text);
    await model();
  }
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();

  void initState() {
    super.initState();
    print('datalifestyle');
    print(widget.datalifestyle);
    startlocationcontroller = TextEditingController();
    endlocationcontroller = TextEditingController();
    stattimecontroller = TextEditingController();
    endtimecontroller = TextEditingController();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : const Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(430.0),
        /* AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.pushNamed(
              context, '/Navi',
            ),
          ),
          title: const Text(
            'ไลฟ์ไสตล์การเที่ยว',
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
        ),*/
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 0),
            decoration: const BoxDecoration(
                color : Color(0xFF1d3557),
                borderRadius : BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                )
            ),

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        //ต้นทาง
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Boxicons.bxs_circle,
                                color: const Color(0xff1BC3FF),
                                size: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ต้นทาง',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xffFFF4DC) ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                    /*border: Border.all(
                                      color: const Color(0xff1D3557), width: 2)*/),
                                  child: TextFormField(
                                    controller: startlocationcontroller,
                                    focusNode: myFocusNode,
                                    decoration: const InputDecoration(
                                      hintText: 'สถานที่ต้นทาง',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                      /*suffixIcon:
                                        Icon(Icons.search, color: Color(0xff1D3557))*/
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุสถานที่ต้นทาง';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //word = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Boxicons.bx_dots_vertical_rounded,
                                color: const Color(0xffFFF4DC),
                                size: 30),
                          ],
                        ),
                        //ปลายทาง
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Icon(Boxicons.bxs_been_here,
                                color: const Color(0xffFF0000),
                                size: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ปลายทาง',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xffFFF4DC) ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                    /*border: Border.all(
                                      color: const Color(0xff1D3557), width: 2)*/),
                                  child: TextFormField(
                                    controller: endlocationcontroller,
                                    focusNode: myFocusNode1,
                                    decoration: const InputDecoration(
                                      hintText: 'สถานที่ปลายทาง',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Color(0xffECFAFF))),
                                      /*suffixIcon:
                                        Icon(Icons.search, color: Color(0xff1D3557))*/
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณาระบุสถานที่ต้นทาง';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //word = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        //เวลา
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เวลาเริ่มต้น',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xffFFF4DC) ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  width: 170,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
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
                                        return 'กรุณาระบุเวลาเริ่มต้น';
                                      }
                                      return null;
                                    },
                                    controller: stattimecontroller,
                                    focusNode: myFocusNode2,
                                    readOnly: true,
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
                                        stattimecontroller.text = formattedTime.toString();
                                      }else{
                                        print("Time is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เวลาสิ้นสุด',
                                  style: TextStyle(fontWeight: FontWeight.w900,
                                      fontSize: 15,color: Color(0xffFFF4DC) ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  width: 170,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
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

                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value == null) {
                                        return 'กรุณาระบุเวลาสิ้นสุด';
                                      }
                                      return null;
                                    },
                                    controller: endtimecontroller,
                                    focusNode: myFocusNode3,
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
                                        endtimecontroller.text = formattedTime.toString();
                                      }else{
                                        print("Time is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        //ปุ่มกดสร้าง
                        ElevatedButton(
                          /*onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                              shadowColor: MaterialStateProperty.all<Color>(Color(0xff7BEE99)),
                          ),*/
                          onPressed: () {
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                            onPrimary: const Color(0xff7BEE99),
                            primary: const Color(0xff7BEE99),
                            minimumSize: const Size(350, 60),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          child: const Text(
                            'สร้างทริป',
                            style: TextStyle(color: Color(0xff1D3557), fontSize: 20),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          title: const Text(
            'การจัดทริป',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: (){
                _submit();
                //Navigator.of(context).pop();
              },
              child: Text(
                'บันทึกทริป',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFF9A62),
                ),
              ),)
          ],

        ),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //กำลังดำเนินการ
            //ไม่มีทริปที่กำลัง
            //เอาให้ส่วนนี้หายไปเลย
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'กำลังดำเนินการ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Row(
                  children: [
                    //กล่องด้านหน้าเวลา
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff1D3557),
                        /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '8 H',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffECFAFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    //ตกแต่ง
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xff1D3557),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xff1D3557),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xff1D3557),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xff1D3557),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    //กล่องหลังข้อมูลทริป
                    Container(
                      width: 225,
                      height: 80,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff1D3557),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ชื่อทริป
                          Flexible(child: Text(
                            'ไปไหนก็ได้ทริป',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffECFAFF),
                            ),
                          ),),
                          SizedBox(height: 5,),
                          //สถานที่
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //ต้นทาง
                              Flexible(child: Text(
                                'เขาเขียว',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffECFAFF),
                                ),
                              ), ),
                              Icon(Boxicons.bx_right_arrow_alt,
                                  color: const Color(0xffFF9A62),
                                  size: 30),
                              //ปลายทาง
                              Flexible(child: Text(
                                'บางแสน',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffECFAFF),
                                ),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 10,),
            //ทริปล่าสุด
            //ไม่มรทริปล่าสุด
            /*Text(
                  'ไม่มีทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ทริปล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Row(
                  children: [
                    //กล่องด้านหน้าเวลา
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffECFAFF),
                        /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '8 H',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1D3557),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    //ตกแต่ง
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    //กล่องหลังข้อมูลทริป
                    Container(
                      width: 225,
                      height: 80,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ชื่อทริป
                          Flexible(child: Text(
                            'ไปไหนก็ได้ทริป',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1D3557),
                            ),
                          ),),
                          SizedBox(height: 5,),
                          //สถานที่
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //ต้นทาง
                              Flexible(child: Text(
                                'เขาเขียว',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ), ),
                              Icon(Boxicons.bx_right_arrow_alt,
                                  color: const Color(0xffFF9A62),
                                  size: 30),
                              //ปลายทาง
                              Flexible(child: Text(
                                'บางแสน',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    //กล่องด้านหน้าเวลา
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffECFAFF),
                        /*border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),*/
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '8 H',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1D3557),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    //ตกแต่ง
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 7,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffECFAFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    //กล่องหลังข้อมูลทริป
                    Container(
                      width: 225,
                      height: 80,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffECFAFF),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ชื่อทริป
                          Flexible(child: Text(
                            'ไปไหนก็ได้ทริป',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1D3557),
                            ),
                          ),),
                          SizedBox(height: 5,),
                          //สถานที่
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //ต้นทาง
                              Flexible(child: Text(
                                'เขาเขียว',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ), ),
                              Icon(Boxicons.bx_right_arrow_alt,
                                  color: const Color(0xffFF9A62),
                                  size: 30),
                              //ปลายทาง
                              Flexible(child: Text(
                                'บางแสน',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1D3557),
                                ),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
