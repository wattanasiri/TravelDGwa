import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:se_app2/constants.dart';

class BookingBodyNone extends StatefulWidget {

  const BookingBodyNone({Key key}) : super(key: key);

  @override
  _BookingBodyNoneState createState() => _BookingBodyNoneState();
}

class _BookingBodyNoneState extends State<BookingBodyNone> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/noticket.png',
            width: 140.0, height: size.height * 0.18,),
          Text('ยังไม่มีการจองใด ๆ ในขณะนี้',
            style: TextStyle(
              fontSize: 13,
              color: grayColor,
            ),
          ),
        ],
      ),
    );
  }
}