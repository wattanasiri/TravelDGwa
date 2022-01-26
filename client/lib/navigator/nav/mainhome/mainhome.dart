import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/Home/Accommodation/accommodation.dart';

class MainHome extends StatefulWidget {

  const MainHome({Key key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4DC),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => AccommodationPage()
            ));
          },
          child: Container(
            height: 50,
            width: 150,
            color: Colors.blue,
            child: Center(child: Text('Accommodation')),
          ),
        ),
      ),
    );
  }
}
