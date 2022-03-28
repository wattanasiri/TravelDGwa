import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:se_app2/navigator/nav/tripwithAI/test%20to%20do%20box/page/home_page.dart';
import 'package:se_app2/navigator/nav/tripwithAI/test%20to%20do%20box/provider/todos.dart';

class todolist extends StatefulWidget {

  @override
  State<todolist> createState() => _todolistState();
}

class _todolistState extends State<todolist> {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => TodosProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFFF9A62),
      ),
      home: HomePage(),
    ),
  );
}
