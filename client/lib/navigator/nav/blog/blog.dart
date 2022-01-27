import 'package:flutter/material.dart';

class Blog extends StatefulWidget {

  const Blog({Key key}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4DC),
      body: Center(
        child: Text(
          'หน้าบล็อค',
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
