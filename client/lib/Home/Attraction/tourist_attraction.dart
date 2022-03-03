import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:se_app2/Home/Attraction/tourism_result.dart';

class Attractionpage extends StatefulWidget {

  String word = '';
  Map data;
  List seaattractiondata;


  final result;
  final result2;

  Attractionpage(
      {Key key,
        this.result,this.result2})
      : super(key: key);

  @override


  _AttractionpageState createState() => _AttractionpageState();
}

class _AttractionpageState extends State<Attractionpage> {
  String word = '';
  Map data;
  List attractionData;
  List seadata;
  String selectid = '';
  Future getItemAndNavigate(BuildContext context) async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/attraction/search/" + word));
    data = json.decode(res.body);
    print ("this");
    print (data);
    attractionData = data["attraction"];
    print ("this");
    print (attractionData);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AttractionResult(
              result : attractionData,
              nameHolder : word,
            )
        )
    );
    //restaurantData = data['restaurants'];
  }

  Future gettheozone() async {
    Map data ;
    bool Check = false;
    word = selectid;
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/attraction/query/" + word));
    data = json.decode(res.body);
    data = data["foundAttraction"];
    //restaurantData = data['restaurants'];
    print(data);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Attractiondetail(
          data : data,
          check : Check,
        ))
    );

  }

  final name = TextEditingController();

  @override
  void initState(){
    super.initState();
    print("result");
    print(widget.result);
    seadata = widget.result;
    // print(seadata.length);
  }

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
            onPressed: () => Navigator.pushNamed(
              context, '/Navi',
            ),
          ),
          title: const Text(
            'สถานที่ท่องเที่ยว',
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
            children: [
              //ส่วนช่องค้นหา
              Form(
                //key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ค้นหาสถานที่ท่องเที่ยว",
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
                                hintText: 'ชื่อสถานที่ท่องเที่ยว',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffECFAFF))),
                                suffixIcon:
                                Icon(Icons.search, color: Color(0xff1D3557))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุสถานที่ท่องเที่ยว';
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
                    //จบส่วนช่องค้นหา
                    //ส่วนปุ่มค้นหา
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
                        'ค้นหาสถานที่ท่องเที่ยว',
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
              //จบส่วนปุ่มค้นหา
              //เริ่มที่เที่ยวทะเล
              Text(" แนะนำที่เที่ยวสายทะเล  !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
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
                        itemCount: seadata == null ? 0 : seadata.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child : GestureDetector(
                            onTap: () {
                              selectid = seadata[index]["_id"];
                              gettheozone();
                            },
                            child:  Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: const Color(0xffECFAFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),

                                  child: Container(
                                    height: 260,
                                    width: 200,
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          child: Image.network(
                                              "${seadata[index]['image'][0]}",
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
                                                  "${seadata[index]['name']}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color(0xff1D3557),
                                                      fontWeight: FontWeight.w900,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Row(
                                                children:  <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Icon(Icons.location_pin,
                                                        color: Color(0xff1D3557),
                                                        size: 18),
                                                  ),
                                                  SizedBox(width: 7,),
                                                  Flexible(
                                                      child : Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: Text(
                                                          "${seadata[index]['location']}",
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )

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
              Text(" แนะนำที่เที่ยวสายพิพิธภัณฑ์  !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only( right: 20),
                  scrollDirection: Axis.horizontal,
                    itemCount: widget.result2 == null ? 0 : widget.result2.length,
                    itemBuilder: (BuildContext context, int index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: GestureDetector(
                        onTap: () {
                          selectid = widget.result2[index]["_id"];
                          gettheozone();
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
                                child: Column(
                                  children: <Widget>[
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
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Row(
                                            children:  <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Icon(Icons.location_pin,
                                                    color: Color(0xff1D3557),
                                                    size: 18),
                                              ),
                                              SizedBox(width: 7,),
                                              Flexible(
                                                  child : Padding(
                                                    padding: EdgeInsets.only(top: 4),
                                                    child: Text(
                                                      "${widget.result2[index]['location']}",
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
              //จบที่เที่ยวสายพิพิธ
              Divider(thickness: 1, color: Color(0xff827E7E)),
            ],
          ),
        ]
        ),
      ),
    );
  }

}
