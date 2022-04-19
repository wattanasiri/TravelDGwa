import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'accommodation_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResultItem extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final accommodationData;
  const ResultItem({
    Key key,
    @required this.accommodationData,
    this.checkInHolder,
    this.checkOutHolder,
    this.numberOfPeopleHolder,
    this.numberOfRoomsHolder,
  }) : super(key: key);
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var data;

  RatingBarIndicator _buildRatingBar(double rating){
    return RatingBarIndicator(
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 0.7),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 20.0,
    );
  }

  void actionFavouriteChild(index) {
    setState(() {
      data[index]['userFavourited'] = !data[index]['userFavourited'];
    });
  }
  Future actionFavourite(id, index) async {

    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    final body = {
    };

    http.Response res = await http.post(
      Uri.parse("http://10.0.2.2:8080/hotel/$id/favourite"),
      headers: {
        'Content-Type': 'application/json;charSet=UTF-8',
        'Accept': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      setState(() {
        data[index]['userFavourited'] = !data[index]['userFavourited'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
    data = widget.accommodationData;
    print(numberOfRoomsEdit.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccommodationDetail(
                            checkInHolder: checkInEdit.text,
                            checkOutHolder: checkOutEdit.text,
                            numberOfPeopleHolder: numberOfPeopleEdit.text,
                            numberOfRoomsHolder: numberOfRoomsEdit.text,
                            detail: data[index],
                            favFunction: actionFavouriteChild,
                            resultIndex: index,

                        )))
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
                            child: Image.network('${data[index]['image']}',
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
                            child: Row(
                              children: [
                                _buildRatingBar(numberToDouble(data[index]['star'])),
                                SizedBox(width: 5,),
                                Text(
                                  '(${formatStar(data[index]['star'])})',
                                  style: TextStyle(
                                    color: const Color(0xffECFAFF),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
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
                              actionFavourite(data[index]['_id'], index),
                            },
                            child: Container(
                                child: data[index]['userFavourited'] ?
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
                                  data[index]['name'],
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
                                      'THB ${data[index]['price']}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Color(0xffF69B12),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const Text(
                                      '2,000.00',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Color(0xffFFF4DC),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.lineThrough),
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
                                  data[index]['location'],
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
        ));
  }
}
