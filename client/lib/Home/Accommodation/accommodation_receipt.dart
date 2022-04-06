import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/navigator/nav.dart';
import 'package:se_app2/navigator/nav/home/components/body.dart';

class AccommodationReceipt extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final room_detail;
  final hotel_name;

  const AccommodationReceipt(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.hotel_name,
      this.room_detail})
      : super(key: key);

  @override
  _AccommodationReceiptState createState() => _AccommodationReceiptState();
}

class _AccommodationReceiptState extends State<AccommodationReceipt> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var hotel_name;
  var room_detail;

  @override
  void initState() {
    super.initState();
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
    hotel_name = widget.hotel_name;
    room_detail = widget.room_detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          title: const Text(
            'ใบเสร็จ',
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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 100),
              decoration: BoxDecoration(
                  color: const Color(0xffECFAFF),
                  border: Border.all(color: const Color(0xff1D3557), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: <Widget>[
                  const Center(
                    child: Text(
                      'ใบเสร็จ',
                      style: TextStyle(
                          color: Color(0xff1D3557),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              hotel_name,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff1D3557), fontSize: 16),
                            )),
                            Flexible(
                                child: Text(
                              '#0001TH',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff827E7E), fontSize: 16),
                            ))
                          ],
                        ),
                        Row(
                          children: const <Widget>[
                            Flexible(
                                child: Text(
                              'ข้อมูลเพิ่มเติม',
                              style: TextStyle(
                                  color: Color(0xff827E7E), fontSize: 16),
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text(
                              '(${numberOfRoomsEdit.text}x) ${room_detail['room_name']}',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff827E7E), fontSize: 14),
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              'วันที่เช็คอิน ' +
                                  checkInEdit.text +
                                  ' (14.00 น.)',
                              style: const TextStyle(
                                  color: Color(0xff827E7E), fontSize: 14),
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              'วันที่เช็คเอาท์ ' +
                                  checkOutEdit.text +
                                  ' (12.00 น.)',
                              style: const TextStyle(
                                  color: Color(0xff827E7E), fontSize: 14),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const DottedLine(
                    dashColor: Color(0xff827E7E),
                    dashGapLength: 2,
                    lineThickness: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Icon(Icons.info_rounded, color: Color(0xff1D3557)),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'แจ้งชื่อที่หน้าประชาสัมพันธ์ของโรงแรมเพื่อใช้บริการ',
                            style: TextStyle(
                                color: Color(0xff1D3557), fontSize: 12),
                          ),
                        ),
                        Icon(Icons.receipt_long_rounded,
                            color: Color(0xff1D3557)),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'สามารถยกเลิกการจองได้ฟรีก่อนวันที่จอง 1 วันหากเกินกว่านั้นจะมีค่าธรรมเนียมในการยกเลิก',
                            style: TextStyle(
                                color: Color(0xff1D3557), fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                  const DottedLine(
                    dashColor: Color(0xff827E7E),
                    dashGapLength: 2,
                    lineThickness: 2,
                  ),
                  _createDataTable(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Nav()))
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
                'ไปที่หน้าการจองของฉัน',
                style: TextStyle(
                    color: Color(0xffFFF4DC),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
        dataTextStyle: const TextStyle(color: Color(0xff1D3557), fontSize: 14),
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Expanded(
              child: Text(
        'ครั้งที่',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xff1D3557), fontWeight: FontWeight.bold),
      ))),
      const DataColumn(
          label: Expanded(
              child: Text(
        'รายละเอียด',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xff1D3557), fontWeight: FontWeight.bold),
      ))),
      const DataColumn(
          label: Expanded(
              child: Text(
        'ราคา',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xff1D3557), fontWeight: FontWeight.bold),
      )))
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('1', textAlign: TextAlign.center)),
        DataCell(Text(
            '(${numberOfRoomsEdit.text}x) ${room_detail['room_name']} : 1 คืน',
            textAlign: TextAlign.start)),
        DataCell(
            Text('${room_detail['price']}' + ' THB', textAlign: TextAlign.end))
      ]),
      DataRow(cells: [
        DataCell(Text('รวม',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text('')),
        DataCell(Text(
          (room_detail['price'] * (int.parse(numberOfRoomsEdit.text)))
                  .toString() +
              ' THB',
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ])
    ];
  }
}
