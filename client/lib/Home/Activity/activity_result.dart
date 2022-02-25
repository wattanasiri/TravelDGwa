import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class activity_result extends StatefulWidget {
  const activity_result({Key key}) : super(key: key);

  @override
  _activity_resultState createState() => _activity_resultState();
}

class _activity_resultState extends State<activity_result> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[

        ]
    ),
        ]
    ),
      ),
    );
  }
}
