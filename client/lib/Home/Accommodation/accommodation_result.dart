import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smart_select/smart_select.dart';

import '/Home/Accommodation/accommodation_result_item.dart';

class AccommodationResult extends StatefulWidget {

  final nameHolder;
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final result;

  const AccommodationResult({
    Key key,
    @required this.nameHolder,
    this.checkInHolder,
    this.checkOutHolder,
    this.numberOfPeopleHolder,
    this.numberOfRoomsHolder,
    this.result
  }) : super(key: key);

  @override
  State<AccommodationResult> createState() => _AccommodationResultState();
}

class _AccommodationResultState extends State<AccommodationResult> {

  var nameEdit = TextEditingController();
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameEdit = TextEditingController(text: widget.nameHolder);
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit = TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
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
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xffECFAFF)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nameEdit.text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
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
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      openEditCheckInDialog(context)
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      color: const Color(0xff1D3557),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.login_rounded, color: Color(0xffFFF4DC)),
                            const SizedBox(width: 10),
                            Text(
                              checkInEdit.text,
                              style: const TextStyle(
                                color: Color(0xffFFF4DC),
                                fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      openEditCheckOutDialog(context)
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      color: const Color(0xff1D3557),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.login_rounded, color: Color(0xffFFF4DC)),
                            const SizedBox(width: 10),
                            Text(
                              checkOutEdit.text,
                              style: const TextStyle(
                                  color: Color(0xffFFF4DC),
                                  fontSize: 16
                              ),
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
                        onChanged: (value) => setState(() => numberOfPeopleEdit.text = value.toString()),
                      )
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      color: const Color(0xff1D3557),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.people_alt_rounded, color: Color(0xffFFF4DC)),
                            const SizedBox(width: 10),
                            Text(
                              numberOfPeopleEdit.text + ' คน',
                              style: const TextStyle(
                                  color: Color(0xffFFF4DC),
                                  fontSize: 16
                              ),
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
                        onChanged: (value) => setState(() => numberOfRoomsEdit.text = value.toString()),
                      )
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      color: const Color(0xff1D3557),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.meeting_room_rounded, color: Color(0xffFFF4DC)),
                            const SizedBox(width: 10),
                            Text(
                              numberOfRoomsEdit.text + ' ห้อง',
                              style: const TextStyle(
                                  color: Color(0xffFFF4DC),
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
              color: Color(0xff827E7E),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => {

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff1D3557),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    color: const Color(0xffECFAFF),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '(3 ผลลัพธ์)',
                            style: TextStyle(
                                color: Color(0xff827E7E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    openSorting(context)
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff1D3557),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    color: const Color(0xffECFAFF),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.sort_rounded, color: Color(0xff1D3557)),
                          SizedBox(width: 5),
                          Text(
                            'ราคาต่ำ - สูง',
                            style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ResultItem(),
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
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        content: TextFormField(
          autofocus: true,
          controller: nameEdit,
        ),
        actions: [
          TextButton(
              onPressed: () => {
                setState(() {}),
                Navigator.of(context).pop()
              },
              child: const Text('ตกลง'))
        ],
      )
  );

  Future openEditCheckInDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text(
          'วันที่เช็คอิน',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        content: TextFormField(
          controller: checkInEdit,
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
                checkInEdit.text = formattedDate;
              });
            }else {
              print("Date is not selected");
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => {
                setState(() {}),
                Navigator.of(context).pop()
              },
              child: const Text('ตกลง'))
        ],
      )
  );

  Future openEditCheckOutDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text(
          'วันที่เช็คเอาท์',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        content: TextFormField(
          controller: checkOutEdit,
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
                checkOutEdit.text = formattedDate;
              });
            }else {
              print("Date is not selected");
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => {
                setState(() {}),
                Navigator.of(context).pop()
              },
              child: const Text('ตกลง'))
        ],
      )
  );

  Future openSorting(BuildContext context) => showDialog(
      context: context,
      builder: (context) => SmartSelect.single(
        title: 'เรียงลำดับตาม',
        choiceItems: <S2Choice<String>>[
          S2Choice<String>(value: 'popular', title: 'Ionic'),
          S2Choice<String>(value: 'priceH-L', title: 'Flutter'),
          S2Choice<String>(value: 'priceL-H', title: 'React Native'),
          S2Choice<String>(value: 'rate', title: 'ระดับดาว (5-0)')
        ],
        onChange: (value) => setState(() => numberOfRoomsEdit.text = value.toString()),
        value: 'value',
      )
  );

}