import 'package:flutter/material.dart';

class Booking extends StatefulWidget {

  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4DC),
      body: Center(
        child: Text(
          'หน้าการจอง',
          style: TextStyle(
              color: Color(0xff1D3557),
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}