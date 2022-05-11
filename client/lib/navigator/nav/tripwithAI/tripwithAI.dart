import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/data_currentuser.dart';
import '../../../constants.dart';
import 'lifestyle.dart';
import 'mapmain.dart';
import 'dart:math';

class TripWithAI extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;

  TripWithAI(
      {this.color1 = Colors.deepOrangeAccent,
        this.color2 = Colors.yellow,
        this.color3 = Colors.lightGreen});
  @override
  _TripWithAIState createState() => _TripWithAIState();
}

class _TripWithAIState extends State<TripWithAI> with TickerProviderStateMixin{
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  bool statussuccess = false;
  bool statusunsuccess = false;
  bool checklifestyleis;
  Map dataafterquery, dataquerymap;
  String weather, adventure, sea, confidence, bagpack, budget, social = '0';
  Datauser datauser = Datauser();
  Future querydata() async {
    print('querydata');
    http.Response res = await http.get(
        Uri.parse("$SERVER_URL/map/" + datauser.id + '/querydatamap'));
    dataquerymap = json.decode(res.body);
    print(dataquerymap);
    for(int i=0 ; i < dataquerymap['foundinfo'].length ; i ++){
      if(dataquerymap['foundinfo'][i]['status'] == 'success'){
        statussuccess = true;
      }
      if(dataquerymap['foundinfo'][i]['status'] == 'unsuccess'){
        statusunsuccess = true;
      }

    }
  }

  Future getdataid() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print('getuserid');
    http.Response res = await http.get(
      Uri.parse('$SERVER_URL/map/getuserid'),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(json.decode(res.body));
    datauser.id = json.decode(res.body);
  }

  Future checklifestyle() async {
    try {
      print('check');
      Datauser datauser = Datauser();
      print(datauser.id);
      http.Response res = await http.get(Uri.parse(
          "$SERVER_URL/map/" + datauser.id + '/infolifestyleuser'));
      dataafterquery = json.decode(res.body);
      print(dataafterquery['foundinfo'].length);
      print(dataafterquery['foundinfo']);
      if (dataafterquery['foundinfo'].length != 0) {
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
      } else {
        checklifestyleis = false;
        print('false');
        // savedata();
      }
    } catch (e) {
      print(e);
      checklifestyleis = false;
    }
  }

  Future check(int index) async {
    bool echeck = false;
    print('google place');
    var googlePlace = GooglePlace("AIzaSyAGo_066grp7TfW3FNglU7gnBH2TRHb2UM");
    var result = await googlePlace.queryAutocomplete.get("pizza near sydne");
    print(result.status);
    print(result);
    if (index == 2) {
      echeck = true;
      await getdataid();
      await checklifestyle();
      print(checklifestyleis);
      await querydata();

      if (checklifestyleis) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Mapmain(
                      statussuccess: statussuccess,
                      statusunsuccess: statusunsuccess,
                      dataquerymap: dataquerymap,
                      weather: weather,
                      adventure: adventure,
                      sea: sea,
                      confidence: confidence,
                      bagpack: bagpack,
                      budget: budget,
                      social: social,
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => lifestyle(
                  statussuccess: statussuccess,
                  statusunsuccess: statusunsuccess,
                      dataquerymap: dataquerymap,
                    )));
      }
    }
    return echeck;
  }

  void initState() {
    super.initState();

    controller1 = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    controller2 = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);

    controller3 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller1, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation2 = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller2, curve: Interval(0.0, 1.0, curve: Curves.easeIn)));

    animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller3,
        curve: Interval(0.0, 1.0, curve: Curves.decelerate)));

    controller1.repeat();
    controller2.repeat();
    controller3.repeat();
    check(2);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          children: <Widget>[
            new RotationTransition(
              turns: animation1,
              child: CustomPaint(
                painter: Arc1Painter(widget.color1),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ),
            new RotationTransition(
              turns: animation2,
              child: CustomPaint(
                painter: Arc2Painter(widget.color2),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ),
            new RotationTransition(
              turns: animation3,
              child: CustomPaint(
                painter: Arc3Painter(widget.color3),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}

class Arc1Painter extends CustomPainter {
  final Color color;

  Arc1Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p1 = new Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect1 = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    canvas.drawArc(rect1, 0.0, 0.5 * pi, false, p1);
    canvas.drawArc(rect1, 0.6 * pi, 0.8 * pi, false, p1);
    canvas.drawArc(rect1, 1.5 * pi, 0.4 * pi, false, p1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc2Painter extends CustomPainter {
  final Color color;

  Arc2Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p2 = new Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect2 = new Rect.fromLTWH(
        0.0 + (0.2 * size.width) / 2,
        0.0 + (0.2 * size.height) / 2,
        size.width - 0.2 * size.width,
        size.height - 0.2 * size.height);

    canvas.drawArc(rect2, 0.0, 0.5 * pi, false, p2);
    canvas.drawArc(rect2, 0.8 * pi, 0.6 * pi, false, p2);
    canvas.drawArc(rect2, 1.6 * pi, 0.2 * pi, false, p2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc3Painter extends CustomPainter {
  final Color color;

  Arc3Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p3 = new Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect3 = new Rect.fromLTWH(
        0.0 + (0.4 * size.width) / 2,
        0.0 + (0.4 * size.height) / 2,
        size.width - 0.4 * size.width,
        size.height - 0.4 * size.height);

    canvas.drawArc(rect3, 0.0, 0.9 * pi, false, p3);
    canvas.drawArc(rect3, 1.1 * pi, 0.8 * pi, false, p3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}