import 'package:flutter/material.dart';
import 'package:se_app2/Home/Activity/activity.dart';
import 'package:se_app2/Home/Attraction/tourist_attraction.dart';
import 'package:se_app2/Home/Map/lifestyle.dart';
import 'package:se_app2/Home/Map/mapmain.dart';
import 'package:se_app2/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Data/data_currentuser.dart';
import '../../../../Home/Restaurant/restaurant.dart';

class HomeButton extends StatelessWidget {
  HomeButton({
    Key key,
    this.icon,
    this.text,
    this.route,
  }) : super(key: key);

  String word = '';
  Map data;

  List seaattractiondata, museumattractiondata, seafoodrestaurantdata, cruiserestaurantdata,recdata;


  final String icon;
  final String text;
  final route;
  bool checklifestyleis;
  Map dataafterquery,dataquerymap;
  String weather,adventure,sea,confidence,bagpack,budget,social = '0';

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

  Future getseafood() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/restaurant" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    seafoodrestaurantdata = data['seafoodrestaurant'];
    print("this");
    print(seafoodrestaurantdata);
  }

  Future getcruise() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/restaurant/getcruise" ));
    data = json.decode(res.body);
    print("this");
    print(data);
    cruiserestaurantdata = data['cruiserestaurant'];
    print("this");
    print(cruiserestaurantdata);
  }

  Future querydata() async{
    Datauser datauser = Datauser();
    print('querydata');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/map/" + datauser.id + '/querydatamap'));
    dataquerymap = json.decode(res.body);
    print(dataquerymap);
  }


  Future checklifestyle() async {
    try{
      print('check');
      Datauser datauser = Datauser();
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
       }
       else if(route.toString() == "activity"){
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
       }
       else  if (route.toString() == "Restaurantpage"){
         print("res");
         await getseafood();
         await getcruise();
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => Restaurantpage(
                   result : seafoodrestaurantdata,
                   result2: cruiserestaurantdata,
                 )
             )
         );
       } else if(route.toString() == "Mapmain"){
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
       else {Navigator.push(context, MaterialPageRoute(builder: (context) => route));}
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
