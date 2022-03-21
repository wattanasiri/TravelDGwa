import 'package:flutter/material.dart';
import 'package:se_app2/navigator/nav/blog/blogpost/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class Addpostdetail extends StatefulWidget {
  bool check;
  @override
  State<Addpostdetail> createState() => _AddpostdetailState();
}
Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text(stars);
}

class _AddpostdetailState extends State<Addpostdetail> {
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
      backgroundColor : Color(0xFF1D3557),
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
                  Navigator.of(context).pop();
                },
                child: Text(
                  'โพสต์',
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
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child : Column(
                  children: [
                    //ส่วนหัวข้อ
                    Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("หัวข้อ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffECFAFF),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'หัวข้อ',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffECFAFF))),
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนหัวข้อ
                    //ส่วนที่่ตั้ง
                    Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("ที่ตั้ง",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffECFAFF),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'ที่ตั้ง',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffECFAFF))),
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนที่่ตั้ง
                    //ส่วนเนื้อหา
                    Row(
                        children: [
                          Expanded(
                            child: Container(

                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("เนื้อหา",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xffECFAFF))),
                                    const SizedBox(height: 5),
                                    Container(
                                        height: 200,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffECFAFF),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: const Color(0xffECFAFF), width: 2)
                                        ),
                                        child: Flexible(child:
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: 'เนื้อหา ',
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffECFAFF))),
                                          ),
                                        ),
                                        )
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ]
                    ),
                    //จบส่วนเนื้อหา
                  ],),),
            ],
          ),
        ),
      ),
    );
  }
}
