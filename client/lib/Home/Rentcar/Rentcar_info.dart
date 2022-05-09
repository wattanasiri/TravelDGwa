

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:se_app2/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Rentcar_detail_car.dart';
class Rentcar_info extends StatefulWidget {

  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data;

  Rentcar_info({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data});
  @override
  _Rentcar_infoState createState() => _Rentcar_infoState();
}

class _Rentcar_infoState extends State<Rentcar_info> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String id;
  String select_id;
  Map data;
  Map partnerdata;
  String partnerid;

  var sortBy = 'l-h';
  String sortByTitle = 'ราคาต่ำ - สูง';
  bool selected1 = true;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;

  Future getdetailpartnercar() async {
    print('getdetailpartnercar');
    http.Response res =
    await http.get(Uri.parse(
        "$SERVER_URL/rentcar/" + partnerid + '/infopartner'));
    partnerdata = json.decode(res.body);
    print(data);
    print(data['foundCar']);
    print(data['foundCar']['car_name']);
    var destination = new List(data['foundCar']['car_locationpickup'].length);
    for (int i = 0; i < data['foundCar']['car_locationpickup'].length; i++) {
      destination[i] =
          data['foundCar']['car_locationpickup'][i].toString() + ' ( + THB ' +
              data['foundCar']['car_pricelocationpickup'][i].toString() + ' )';
      print(destination[i]);
    }
    print(destination);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        cardetail(
          dategetcar: widget.dategetcar,
          timegetcar: widget.timegetcar,
          datesentcar: widget.datesentcar,
          timesentcar: widget.timesentcar,
          yourlocation: widget.yourlocation,
          destination: destination,
          data: data,
          partnerdata: partnerdata,
        ),));
  }

  Future getdetailcar() async {
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
    print('getdetailcar');
    id = select_id;
    http.Response res =
    await http.get(
        Uri.parse("$SERVER_URL/rentcar/" + id + '/infocar'));
    data = json.decode(res.body);
    partnerid = data['foundCar']['PartnerID'];
    print(partnerid);
  }

  @override
  void initState() {
    super.initState();
  }
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: Text('${widget.yourlocation}'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.data['foundCar'] == null ? 0 : widget
                .data['foundCar'].length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async =>
                {
                  print(widget.data['foundCar'][index]['_id']),
                  select_id = widget.data['foundCar'][index]['_id'],
                  await getdetailcar(),
                  getdetailpartnercar(),

                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Card(
                    elevation: 8,
                    color: const Color(0xff1D3557),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        Stack(alignment: Alignment.topLeft, children: <Widget>[
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.network('${widget
                                    .data['foundCar'][index]['car_image'][0]}',
                                    width: 180,
                                    height: 120,
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 180,
                                height: 120,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [
                                        0.0,
                                        0.85,
                                      ],
                                      colors: [
                                        Colors.transparent,
                                        Color(0xff1D3557),
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Text('${widget
                                            .data['foundCar'][index]['car_name']}',
                                          style: const TextStyle(
                                              color: Color(0xffFFF4DC),
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Text('${widget
                                            .data['foundCar'][index]['car_partnername']}',
                                          style: const TextStyle(
                                              color: Color(0xffFFF4DC),
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 30,
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 2),
                                      child: _buildRatingStars(widget
                                          .data['foundCar'][index]['car_rating']),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .airline_seat_recline_extra,
                                                color: Color(0xffFF9A62),
                                              ),
                                              SizedBox(width: 5),
                                              Text('${widget
                                                  .data['foundCar'][index]['car_nunber_sit']}',
                                                style: const TextStyle(
                                                    color: Color(0xffFFF4DC),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(width: 15),
                                              Icon(
                                                Icons
                                                    .receipt_long_outlined ,
                                                color: Color(0xffFF9A62),
                                              ),
                                              SizedBox(width: 5),
                                              Text('${widget
                                                  .data['foundCar'][index]['car_counting']}',
                                                style: const TextStyle(
                                                    color: Color(0xffFFF4DC),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text(
                                                  'ราคา/วัน เริ่มต้นที่',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 10),
                                                ),
                                                Text(
                                                  '${widget
                                                      .data['foundCar'][index]['car_price']} THB',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Color(0xffFFF4DC),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),

                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        decoration: BoxDecoration(
            color: const Color(0xffFFF4DC),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 5,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () => {
                  _openfilterModal()
                },
                child: Card(
                  elevation: 0,
                  color: const Color(0xffFFF4DC),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.filter_alt_rounded, color: Color(0xff1D3557)),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'ตัวกรอง ',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 2,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff827E7E))),
            ),
            Flexible(
              child: InkWell(
                onTap: () => {_openSortingModal()},
                child: Card(
                  elevation: 0,
                  color: const Color(0xffFFF4DC),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.sort_rounded, color: Color(0xff1D3557)),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            sortByTitle,
                            style: const TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openfilterModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder( // this is new
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  color: const Color(0xff1D3557),
                  padding: const EdgeInsets.all(15.0),
                  child: Wrap(
                    children: <Widget>[
                      Center(
                          child: Container(
                              height: 3.0,
                              width: 40.0,
                              color: const Color(0xffC4C4C4))),
                      const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          'เรียงลำดับตาม',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFF4DC)),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color(0xffFFF4DC),
                          toggleableActiveColor: const Color(0xffFF9A62),
                        ),
                        child: Column(
                          children: <Widget>[
                            RadioListTile(
                              selected: selected1,
                              groupValue: sortBy,
                              value: 'l-h',
                              onChanged: (value) =>
                              {
                                _selectItem1(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ราคาต่ำ - สูง',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected1
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected2,
                              groupValue: sortBy,
                              value: 'h-l',
                              onChanged: (value) =>
                              {
                                _selectItem2(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ราคาสูง - ต่ำ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected2
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected3,
                              groupValue: sortBy,
                              value: 'popular',
                              onChanged: (value) =>
                              {
                                _selectItem3(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ความนิยม',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected3
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected4,
                              groupValue: sortBy,
                              value: 'rate',
                              onChanged: (value) =>
                              {
                                _selectItem4(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ระดับดาว (5-0)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected4
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }

  void _selectItem1(value) {
    widget.data['foundCar'].sort((a, b) => a["car_price"].compareTo(b["car_price"]) as int);
    setState(() =>
    {
      selected1 = true,
      selected2 = false,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาต่ำ - สูง',
    });
  }

  void _selectItem2(value) {
    widget.data['foundCar'].sort((a, b) => b["car_price"].compareTo(a["car_price"]) as int);
    setState(() =>
    {
      selected1 = false,
      selected2 = true,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาสูง - ต่ำ',
    });
  }

  void _selectItem3(value) {
    widget.data['foundCar'].sort((a, b) => b["car_counting"].compareTo(a["car_counting"]) as int);
    setState(() =>
    {
      selected1 = false,
      selected2 = false,
      selected3 = true,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ความนิยม'
    });
  }

  void _selectItem4(value) {
    widget.data['foundCar'].sort((a, b) => b["car_rating"].compareTo(a["car_rating"]) as int);
    // accommodationData.sort((a, b) => b["star"].compareTo(a["star"]) as int);
    setState(() =>
    {
      selected1 = false,
      selected2 = false,
      selected3 = false,
      selected4 = true,
      sortBy = value,
      sortByTitle = 'ระดับดาว (5-0)'
    });
  }

  void _openSortingModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder( // this is new
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  color: const Color(0xff1D3557),
                  padding: const EdgeInsets.all(15.0),
                  child: Wrap(
                    children: <Widget>[
                      Center(
                          child: Container(
                              height: 3.0,
                              width: 40.0,
                              color: const Color(0xffC4C4C4))),
                      const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          'เรียงลำดับตาม',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFF4DC)),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color(0xffFFF4DC),
                          toggleableActiveColor: const Color(0xffFF9A62),
                        ),
                        child: Column(
                          children: <Widget>[
                            RadioListTile(
                              selected: selected1,
                              groupValue: sortBy,
                              value: 'l-h',
                              onChanged: (value) =>
                              {
                                _selectItem1(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ราคาต่ำ - สูง',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected1
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected2,
                              groupValue: sortBy,
                              value: 'h-l',
                              onChanged: (value) =>
                              {
                                _selectItem2(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ราคาสูง - ต่ำ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected2
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected3,
                              groupValue: sortBy,
                              value: 'popular',
                              onChanged: (value) =>
                              {
                                _selectItem3(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ความนิยม',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected3
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                            RadioListTile(
                              selected: selected4,
                              groupValue: sortBy,
                              value: 'rate',
                              onChanged: (value) =>
                              {
                                _selectItem4(value),
                                Navigator.of(context).pop()
                              },
                              title: Text(
                                'ระดับดาว (5-0)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: selected4
                                      ? const Color(0xffFF9A62)
                                      : const Color(0xffFFF4DC),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }
}

