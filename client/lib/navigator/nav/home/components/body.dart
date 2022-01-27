import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'homepage.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50),
        child: Home()
      ),

    );
  }
}