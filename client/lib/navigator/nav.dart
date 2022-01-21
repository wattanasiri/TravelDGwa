
import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/blog/blog.dart';
import 'package:se_app2/navigator/nav/booking/booking.dart';
import 'package:se_app2/navigator/nav/mainhome/mainhome.dart';
import 'package:se_app2/navigator/nav/profile/profile.dart';
import 'package:se_app2/navigator/nav/tripwithAI/tripwithAI.dart';

import '../main.dart';




class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    mainhome(),
    tripwithAI(),
    blog(),
    booking(),
    profile()
  ];

  void _onItemTap(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'หน้าหลัก',
            icon: Icon(Icons.home ),
            activeIcon: Icon(Icons.home_outlined ),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            label: 'การจอง',
            icon: Icon(Icons.card_travel_outlined ),
            activeIcon: Icon(Icons.card_travel),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            label: 'จัดทริป',
            icon: Icon(Icons.colorize_outlined ),
            activeIcon: Icon(Icons.colorize),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            label: 'บล็อค',
            icon: Icon(Icons.event_note_outlined),
            activeIcon: Icon(Icons.event_note),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            label: 'โปรไฟล์',
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            backgroundColor: Colors.black,
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}