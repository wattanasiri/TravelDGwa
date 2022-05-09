import 'package:flutter/material.dart';
import 'package:se_app2/Data/data_airport.dart';
import 'package:se_app2/Home/Restaurant/restau_detail.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Home/Restaurant/restau_result.dart';
import '../../navigator/nav/profile/creditcard/maincreditcard.dart';
import '../Attraction/tourism_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'dart:convert';

class Restaurantpage extends StatefulWidget {

  final result;
  final result2;

  Restaurantpage(
      {Key key,
        this.result,this.result2})
      : super(key: key);


  @override
  _RestaurantpageState createState() => _RestaurantpageState();
}

class _RestaurantpageState extends State<Restaurantpage> {
  String word = '';
  String selectid ;
  Map data;
  List restaurantData;

  Future getRestaurant() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/restaurant/search/" + word),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    data = json.decode(res.body);
    restaurantData = data['restaurants'];
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final name = TextEditingController();

  Future getdatafromid() async {
    Map data;
    word = selectid;
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/restaurant/querydata/" + word),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    data = json.decode(res.body);
    bool userFavourited = data["userFavourited"];
    data = data["foundRestaurant"];
    //restaurantData = data['restaurants'];
    print(word);
    print("datafromid");
    print(data);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>
            Restaudetail(
              data: data,
              userFavourited : userFavourited,
              resultIndex: -1,
            ))
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'ร้านอาหาร',
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
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ค้นหาร้านอาหาร",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff1D3557))),
                          const SizedBox(height: 5),
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
                              controller: name,
                              decoration: const InputDecoration(
                                  hintText: 'ชื่อร้านอาหาร',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                  suffixIcon:
                                  Icon(Icons.search, color: Color(0xff1D3557))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาระบุร้านอาหาร่';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                word = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      //ปุ่มเซิร์ช
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => getItemAndNavigate(context),
                        style: ElevatedButton.styleFrom(
                          onPrimary: const Color(0xff1D3557),
                          primary: const Color(0xff1D3557),
                          minimumSize: const Size(350, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text(
                          'ค้นหาร้านอาหาร',
                          style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                        thickness: 1.5,
                        indent: 25,
                        endIndent: 25,
                        color: Color(0xff827E7E),
                      ),
                    ],
                  ),
                ),
                  //เริ่มที่เที่ยวทะเล
                  Text(" ร้านแนะนำสายอาหารทะเล !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                    padding: const EdgeInsets.only(top: 15, left: 30),
                    child: const Text(
                      "กำลังเป็นที่นิยม",
                      style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                    ),
                  ),*/
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only( right: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.result == null ? 0 : widget.result.length,
                          itemBuilder: (BuildContext context, int index) {
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                           child : GestureDetector(
                              onTap: () {
                                selectid = widget.result[index]["_id"];
                                getdatafromid();
                              },
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 3,
                                    color: const Color(0xffECFAFF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),

                                    child: Container(
                                      height: 260,
                                      width: 200,
                                      child : Column(
                                        children: <Widget> [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            child: Image.network(
                                                "${widget.result[index]['image'][0]}",
                                                height: 150,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                                  child: Text(
                                                    "${widget.result[index]['name']}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Color(0xff1D3557),
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children:  const <Widget>[
                                                        SizedBox(width: 15,),
                                                        Flexible(
                                                            child : Padding(
                                                              padding: EdgeInsets.only(top: 4),
                                                              child: Text(
                                                                "ราคาเริ่มต้นที่",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Color(0xff1D3557),
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children:  <Widget>[Padding(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: Icon(Icons.monetization_on_rounded,
                                                            color: Color(0xff66c57f),
                                                            size: 18),
                                                      ),
                                                        SizedBox(width: 7,),
                                                        Flexible(
                                                            child : Padding(
                                                              padding: EdgeInsets.only(top: 4),
                                                              child: Text(
                                                                "${widget.result[index]['price']} บาท",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Color(0xff66c57f),
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //จบที่เที่ยวทะเล
                  SizedBox(height: 20,),
                  Divider(thickness: 1, color: Color(0xff827E7E)),
                  //เริ่มที่เที่ยวสายพิพิธ
                  Text(" ร้านแนะนำสายอร่อยบนเรือหรู !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                    padding: const EdgeInsets.only(top: 15, left: 30),
                    child: const Text(
                      "กำลังเป็นที่นิยม",
                      style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                    ),
                  ),*/
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only( right: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.result2 == null ? 0 : widget.result2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                             child : GestureDetector(
                              onTap: () {
                                selectid = widget.result2[index]["_id"];
                                getdatafromid();
                              },
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 3,
                                    color: const Color(0xffECFAFF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),

                                    child: Container(
                                      height: 260,
                                      width: 200,
                                      child : Column(
                                        children: <Widget> [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            child: Image.network(
                                                "${widget.result2[index]['image'][0]}",
                                                height: 150,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                                  child: Text(
                                                    "${widget.result2[index]['name']}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Color(0xff1D3557),
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children:  const <Widget>[
                                                        SizedBox(width: 15,),
                                                        Flexible(
                                                            child : Padding(
                                                              padding: EdgeInsets.only(top: 4),
                                                              child: Text(
                                                                "ราคาเริ่มต้นที่",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Color(0xff1D3557),
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children:  <Widget>[Padding(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: Icon(Icons.monetization_on_rounded,
                                                            color: Color(0xff66c57f),
                                                            size: 18),
                                                      ),
                                                        SizedBox(width: 7,),
                                                        Flexible(
                                                            child : Padding(
                                                              padding: EdgeInsets.only(top: 4),
                                                              child: Text(
                                                                "${widget.result2[index]['price']} บาท",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Color(0xff66c57f),
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                             ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //จบที่เที่ยวสายพิพิธ
                  SizedBox(height: 20,),
                  Divider(thickness: 1, color: Color(0xff827E7E)),
                ],
              ),
            ]
        ),
      ),
    );
  }
  void getItemAndNavigate(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    await getRestaurant();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RestaurantResult(
              result : restaurantData,
              nameHolder : word,
                )
        )
    );
  }
}
