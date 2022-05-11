import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class accom_register2 extends StatefulWidget {
  accom_register2({this.image});
  var image;


  @override
  _accom_register2State createState() => _accom_register2State();
}

class _accom_register2State extends State<accom_register2> {
  String word = '';
  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode acFocusNode = FocusNode();
  FocusNode acFocusNode2 = FocusNode();

  final name = TextEditingController();
  final size = TextEditingController();

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
            'รายละเอียดท้องพัก',
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
                  children: [
                    SizedBox(height: 30),
                    Container(child: Image.network(widget.image)),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text("ชนิดของห้องพัก",
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.normal,
                    //               color: Color(0xff1D3557))),
                    //       const SizedBox(height: 5),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 16, vertical: 2),
                    //         width: 350,
                    //         decoration: BoxDecoration(
                    //             color: const Color(0xffECFAFF),
                    //             borderRadius: BorderRadius.circular(15),
                    //             border: Border.all(
                    //                 color: const Color(0xff1D3557), width: 2)),
                    //
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text("ขนาดของที่พัก",
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.normal,
                    //               color: Color(0xff1D3557))),
                    //       const SizedBox(height: 5),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 16, vertical: 2),
                    //         width: 350,
                    //         decoration: BoxDecoration(
                    //             color: const Color(0xffECFAFF),
                    //             borderRadius: BorderRadius.circular(15),
                    //             border: Border.all(
                    //                 color: const Color(0xff1D3557), width: 2)),
                    //         child: TextFormField(
                    //           controller: size,
                    //           decoration: const InputDecoration(
                    //             hintText: 'เช่น Perfect For Families',
                    //             enabledBorder: UnderlineInputBorder(
                    //                 borderSide:
                    //                 BorderSide(color: Color(0xffECFAFF))),
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'กรุณาระบุชื่อที่พัก';
                    //             }
                    //             return null;
                    //           },
                    //           focusNode: acFocusNode2,
                    //           onChanged: (value) {
                    //             word = value;
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> type = [
  "Normal",
  "Suite"
];
