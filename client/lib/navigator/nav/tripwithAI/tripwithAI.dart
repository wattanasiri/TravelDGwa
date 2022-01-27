import 'package:flutter/material.dart';

class TripWithAI extends StatefulWidget {

  const TripWithAI({Key key}) : super(key: key);

  @override
  _TripWithAIState createState() => _TripWithAIState();
}

class _TripWithAIState extends State<TripWithAI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D3557),
      body: Center(
        child: Text(
          'หน้าจัดทริป',
          style: TextStyle(
              color: Color(0xffECFAFF),
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}