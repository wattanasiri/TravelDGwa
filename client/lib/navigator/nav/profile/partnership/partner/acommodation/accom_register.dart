import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class accom_register extends StatefulWidget {


  @override
  _accom_registerState createState() => _accom_registerState();
}

class _accom_registerState extends State<accom_register> {

  String word = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();
  FocusNode acFocusNode3 = FocusNode();
  FocusNode acFocusNode4 = FocusNode();
  FocusNode acFocusNode5 = FocusNode();
  FocusNode acFocusNode6 = FocusNode();
  FocusNode acFocusNode7 = FocusNode();

  final name = TextEditingController();
  final desc = TextEditingController();
  final address = TextEditingController();
  final number_address = TextEditingController();
  final province = TextEditingController();
  final district = TextEditingController();
  final post_code = TextEditingController();

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
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () =>  Navigator.pushNamed(
              context, '/Navi',
            ),
          ),
          title: const Text(
            'รายละเอียดที่พัก',
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
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ชื่อที่พัก",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                              hintText: 'เช่น Perfect For Families',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุชื่อที่พัก';
                              }
                              return null;
                            },
                            focusNode: acFocusNode,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("คำบรรยายที่พัก",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: desc,
                            decoration: const InputDecoration(
                              hintText: 'เช่น พื้นที่กว้างขวาง วิวสวยงาม อากาศเย็นสบาย',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุคำบรรยายที่พัก';
                              }
                              return null;
                            },
                            focusNode: acFocusNode2,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ที่อยู่",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: address,
                            decoration: const InputDecoration(
                              hintText: 'ที่อยู่',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุที่อยู่';
                              }
                              return null;
                            },
                            focusNode: acFocusNode3,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("เลขที่อยู่, หมายเลขชั้น, ห้อง",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: number_address,
                            decoration: const InputDecoration(
                              hintText: 'เลขที่อยู่, หมายเลขชั้น, ห้อง',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุเลขที่อยู่, หมายเลขชั้น, ห้อง';
                              }
                              return null;
                            },
                            focusNode: acFocusNode4,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("จังหวัด",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: province,
                            decoration: const InputDecoration(
                              hintText: 'จังหวัด',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุจังหวัด';
                              }
                              return null;
                            },
                            focusNode: acFocusNode5,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ตำบล",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: district,
                            decoration: const InputDecoration(
                              hintText: 'ตำบล',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุตำบล';
                              }
                              return null;
                            },
                            focusNode: acFocusNode6,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("รหัสไปรษณีย์",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1D3557))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          width: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xffECFAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color(0xff1D3557), width: 2)),
                          child: TextFormField(
                            controller: post_code,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5)
                            ],
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'รหัสไปรษณีย์',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffECFAFF))),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาระบุรหัสไปรษณีย์';
                              }
                              return null;
                            },
                            focusNode: acFocusNode7,
                            onChanged: (value) {
                              word = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(1, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async=> {
                        // airport_partner(),
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => activity_register3(
                        //
                        // ),)),
                      },
                      style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(milliseconds: 1000),
                        onPrimary: const Color(0xffECFAFF),
                        primary: const Color(0xff1D3557),
                        minimumSize: const Size(350, 55),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      child: const Text(
                        'ถัดไป',
                        style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
