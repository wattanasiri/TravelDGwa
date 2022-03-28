import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Accommodation/accommodation_receipt.dart';
import 'package:http/http.dart' as http;
import 'package:se_app2/Home/Accommodation/accommodation_transaction_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccommodationTransaction extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final userNameHolder;
  final userEmailHolder;
  final userPhoneHolder;
  final room_detail;
  final hotel_name;

  const AccommodationTransaction(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.userNameHolder,
      this.userEmailHolder,
      this.userPhoneHolder,
      this.room_detail,
      this.hotel_name})
      : super(key: key);

  @override
  _AccommodationTransactionState createState() =>
      _AccommodationTransactionState();
}

class _AccommodationTransactionState extends State<AccommodationTransaction> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();

  var userName = TextEditingController();
  var userEmail = TextEditingController();
  var userPhone = TextEditingController();
  var promotionCode = TextEditingController();
  var room_detail;
  var hotel_name;

  FocusNode promotionFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode userEmailFocusNode = FocusNode();
  FocusNode userPhoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool viewVisible = false;
  List allRooms;
  Map data;

  Future addTransaction() async {
    // allRooms = room_detail;
    // data = json.encode(allRooms);
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    var res = await http.post(Uri.parse("http://10.0.2.2:8080/transaction"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Accept': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          "acc_name": hotel_name,
          "checkIn": checkInEdit.text,
          "checkOut": checkOutEdit.text,
          "room": room_detail['room_name'],
          'numberOfRoom': numberOfRoomsEdit.text,
          'priceOfRoom': room_detail['price'].toString(),
          'totalPrice':
              (int.parse(numberOfRoomsEdit.text) * room_detail['price'])
                  .toString(),
        });
    print(res.body);
  }

  // acc_Info info = acc_Info(hotel_name, checkInEdit.text, checkOutEdit.text, []);

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    hotel_name = widget.hotel_name;
    room_detail = widget.room_detail;
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
    userName = TextEditingController(text: 'Sedtawut Chalothronnarumit');
    userEmail = TextEditingController(text: 'sedtawut.62-50@gmail.com');
    userPhone = TextEditingController(text: '09-8765-4321');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
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
            'กรอกรายละเอียด',
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
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'สรุปการจอง',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: const Color(0xffECFAFF),
                            border: Border.all(
                                color: const Color(0xff1D3557), width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Wrap(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    hotel_name,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff1D3557),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'วันที่เช็คอิน : ' +
                                        checkInEdit.text +
                                        ' (14.00 น.)',
                                    style: const TextStyle(
                                        color: Color(0xff1D3557), fontSize: 16),
                                  ),
                                  Text(
                                    'วันที่เช็คเอาท์ : ' +
                                        checkOutEdit.text +
                                        ' (12.00 น.)',
                                    style: const TextStyle(
                                        color: Color(0xff1D3557), fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: const DottedLine(
                                dashColor: Color(0xff827E7E),
                                dashGapLength: 2,
                                lineThickness: 2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '(${numberOfRoomsEdit.text}x) ' +
                                        '${room_detail['room_name']}',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff1D3557),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Text(
                                    '2 ผู้เข้าพัก',
                                    style: TextStyle(
                                        color: Color(0xff1D3557), fontSize: 16),
                                  ),
                                  const Text(
                                    '1 เตียงควีนไซส์',
                                    style: TextStyle(
                                        color: Color(0xff1D3557), fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: const DottedLine(
                                dashColor: Color(0xff827E7E),
                                dashGapLength: 2,
                                lineThickness: 2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Wrap(
                                children: <Widget>[
                                  const Icon(Icons.receipt_long_rounded,
                                      color: Color(0xff1D3557)),
                                  const SizedBox(width: 5),
                                  Text(
                                    'ยกเลิกการจองฟรีจนถึงวันที่ ' +
                                        checkInEdit.text,
                                    style: const TextStyle(
                                        color: Color(0xff1D3557), fontSize: 14),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'ข้อมูลติดต่อ',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      InkWell(
                          onTap: () => {_openEditContactModal()},
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  border: Border.all(
                                      color: const Color(0xff1D3557), width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('ชื่อ : ' + userName.text,
                                            style: const TextStyle(
                                                color: Color(0xff1D3557),
                                                fontSize: 16)),
                                        Text('อีเมล : ' + userEmail.text,
                                            style: const TextStyle(
                                                color: Color(0xff1D3557),
                                                fontSize: 16)),
                                        Text(
                                            'เบอร์โทรศัพท์ : ' + userPhone.text,
                                            style: const TextStyle(
                                                color: Color(0xff1D3557),
                                                fontSize: 16))
                                      ],
                                    ),
                                  ),
                                ],
                              )))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'วิธีชำระเงิน',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      InkWell(
                          onTap: () => {},
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  border: Border.all(
                                      color: const Color(0xff1D3557), width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Icon(Boxicons.bxl_visa,
                                        color: Color(0xff1D3557), size: 60),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        userName.text,
                                        style: const TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: const Text(
                                      'เปลี่ยนบัตร',
                                      style: TextStyle(
                                          color: Color(0xff1D3557),
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              )))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'กรอกรหัสโปรโมชั่น',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Boxicons.bxs_discount, color: Color(0xff1D3557))
                        ],
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            focusNode: promotionFocusNode,
                            controller: promotionCode,
                            decoration: const InputDecoration(
                              hintText: 'ใส่รหัสส่วนลดของคุณที่นี่...',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Divider(color: Color(0xff827E7E), thickness: 1.5),
                InkWell(
                  onTap: () => {viewVisible ? hideWidget() : showWidget()},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  {viewVisible ? hideWidget() : showWidget()},
                              iconSize: 35,
                              padding: EdgeInsets.zero,
                              splashRadius: 20,
                              constraints: const BoxConstraints(),
                              icon: viewVisible
                                  ? const Icon(Icons.keyboard_arrow_up_rounded)
                                  : const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                            ),
                            const Text(
                              'ราคารวม',
                              style: TextStyle(
                                  color: Color(0xff1D3557),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Flexible(
                            child: Text(
                          'THB ' +
                              (room_detail['price'] *
                                      (int.parse(numberOfRoomsEdit.text)))
                                  .toString(),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff1D3557),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
                const Divider(color: Color(0xff827E7E), thickness: 1.5),
                Visibility(
                  visible: viewVisible,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0xffFFEEC9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            '(' +
                                numberOfRoomsEdit.text +
                                'x) ' +
                                room_detail['room_name'],
                            style: TextStyle(
                                color: Color(0xff1D3557), fontSize: 16)),
                        Text(
                            '(' +
                                numberOfRoomsEdit.text +
                                'x) ' +
                                '${room_detail['price']}',
                            style: TextStyle(
                                color: Color(0xff1D3557), fontSize: 16))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async => {
                    await addTransaction(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccommodationReceipt(
                                  checkInHolder: checkInEdit.text,
                                  checkOutHolder: checkOutEdit.text,
                                  numberOfPeopleHolder: numberOfPeopleEdit.text,
                                  numberOfRoomsHolder: numberOfRoomsEdit.text,
                                  hotel_name: hotel_name,
                                  room_detail: room_detail,
                                )))
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    onPrimary: const Color(0xff1D3557),
                    primary: const Color(0xff1D3557),
                    minimumSize: const Size(350, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  child: const Text(
                    'ยืนยันการชำระเงิน',
                    style: TextStyle(
                        color: Color(0xffFFF4DC),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _openEditContactModal() {
    showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: const BoxDecoration(
                  color: Color(0xff1D3557),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            IconButton(
                                onPressed: () async {
                                  userName.text = widget.userNameHolder;
                                  userEmail.text = widget.userEmailHolder;
                                  userPhone.text = widget.userPhoneHolder;
                                  navigatePop();
                                },
                                padding: const EdgeInsets.all(5),
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.close_rounded,
                                    color: Color(0xffFFF4DC), size: 30)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  'รายละเอียดการติดต่อ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFFF4DC)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20,
                              right: 15,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 15),
                          child: Column(
                            children: [
                              TextFormField(
                                focusNode: userNameFocusNode,
                                controller: userName,
                                style:
                                    const TextStyle(color: Color(0xffECFAFF)),
                                decoration: const InputDecoration(
                                  labelText: 'ชื่อ-นามสกุล',
                                  labelStyle:
                                      TextStyle(color: Color(0xffFFF4DC)),
                                  hintText: 'ชื่อ-นามสกุล ของผู้จอง',
                                  hintStyle:
                                      TextStyle(color: Color(0xffC4C4C4)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffFFF4DC))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุชื่อผู้จอง';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                focusNode: userEmailFocusNode,
                                controller: userEmail,
                                style:
                                    const TextStyle(color: Color(0xffECFAFF)),
                                decoration: const InputDecoration(
                                  labelText: 'อีเมล',
                                  labelStyle:
                                      TextStyle(color: Color(0xffFFF4DC)),
                                  hintText: 'อีเมล ของผู้จอง',
                                  hintStyle:
                                      TextStyle(color: Color(0xffC4C4C4)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffFFF4DC))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุอีเมลผู้จอง';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                focusNode: userPhoneFocusNode,
                                controller: userPhone,
                                style:
                                    const TextStyle(color: Color(0xffECFAFF)),
                                decoration: const InputDecoration(
                                  labelText: 'เบอร์โทรศัพท์',
                                  labelStyle:
                                      TextStyle(color: Color(0xffFFF4DC)),
                                  hintText: 'เบอร์โทรศัพท์ ของผู้จอง',
                                  hintStyle:
                                      TextStyle(color: Color(0xffC4C4C4)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffFFF4DC))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาระบุเบอร์โทรศัพท์ผู้จอง';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  navigatePop();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  onPrimary: const Color(0xff1D3557),
                                  primary: const Color(0xffECFAFF),
                                  minimumSize: const Size(350, 60),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                                child: const Text(
                                  'ยืนยันข้อมูล',
                                  style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60)
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  void navigatePop() => {setState(() {}), Navigator.of(context).pop()};
}
