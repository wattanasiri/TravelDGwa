import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ionicons/ionicons.dart';

import 'accommodation_room_detail.dart';
import 'accommodation_transaction.dart';

class RoomItem extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final rooms;
  final hotel_name;

  const RoomItem(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.rooms,
      this.hotel_name})
      : super(key: key);

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var rooms;
  var hotel_name;

  @override
  void initState() {
    super.initState();
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
    rooms = widget.rooms;
    hotel_name = widget.hotel_name;
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
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => navigateRoomDetail(context, index),
            child: GFCard(
              elevation: 8,
              color: const Color(0xff1D3557),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.zero,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    child: Image.network('https://placeimg.com/640/480/any',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${rooms[index]['room_name']}',
                                style: const TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Ionicons.expand,
                                    color: Color(0xffFF9A62),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      '${rooms[index]['area']}' + ' ตร.ม',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: const Color(0xffFFF4DC),
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.group,
                                    color: Color(0xffFF9A62),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      '2 ผู้เข้าพัก (เข้าพักสูงสุดได้ 2 คน)',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffFFF4DC),
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.king_bed_rounded,
                                    color: Color(0xffFF9A62),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      '1 เตียงควีนไซส์',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffFFF4DC),
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 4, top: 4),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.fastfood_rounded,
                                          color: Color(0xff06FF3D),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'พร้อมอาหารเช้า',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff06FF3D),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 4, top: 4),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.wifi_rounded,
                                          color: Color(0xff06FF3D),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'อินเตอร์เน็ต WIFI',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff06FF3D),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 4, top: 4),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.receipt_rounded,
                                          color: Color(0xff06FF3D),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'ยกเลิกการจองฟรี',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff06FF3D),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 4, top: 4),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.local_bar_rounded,
                                          color: Color(0xff06FF3D),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'มินิบาร์',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff06FF3D),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'THB ' + '${rooms[index]['price']}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: Color(0xffF69B12),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const Text(
                                '2,000.00',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const Text(
                                '/ห้อง/คืน',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xffFFF4DC),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () =>
                                    navigateTransaction(context, index),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: const Color(0xffFFFFFF),
                                  primary: const Color(0xffFF9A62),
                                  minimumSize: const Size(80, 50),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                                child: const Text(
                                  'จองเลย',
                                  style: TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }

  void navigateTransaction(BuildContext context, int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccommodationTransaction(
          checkInHolder: checkInEdit.text,
          checkOutHolder: checkOutEdit.text,
          numberOfPeopleHolder: numberOfPeopleEdit.text,
          numberOfRoomsHolder: numberOfRoomsEdit.text,
          userNameHolder: 'Sedtawut Chalothornnarumit',
          userEmailHolder: 'sedtawut.62-50@gmail.com',
          userPhoneHolder: '09-8765-4321',
          room_detail: rooms[index],
          hotel_name: hotel_name,
        )
      )
    );
  }

  void navigateRoomDetail(BuildContext context, int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomDetail(
          checkInHolder: checkInEdit.text,
          checkOutHolder: checkOutEdit.text,
          numberOfPeopleHolder: numberOfPeopleEdit.text,
          numberOfRoomsHolder: numberOfRoomsEdit.text,
          room_detail: rooms[index],
          hotel_name: hotel_name,
        )
      )
    );
  }
}
