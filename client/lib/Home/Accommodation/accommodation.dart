import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'accommodation_result.dart';

class AccommodationSearch extends StatefulWidget {
  const AccommodationSearch({Key key}) : super(key: key);

  @override
  _AccommodationSearchState createState() => _AccommodationSearchState();
}

class _AccommodationSearchState extends State<AccommodationSearch> {

  String word = '';
  Map data;
  List accommodationData;

  Future getAccommodation() async {
    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:8080/hotel/search/" + word));
    data = json.decode(res.body);
    accommodationData = data['hotels'];
  }

  final name = TextEditingController();
  final checkIn = TextEditingController();
  final checkOut = TextEditingController();
  final numberOfPeople = TextEditingController(text: '1');
  final numberOfRooms = TextEditingController(text: '1');

  FocusNode accFocusNode = FocusNode();
  FocusNode accFocusNode1 = FocusNode();
  FocusNode accFocusNode2 = FocusNode();
  FocusNode accFocusNode3 = FocusNode();
  FocusNode accFocusNode4 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xffECFAFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'ค้นหาที่พัก',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
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
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "เลือกสถานที่",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff1D3557)
                            )
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            width: 350,
                            decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border:  Border.all(color: const Color(0xff1D3557),width: 2)
                            ),
                            child: TextFormField(
                              controller: name,
                              decoration: const InputDecoration(
                                hintText: 'สถานที่ หรือ ชื่อที่พัก',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffECFAFF))
                                ),
                                suffixIcon: Icon(Icons.search, color: Color(0xff1D3557))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาระบุสถานที่';
                                }
                                return null;
                              },
                              focusNode: accFocusNode,
                              onChanged: (value){
                                word = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "วันที่เช็คอิน",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff1D3557)
                                )
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                width: 170,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border:  Border.all(color: const Color(0xff1D3557),width: 2)
                                ),
                                child: TextFormField(
                                  controller: checkIn,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: 'วว-ดด-ปปปป',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xffECFAFF))
                                    ),
                                    suffixIcon: Icon(Ionicons.calendar_outline, color: Color(0xff1D3557))
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุวันที่';
                                    }
                                    return null;
                                  },
                                  focusNode: accFocusNode1,
                                  onTap: () async {
                                    DateTime pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                      print(formattedDate);

                                      setState(() {
                                        checkIn.text = formattedDate;
                                      });
                                    }else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "วันที่เช็คเอาท์",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff1D3557)
                                )
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                width: 170,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border:  Border.all(color: const Color(0xff1D3557),width: 2)
                                ),
                                child: TextFormField(
                                  controller: checkOut,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: 'วว-ดด-ปปปป',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))
                                    ),
                                    suffixIcon: Icon(Ionicons.calendar_outline, color: Color(0xff1D3557))
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุวันที่';
                                    }
                                    return null;
                                  },
                                  focusNode: accFocusNode2,
                                  onTap: () async {
                                    DateTime pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                      print(formattedDate);

                                      setState(() {
                                        checkOut.text = formattedDate; //set output date to TextField value.
                                      });
                                    }else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "จำนวนผู้เข้าพัก",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff1D3557)
                                )
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                width: 170,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border:  Border.all(color: const Color(0xff1D3557),width: 2)
                                ),
                                child: TextFormField(
                                  controller: numberOfPeople,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: '0 คน',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))
                                    ),
                                    suffixIcon: Icon(Icons.people_alt_rounded, color: Color(0xff1D3557),)
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุจำนวนผู้เข้าพัก';
                                    }
                                    return null;
                                  },
                                  focusNode: accFocusNode3,
                                  onTap: () async {
                                    showMaterialNumberPicker(
                                      context: context,
                                      title: "จำนวนผู้เข้าพัก",
                                      maxNumber: 30,
                                      minNumber: 1,
                                      selectedNumber: int.parse(numberOfPeople.text),
                                      onChanged: (value) => setState(() => numberOfPeople.text = value.toString()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "จำนวนห้อง",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff1D3557)
                                )
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                width: 170,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFAFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border:  Border.all(color: const Color(0xff1D3557),width: 2)
                                ),
                                child: TextFormField(
                                  controller: numberOfRooms,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: '0 ห้อง',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffECFAFF))
                                    ),
                                    suffixIcon: Icon(Icons.meeting_room_rounded, color: Color(0xff1D3557),)
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาระบุจำนวนห้อง';
                                    }
                                    return null;
                                  },
                                  focusNode: accFocusNode4,
                                  onTap: () async {
                                    showMaterialNumberPicker(
                                      context: context,
                                      title: "จำนวนห้อง",
                                      maxNumber: 9,
                                      minNumber: 1,
                                      selectedNumber: int.parse(numberOfRooms.text),
                                      onChanged: (value) => setState(() => numberOfRooms.text = value.toString()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        'ค้นหาที่พัก',
                        style: TextStyle(
                          color: Color(0xffFFF4DC),
                          fontSize: 20
                        ),),
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
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 30),
                  child: const Text(
                    "กำลังเป็นที่นิยม",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff1D3557)
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {

                        },
                        child: Card(
                          child: Container(
                            width: 280,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://placeimg.com/640/480/any'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'THB ' + '399.00',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _buildRatingStars(5),
                                      const Text(
                                        'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.location_pin, color: Color(0xffECFAFF), size: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              'รัชดา, กรุงเทพมหานคร',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                          )
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
                      GestureDetector(
                        onTap: () => {

                        },
                        child: Card(
                          child: Container(
                            width: 280,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://placeimg.com/640/480/any'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'THB ' + '399.00',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _buildRatingStars(5),
                                      const Text(
                                        'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.location_pin, color: Color(0xffECFAFF), size: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              'รัชดา, กรุงเทพมหานคร',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                          )
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 30),
                  child: const Text(
                    "ดีลสุดพิเศษ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff1D3557)
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {

                        },
                        child: Card(
                          child: Container(
                            width: 280,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://placeimg.com/640/480/any'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'THB ' + '399.00',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _buildRatingStars(5),
                                      const Text(
                                        'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.location_pin, color: Color(0xffECFAFF), size: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              'รัชดา, กรุงเทพมหานคร',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                          )
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
                      GestureDetector(
                        onTap: () => {

                        },
                        child: Card(
                          child: Container(
                            width: 280,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://placeimg.com/640/480/any'),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'THB ' + '399.00',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _buildRatingStars(5),
                                      const Text(
                                        'Peaberry Place, Stay Stylish in Quiet Neighborhood',
                                        style: TextStyle(
                                            color: Color(0xffECFAFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.location_pin, color: Color(0xffECFAFF), size: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              'รัชดา, กรุงเทพมหานคร',
                                              style: TextStyle(
                                                  color: Color(0xffECFAFF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                          )
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
          ],
        ),
      ),
    );
  }

  void getItemAndNavigate(BuildContext context) async{
    if (!_formKey.currentState.validate()) {
      return;
    }

    await getAccommodation();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccommodationResult(
          nameHolder : name.text,
          checkInHolder : checkIn.text,
          checkOutHolder : checkOut.text,
          numberOfPeopleHolder : numberOfPeople.text,
          numberOfRoomsHolder : numberOfRooms.text,
          result: accommodationData
        )
      )
    );
  }

}

// class SearchLocation extends StatelessWidget {
//   const SearchLocation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
