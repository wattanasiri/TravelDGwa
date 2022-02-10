import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'accommodation_detail.dart';

class ResultItem extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final accommodationData;
  const ResultItem(
      {Key key,
      @required this.accommodationData,
      this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder})
      : super(key: key);
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var data;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
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
                            detail: data[index])))
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
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color:
                                  // data.isFavorite
                                  // ? Color(0xffE80138)
                                  Color(0xffC4C4C4),
                            ),
                            iconSize: 30,
                            onPressed: () => {
                              // setState(() => data.isFavorite = !data.isFavorite)
                            },
                          )),
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
