
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se_app2/Data/data_selectlocation.dart';
import 'package:se_app2/Home/Map/map.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../Data/data_currentuser.dart';
import '../../Data/data_locations.dart';
import '../../Data/data_selectlocation2.dart';

class Mapmain extends StatefulWidget {

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
  bool checklifestyleis;
  double group;

  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  Future checklifestyle() async {
    print('check');
    Datauser datauser = Datauser();
    http.Response res =
        await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/infolifestyleuser'));
    dataafterquery = json.decode(res.body);
    print(dataafterquery['foundinfo'].length);
    if(dataafterquery['foundinfo'].length != 0){
      checklifestyleis = true;
      print('true');
      model();
    }else{
      checklifestyleis = false;
      print('false');
      savedata();
    }
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
    int userweather = dataafterquery['foundinfo'][0]['Weather']*200;
    int useradventure = dataafterquery['foundinfo'][0]['Adventure']*200;
    int usersea = dataafterquery['foundinfo'][0]['Sea']*200;
    int userconfidence = dataafterquery['foundinfo'][0]['Confidence']*200;
    int userbagpack = dataafterquery['foundinfo'][0]['BagPack']*200;
    int userbudget = dataafterquery['foundinfo'][0]['Budget']*200;
    int usersocial = dataafterquery['foundinfo'][0]['social']*200;
    final unlabelledData = DataFrame(<Iterable<num>>[
      // [0,1000,200,400,400,600,800],
      // [1000,1000,200,400,400,600,800],
      [1000,0,200,400,400,600,800],
      // [userweather,useradventure,usersea,userconfidence,userbagpack,userbudget,usersocial]
    ], headerExists: false);
    final prediction = classifier.predict(unlabelledData);
    print(prediction);
    print(prediction.rows.first.first);
    group = prediction.rows.first.first as double;
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
    var starttime = '09:00';
    var endtime = '18:00';
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
    if (group == 1.0){
      // 120 min + 20 min journey
      numlocation = (alltime/140).toInt() - 1;
      print(numlocation);
    }else{
      // 60 min
      numlocation = (alltime/80).toInt() - 2;
      print(numlocation);
    }
    print('calculate location');
    print(typelocation);
    print(typelocation[0]);
    double distanceImMeter = 0.0;
    String picklocation = 'ร้านกาแฟ Mushroom pattaya';
    double storelat,storeendlat = 0.0;
    double storelng,storeendlng = 0.0;
    String endlocation = 'Aran Café';
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
    print(selectlocation2[0]['distance']);
    print(selectlocation2[1]['distance']);
    print(selectlocation2[2]['name']);
    print(selectlocation2[2]['distance']);
    print(selectlocation2[3]['name']);
    print(selectlocation2[3]['distance']);
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
    print('result selection');
    print(selectlocation);
    print(selectlocation.length);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample(
      data: selectlocation,
    ),

    ));

  }

  Future savedata() async {
    Datauser datauser = Datauser();
    print('save data');
    print('id');
    print(datauser.id);
    String weather,adventure,sea,confidence,bagpack,budget,social;
    weather = '1';
    adventure = '1';
    sea = '2';
    confidence = '2';
    bagpack = '2';
    budget = '2';
    social = '4';
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/map/register_mapinfo'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "usernameID" : datauser.id,
          "weather": weather,
          "adventure": adventure,
          "sea" : sea,
          "confidence": confidence,
          "bagpack": bagpack,
          "budget": budget,
          "social": social,
        });
  }

  Future _submit() async{


    await checklifestyle();
    // await model();
    // await savedata();
    // print(data.location);
    // print(data.location[0]);
    // print(data.location[0]['name']);
    // selectlocation.addAll(data.location[0]);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('แผนที่ทริป'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
