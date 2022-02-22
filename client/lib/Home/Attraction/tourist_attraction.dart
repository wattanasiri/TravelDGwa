import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:se_app2/Home/Attraction/tourism_detail.dart';


class Attractionpage extends StatefulWidget {
  @override
  _AttractionpageState createState() => _AttractionpageState();
}

class _AttractionpageState extends State<Attractionpage> {
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
                    height: 270.0,
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only( right: 20),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Attractiondetail())
                            );
                          },
                          child: Card(
                            elevation: 3,
                            color: const Color(0xffECFAFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),

                            child: Container(
                              width: 220,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://placeimg.com/640/480/any'),
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.topCenter,
                                  ),
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 120,),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'เกาะ ' + 'สิมิลัน',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: const <Widget>[
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
                                                    'Mueang Phuket District',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Color(0xff1D3557),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //จบที่เที่ยวทะเล
              SizedBox(height: 20,),
              Divider(thickness: 1, color: Color(0xff827E7E)),
              //เริ่มที่เที่ยวสายพิพิธ
              Text(" แนะนำที่เที่ยวสายพิพิธภัณฑ์  !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
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
                    height: 270.0,
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only( right: 20),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Attractiondetail())
                            );
                          },
                          child: Card(
                            elevation: 3,
                            color: const Color(0xffECFAFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),

                            child: Container(
                              width: 220,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://placeimg.com/640/480/any'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                  ),
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 120,),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Acient City',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Color(0xff1D3557),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: const <Widget>[
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
                                                    'Mueang Samut Prakan  District',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Color(0xff1D3557),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                )
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
