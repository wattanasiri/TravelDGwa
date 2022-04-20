import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Home/Restaurant/restau_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'dart:convert';

import '/Home/Accommodation/accommodation_result_item.dart';

class RestaurantResult extends StatefulWidget {

  final nameHolder;
  final result;

  const RestaurantResult(
      {Key key,
        @required this.nameHolder,
        this.result})
      : super(key: key);

  @override
  State<RestaurantResult> createState() => _RestaurantResultState();
}
Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text(stars);
}


class _RestaurantResultState extends State<RestaurantResult> {
  String ID;
  var nameEdit = TextEditingController();

  var restaurantData;
  String word = '';
  Map data;

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

  Future getData(index) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/restaurant/getData/" + ID),
      headers: {
      'Content-Type': 'application/json;charSet=UTF-8',
      'Accept': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      },
    );
    data = json.decode(res.body);
    bool userFavourited = data["userFavourited"];
    data = data["foundRes"];
    print('EEEEEEEEEEEEEEEEEEEEEEEEE');
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Restaudetail(
          data : data,
          userFavourited : userFavourited,
          favFunction: actionFavouriteChild,
          resultIndex: index,
        ))
    );
  }

  void actionFavouriteChild(index) {
    setState(() {
      resData[index]['userFavourited'] = !resData[index]['userFavourited'];
    });
  }
  Future actionFavourite(id, index) async {

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
    };

    http.Response res = await http.post(
      Uri.parse("http://10.0.2.2:8080/attraction/$id/favourite"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      setState(() {
        resData[index]['userFavourited'] = !resData[index]['userFavourited'];
      });
    }
  }

  var resData;

  @override
  void initState() {
    super.initState();
    nameEdit = TextEditingController(text: widget.nameHolder);
    word = nameEdit.text;
    resData = widget.result;
    print ("this");
    print (resData);
  }

  var sortBy = 'l-h';
  String sortByTitle = 'ราคาต่ำ - สูง';
  bool selected1 = true;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: const Color(0xff1D3557),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Color(0xffECFAFF)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    nameEdit.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Boxicons.bxs_edit_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    openEditNameDialog(context);
                  },
                ),
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),

          )
        ],
        body: Scaffold(
          backgroundColor: const Color(0xffFFF4DC),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: resData == null ? 0 : resData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(

                    onTap: () => {
                      ID = resData[index]["_id"],
                      getData(index),

                    },
                    child: GFCard(
                      elevation: 8,
                      color: const Color(0xff1D3557),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.zero,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(alignment: Alignment.bottomRight, children: <Widget>[
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Image.network('${resData[index]['image'][0]}',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 30,
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: _buildRatingStars(5),
                                ),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xffECFAFF),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(
                                        color: const Color(0xff1D3557), width: 3)),
                               child: GestureDetector(
                                onTap: () => {
                                  actionFavourite(resData[index]['_id'], index),
                                },
                                child: Container(
                                    child: resData[index]['userFavourited'] ?
                                    Icon(Icons.favorite_outlined, color: pinkColor, size: 30,) :
                                    Icon(Icons.favorite_border_rounded, color: pinkColor, size: 30,)
                                ),
                              ),),
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, bottom: 15, left: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        resData[index]['name'],
                                        style: const TextStyle(
                                            color: Color(0xffFFF4DC),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'THB',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                color: Color(0xffF69B12),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.location_pin,
                                      color: Color(0xffFFF4DC),
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        resData[index]['location'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Color(0xffFFF4DC), fontSize: 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              ],
            ),
          ),
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
                onTap: () => {},
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
                        Flexible(
                          child: Text(
                            '(3 ผลลัพธ์)',
                            style: TextStyle(
                                color: Color(0xff827E7E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
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

  Future openEditNameDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'เลือกสถานที่',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextFormField(
          autofocus: true,
          controller: nameEdit,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                setState(() {
                  word = nameEdit.text;
                });
                getRestaurant();
                Navigator.of(context).pop();
              },
              child: const Text('ตกลง'))
        ],
      ));


  void _openSortingModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(// this is new
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
                              onChanged: (value) => {
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
                              onChanged: (value) => {
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
                              onChanged: (value) => {
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
                              onChanged: (value) => {
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
    // accommodationData.sort((a, b) => a["price"].compareTo(b["price"]) as int);
    setState(() => {
      selected1 = true,
      selected2 = false,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาต่ำ - สูง',
      // ResultItem(accommodationData: accommodationData),
      // print(accommodationData)
    });
  }

  void _selectItem2(value) {
    // accommodationData.sort((a, b) => b["price"].compareTo(a["price"]) as int);
    setState(() => {
      selected1 = false,
      selected2 = true,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาสูง - ต่ำ',
      // ResultItem(accommodationData: accommodationData),
      // print(accommodationData)
    });
  }

  void _selectItem3(value) {
    setState(() => {
      selected1 = false,
      selected2 = false,
      selected3 = true,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ความนิยม'
    });
  }

  void _selectItem4(value) {
    // accommodationData.sort((a, b) => b["star"].compareTo(a["star"]) as int);
    setState(() => {
      selected1 = false,
      selected2 = false,
      selected3 = false,
      selected4 = true,
      sortBy = value,
      sortByTitle = 'ระดับดาว (5-0)'
    });
  }
}
