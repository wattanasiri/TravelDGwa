import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'accommodation_room_item.dart';

class AccommodationRoom extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final rooms;
  final hotel_name;

  const AccommodationRoom(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.rooms,
      this.hotel_name})
      : super(key: key);

  @override
  _AccommodationRoomState createState() => _AccommodationRoomState();
}

class _AccommodationRoomState extends State<AccommodationRoom> {
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
            title: const Text(
              'Cape Dara Resort',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(
                backgroundColor: const Color(0xffFFF4DC),
                elevation: 3,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                title: SizedBox(
                  height: 50,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {openEditCheckInDialog(context)},
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: const Color(0xff1D3557),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.login_rounded,
                                    color: Color(0xffFFF4DC)),
                                const SizedBox(width: 10),
                                Text(
                                  checkInEdit.text,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC), fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {openEditCheckOutDialog(context)},
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: const Color(0xff1D3557),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.login_rounded,
                                    color: Color(0xffFFF4DC)),
                                const SizedBox(width: 10),
                                Text(
                                  checkOutEdit.text,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC), fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          showMaterialNumberPicker(
                            context: context,
                            title: "จำนวนผู้เข้าพัก",
                            maxNumber: 30,
                            minNumber: 1,
                            selectedNumber: int.parse(numberOfPeopleEdit.text),
                            onChanged: (value) => setState(() =>
                                numberOfPeopleEdit.text = value.toString()),
                          )
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: const Color(0xff1D3557),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.people_alt_rounded,
                                    color: Color(0xffFFF4DC)),
                                const SizedBox(width: 10),
                                Text(
                                  numberOfPeopleEdit.text + ' คน',
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC), fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          showMaterialNumberPicker(
                            context: context,
                            title: "จำนวนห้อง",
                            maxNumber: 30,
                            minNumber: 1,
                            selectedNumber: int.parse(numberOfRoomsEdit.text),
                            onChanged: (value) => setState(() =>
                                numberOfRoomsEdit.text = value.toString()),
                          )
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: const Color(0xff1D3557),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.meeting_room_rounded,
                                    color: Color(0xffFFF4DC)),
                                const SizedBox(width: 10),
                                Text(
                                  numberOfRoomsEdit.text + ' ห้อง',
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC), fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                RoomItem(
                  checkInHolder: checkInEdit.text,
                  checkOutHolder: checkOutEdit.text,
                  numberOfPeopleHolder: numberOfPeopleEdit.text,
                  numberOfRoomsHolder: numberOfRoomsEdit.text,
                  rooms: rooms,
                  hotel_name: hotel_name,
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
                        Text(
                          'ตัวกรอง  ',
                          style: TextStyle(
                              color: Color(0xff1D3557),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(3 ผลลัพธ์)',
                          style: TextStyle(
                              color: Color(0xff827E7E),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.sort_rounded, color: Color(0xff1D3557)),
                        const SizedBox(width: 5),
                        Text(
                          sortByTitle,
                          style: const TextStyle(
                              color: Color(0xff1D3557),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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

  Future openEditCheckInDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'วันที่เช็คอิน',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: TextFormField(
        controller: checkInEdit,
        readOnly: true,
        decoration: const InputDecoration(
          hintText: 'วว-ดด-ปปปป',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffECFAFF))),
          suffixIcon: Icon(Ionicons.calendar_outline,
            color: Color(0xff1D3557))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'กรุณาระบุวันที่';
          }
          return null;
        },
        onTap: () async {
          DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate =
              DateFormat('dd-MM-yyyy').format(pickedDate);
            print(formattedDate);

            setState(() {
              checkInEdit.text = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () =>
            {setState(() {}), Navigator.of(context).pop()},
          child: const Text('ตกลง'))
      ],
    )
  );

  Future openEditCheckOutDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'วันที่เช็คเอาท์',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: TextFormField(
        controller: checkOutEdit,
        readOnly: true,
        decoration: const InputDecoration(
          hintText: 'วว-ดด-ปปปป',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffECFAFF))),
          suffixIcon: Icon(Ionicons.calendar_outline,
            color: Color(0xff1D3557))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'กรุณาระบุวันที่';
          }
          return null;
        },
        onTap: () async {
          DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(pickedDate);
            print(formattedDate);

            setState(() {
              checkOutEdit.text = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
      actions: [
        TextButton(
            onPressed: () =>
                {setState(() {}), Navigator.of(context).pop()},
            child: const Text('ตกลง'))
      ],
    )
  );

  void _openSortingModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
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
                    color: const Color(0xffC4C4C4)
                  )
                ),
                const SizedBox(height: 20.0),
                const Center(
                  child: Text(
                    'เรียงลำดับตาม',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFFF4DC)
                    ),
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
      }
    );
  }

  void _selectItem1(value) {
    setState(() => {
      selected1 = true,
      selected2 = false,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาต่ำ - สูง',
    });
  }

  void _selectItem2(value) {
    setState(() => {
      selected1 = false,
      selected2 = true,
      selected3 = false,
      selected4 = false,
      sortBy = value,
      sortByTitle = 'ราคาสูง - ต่ำ',
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
