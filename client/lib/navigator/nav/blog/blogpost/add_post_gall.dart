import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/blog/blogpost/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import 'add_post_detail.dart';

class Addpostgallery extends StatefulWidget {
  bool check;
  @override
  State<Addpostgallery> createState() => _AddpostgalleryState();
}
Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text(stars);
}

class _AddpostgalleryState extends State<Addpostgallery> {
  bool viewVisible = false;

  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _singleChildController = ScrollController();

  void _gridListener() {
    if (_gridScrollController.offset <
        _gridScrollController.position.minScrollExtent - 50) {
      _singleChildController.animateTo(_gridScrollController.offset,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    }
  }
  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    _gridScrollController.addListener(_gridListener);
    _singleChildController.addListener(_gridListener);
    Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xffECFAFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'เขียนบล็อค',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          flexibleSpace: const SizedBox(
            height: 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Addpostdetail()
                  ));
                },
                child: Text(
                  'ต่อไป',
                  style: TextStyle(
                      color: Color(0xff7BEE99)
                  ),
                ))
          ],
        ),
      ),
      body: Container(
        height: _screen.height,
        width: _screen.width,
        child: SingleChildScrollView(
          //physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _singleChildController,
          child: Column(
            children: <Widget>[
              //AddPostAppBar(screenName: 'gallery', height: 45),
              //รูปใหญ่ด้านบน
              Container(
                height: 370,
                color: Color(0xff1D3557),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image(
                        image: NetworkImage(Utils.listOfImageUrl.elementAt(0)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //_circularStackButton(icon: FontAwesome.expand),
                            /*Container(
                              width: _screen.width / 1.6,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _circularStackButton(icon: Entypo.infinity),
                                  _circularStackButton(icon: Feather.layout),
                                  _circularStackButton(
                                       icon: MaterialCommunityIcons
                                           .checkbox_multiple_blank_outline,
                                       text: 'SELECT MULTIPLE'),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //จบรูปใหญ่ด้านบน

              //ส่วนเมนูเลือกรูป
              Container(
                height: 50,
                //margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.only(top: 10 , left: 20 , right: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xff1D3557),
                ),
                child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(
                       'แกลลอรี่',
                       style: TextStyle(
                           color: Color(0xffECFAFF),
                           fontSize: 20,
                       ),
                     ),
                     Icon(Icons.keyboard_arrow_down,
                      color: const Color(0xffFF9A62),
                      size: 30),
                   ],
                 ),
              ),
              //จบส่วนเมนูเลือกรูป

              //ส่วนรูปภาพที่จะเลือก
              Container(
                height: _screen.height - 190,
                //height: 271,
                child: GridView.count(
                  controller: _gridScrollController,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List<Widget>.generate(80,
                          (index) => Container(
                        height: 300,
                        width: 300,
                        child: Image(
                          image: NetworkImage(
                              Utils.listOfImageUrl.elementAt(index)),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              //จบส่วนรูปภาพที่จะเลือก
            ],
          ),
        ),
      ),
    );
  }

  Widget _circularStackButton({
    @required IconData icon,
    String text,
  }) {
    if (text == null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Color.fromRGBO(81, 84, 86, 0.8),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      decoration: BoxDecoration(
        color: Color.fromRGBO(81, 84, 86, 0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
