import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ionicons/ionicons.dart';

import '/navigator/nav/blog/blog.dart';
import '/navigator/nav/booking/booking.dart';
import '/navigator/nav/mainhome/mainhome.dart';
import '/navigator/nav/profile/profile.dart';
import '/navigator/nav/tripwithAI/tripwithAI.dart';

class Nav extends StatefulWidget {
  const Nav({Key key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {

  int _selectedIndex = 0;
  bool isLeft = true;

  final List<Widget> _pageList = <Widget>[
    const MainHome(),
    const Booking(),
    const TripWithAI(),
    const Blog(),
    const ProfilePage()
  ];

  void _onItemTap(int index) {
    setState(()  {
      if (_selectedIndex >= index){
        isLeft = true;
      } else {
        isLeft = false;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: PageTransitionSwitcher(transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
        SharedAxisTransition(
          fillColor: const Color(0xffFFF4DC),
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child
        ),
        reverse: isLeft,
        duration: const Duration(milliseconds: 300),
        child: _pageList[_selectedIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
        onTap: _onItemTap,
        height: 85,
        curveSize: 80,
        style: TabStyle.fixed,
        initialActiveIndex: 0,
        activeColor: const Color(0xffFF9A62),
        backgroundColor: const Color(0xff1D3557),
        items: const [
          TabItem(
            title: 'หน้าหลัก',
            icon: Icon(Icons.home_rounded, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Icons.home_rounded, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'การจอง',
            icon: Icon(Ionicons.ticket, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Ionicons.ticket, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'จัดทริป',
            icon: Icon(Boxicons.bx_trip, color: Color(0xffFFF4DC), size: 32),
            activeIcon: Icon(Boxicons.bx_trip, color: Color(0xffFF9A62), size: 32),
          ),
          TabItem(
            title: 'บล็อค',
            icon: Icon(Ionicons.newspaper, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Ionicons.newspaper, color: Color(0xffFF9A62)),
          ),
          TabItem(
            title: 'โปรไฟล์',
            icon: Icon(Icons.account_circle, color: Color(0xffFFF4DC)),
            activeIcon: Icon(Icons.account_circle, color: Color(0xffFF9A62)),
          ),
        ],
      ),
    );
  }
}