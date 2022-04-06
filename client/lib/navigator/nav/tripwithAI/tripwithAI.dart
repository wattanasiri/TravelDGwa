import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/data_currentuser.dart';
import 'lifestyle.dart';
import 'mapmain.dart';

class TripWithAI extends StatefulWidget {

  const TripWithAI({Key key}) : super(key: key);

  @override
  _TripWithAIState createState() => _TripWithAIState();
}

class _TripWithAIState extends State<TripWithAI> {
  bool checklifestyleis;
  Map dataafterquery,dataquerymap;
  String weather,adventure,sea,confidence,bagpack,budget,social = '0';
  Datauser datauser = Datauser();
  Future querydata() async{
    print('querydata');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydatamap'));
    dataquerymap = json.decode(res.body);
    print(dataquerymap);
  }

  Future getdataid() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('getuserid');
    http.Response res =
    await http.get(Uri.parse('http://10.0.2.2:8080/map/getuserid'), headers: {
      'Content-Type': 'application/json;charSet=UTF-8',
      'Accept': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
    },);
    print(json.decode(res.body));
    datauser.id = json.decode(res.body);
  }
  Future checklifestyle() async {


    try{
      print('check');
      Datauser datauser = Datauser();
      print(datauser.id);
      http.Response res =
      await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/infolifestyleuser'));
      dataafterquery = json.decode(res.body);
      print(dataafterquery['foundinfo'].length);
      print(dataafterquery['foundinfo']);
      if(dataafterquery['foundinfo'].length != 0){
        weather = dataafterquery['foundinfo'][0]['Weather'].toString();
        adventure = dataafterquery['foundinfo'][0]['Adventure'].toString();
        sea = dataafterquery['foundinfo'][0]['Sea'].toString();
        confidence = dataafterquery['foundinfo'][0]['Confidence'].toString();
        bagpack = dataafterquery['foundinfo'][0]['BagPack'].toString();
        budget = dataafterquery['foundinfo'][0]['Budget'].toString();
        social = dataafterquery['foundinfo'][0]['social'].toString();
        checklifestyleis = true;
        print('true');

        // model();
      }else{
        checklifestyleis = false;
        print('false');
        // savedata();
      }
    }catch(e){
      print(e);
      checklifestyleis = false;
    }
  }
  Future check(int index) async {
    bool echeck = false;
    if(index == 2){
      echeck = true;
      await getdataid();
      await checklifestyle();
      print(checklifestyleis);
      await querydata();
      if(checklifestyleis){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Mapmain(
                  dataquerymap: dataquerymap,
                  weather : weather,
                  adventure :  adventure,
                  sea : sea,
                  confidence: confidence,
                  bagpack: bagpack,
                  budget: budget,
                  social : social,
                )
            )
        );
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => lifestyle(
                  dataquerymap: dataquerymap,
                )
            )
        );
      }
    }
    return echeck;
  }
  void initState() {
    check(2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D3557),
      body: Center(
        child: Text(
          'Loading ...',
          style: TextStyle(
              color: Color(0xffECFAFF),
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}