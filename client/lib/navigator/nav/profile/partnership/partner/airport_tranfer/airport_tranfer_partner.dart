import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/profile/partnership/partner/airport_tranfer/airport_tranfer_register.dart';

class airport_tranfer_partner extends StatefulWidget {

  @override
  _airport_tranfer_partnerState createState() => _airport_tranfer_partnerState();
}

class _airport_tranfer_partnerState extends State<airport_tranfer_partner> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffFFF4DC),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(20),
                    primary: const Color(0xffECFAFF),
                    onPrimary: const Color(0xff1D3557),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => airport_tranfer_register(
                    ),));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.airport_shuttle_rounded, size: 50, color: Color(0xff1D3557)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '???????????????????????????????????????????????????????????????????????? - ?????????',
                              style: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 16,
                              ),
                            ),
                            // Text(
                            //   '???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ??????????????????????????????????????????????????????',
                            //   style: TextStyle(
                            //     color: Color(0xff1D3557),
                            //     fontSize: 14,
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
