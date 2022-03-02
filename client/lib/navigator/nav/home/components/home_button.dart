import 'package:flutter/material.dart';
import 'package:se_app2/Home/Activity/activity.dart';
import 'package:se_app2/Home/Attraction/tourist_attraction.dart';
import 'package:se_app2/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeButton extends StatelessWidget {
  HomeButton({
    Key key,
    this.icon,
    this.text,
    this.route,
  }) : super(key: key);

  String word = '';
  Map data;
  List seaattractiondata, museumattractiondata,recdata;


  final String icon;
  final String text;
  final route;


  Future getrec() async {
    print("1");
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/activity/" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    recdata = data['foundactivity'];
    print("this");
    print(recdata);
  }
  Future getseaattraction() async {
    print("1");
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/attraction/" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    seaattractiondata = data['seaattraction'];
    print("this");
    print(seaattractiondata);
  }
  Future getmuseum() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/attraction/getmuseum" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    museumattractiondata = data['museumattraction'];
    print("this");
    print(museumattractiondata);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(route);
       if(route.toString() == "Attractionpage"){
            await getseaattraction();
            await getmuseum();
            print("0");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Attractionpage(
                      result : seaattractiondata,
                      result2: museumattractiondata,
                    )
                )
            );
       } else {Navigator.push(context, MaterialPageRoute(builder: (context) => route));}

        if(route.toString() == "activity"){
          await getrec();
          print("0");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => activity(
                    result : recdata,
                  )
              )
          );
        } else {Navigator.push(context, MaterialPageRoute(builder: (context) => route));}
      },
      child: Container(
          width: 90,
          height: 80,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.all(Radius.circular(14),),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(2, 6), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(icon,
                      width: 32.0, height: 32.0),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Text(text,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
      ),
    );
  }
}
