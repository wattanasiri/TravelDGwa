import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profile/profile_edit.dart';
import 'blog_detail.dart';
import 'blogpost/add_post_gall.dart';

class Blog extends StatefulWidget {

  const Blog({Key key}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color(0xFFFFF4DC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only( top : 30, right: 20, left: 20),
            decoration: const BoxDecoration(
                color : Color(0xFFFFF4DC),
                borderRadius : BorderRadius.only(bottomRight: Radius.circular(1),bottomLeft: Radius.circular(1)
                )
            ),
            child: Column(
              children: [
                Form(
                  //key: _formKey,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text("ค้นหาร้านอาหาร",
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.normal,
                          //         color: Color(0xffECFAFF))),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            width: 350,
                            decoration: BoxDecoration(
                                color: const Color(0xffECFAFF),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                                /*border: Border.all(
                                    color: const Color(0xff1D3557), width: 2)*/),
                            child: TextFormField(
                              //controller: name,
                              decoration: const InputDecoration(
                                  hintText: 'ค้นหาบล็อค',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffECFAFF))),
                                  suffixIcon:
                                  Icon(Icons.search, color: Color(0xff1D3557))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาระบุร้านอาหาร';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                //word = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      /*//ปุ่มเซิร์ช
                      const SizedBox(height: 30),
                      ElevatedButton(
                        //onPressed: () => getItemAndNavigate(context),
                        style: ElevatedButton.styleFrom(
                          onPrimary: const Color(0xff1D3557),
                          primary: const Color(0xff1D3557),
                          minimumSize: const Size(350, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text(
                          'ค้นหาร้านอาหาร',
                          style: TextStyle(color: Color(0xffFFF4DC), fontSize: 20),
                        ),
                      ),*/
                      //const SizedBox(height: 30),
                      /*const Divider(
                        thickness: 1.5,
                        indent: 25,
                        endIndent: 25,
                        color: Color(0xff827E7E),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //เริ่มบล็อคที่กำลังเป็นที่นิยม
                  Text(" บล็อคที่กำลังเป็นที่นิยม", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only( right: 20),
                          scrollDirection: Axis.horizontal,
                          //itemCount: widget.result == null ? 0 : widget.result.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child : GestureDetector(
                                onTap: () {
                                  //selectid = widget.result[index]["_id"];
                                  //getdatafromid();
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 3,
                                      color: const Color(0xffECFAFF),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),

                                      child: Container(
                                        height: 260,
                                        width: 200,
                                        child : Column(
                                          children: <Widget> [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                              child: Image.network(
                                                  //"${widget.result[index]['image'][0]}",
                                                "https://i.ytimg.com/vi/Eanaq7dw9Hk/maxresdefault.jpg",
                                                  height: 150,
                                                  width: MediaQuery.of(context).size.width,
                                                  fit: BoxFit.cover),
                                            ),
                                            SizedBox(
                                              height: 100,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 15.0, top: 10),
                                                    child: Text(
                                                      //"${widget.result[index]['name']}",
                                                      "name",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color(0xff1D3557),
                                                          fontWeight: FontWeight.w900,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children:  const <Widget>[
                                                          SizedBox(width: 15,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  "ราคาเริ่มต้นที่",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff1D3557),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result[index]['price']} บาท",
                                                                  "price" ,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                    padding: const EdgeInsets.only(top: 15, left: 30),
                    child: const Text(
                      "กำลังเป็นที่นิยม",
                      style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                    ),
                  ),*/
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only( right: 20),
                          scrollDirection: Axis.horizontal,
                          //itemCount: widget.result2 == null ? 0 : widget.result2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child : GestureDetector(
                                onTap: () {
                                  //selectid = widget.result2[index]["_id"];
                                  //getdatafromid();
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Blogdetail())
                                  );
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 3,
                                      color: const Color(0xff1D3557),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),

                                      child: Container(
                                        height: 260,
                                        width: 200,
                                        child : Column(
                                          children: <Widget> [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                              child: Image.network(
                                                //"${widget.result2[index]['image'][0]}",
                                                  "https://i.ytimg.com/vi/Eanaq7dw9Hk/maxresdefault.jpg",
                                                  height: 150,
                                                  width: MediaQuery.of(context).size.width,
                                                  fit: BoxFit.cover),
                                            ),
                                            SizedBox(
                                              height: 100,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox( height: 10,),
                                                      Row(
                                                        children:  const <Widget>[
                                                          SizedBox(width: 15,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  "สะพานลิงไม้ ข้ามแม่น้ำน่าน เขาตะปู",
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xffFFF4DC),
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children:  <Widget>[Padding(
                                                              padding: EdgeInsets.only(left: 10),
                                                              child: Icon(Icons.location_on,
                                                                  color: Color(0xff66c57f),
                                                                  size: 18),
                                                            ),
                                                              SizedBox(width: 7,),
                                                              Flexible(
                                                                  child : Padding(
                                                                    padding: EdgeInsets.only(top: 4),
                                                                    child: Text(
                                                                      // "${widget.result[index]['price']} บาท",
                                                                      "อำเภอตะกั่วทุ่ง,จังหวัดพังงา" ,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          color: Color(0xff66c57f),
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 10),
                                                                    ),
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                          /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                                        ],
                                                      ),
                                                      /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //จบบล็อคที่กำลังเป็นที่นิยม
                  SizedBox(height: 0,),
                  // Divider(thickness: 1, color: Color(0xff827E7E)),
                  //เริ่มจังหวัดที่กำลังนิยม
                  Text(" หมวดหมู่", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
                  SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150.0,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only(left: 5, right: 20),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://narniafans.com/wp-content/uploads/2012/05/sea.jpg'),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.topCenter,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken)),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox( height: 10,),
                                          Row(
                                            children:  const <Widget>[
                                              SizedBox(width: 70,),
                                              Flexible(
                                                  child : Padding(
                                                    padding: EdgeInsets.only(top: 4),
                                                    child: Text(
                                                      "ท่องเที่ยวทะเล",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color(0xffFFF4DC),
                                                          fontWeight: FontWeight.w900,
                                                          fontSize: 25),
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                            /*Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children:  <Widget>[Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Icon(Icons.location_on,
                                                      color: Color(0xff66c57f),
                                                      size: 18),
                                                ),
                                                  SizedBox(width: 7,),
                                                  Flexible(
                                                      child : Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: Text(
                                                          // "${widget.result[index]['price']} บาท",
                                                          "อำเภอตะกั่วทุ่ง,จังหวัดพังงา" ,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: Color(0xff66c57f),
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 10),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              ),
                                              /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                            ],
                                          ),
                                          Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                child: Container(
                                  width: 280,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://64.media.tumblr.com/9e28d3e77d573f42aee3c425635406ca/fe2aa2126deee992-d8/s540x810/d997f41e051d5da08147f5004a522bfac9dd6704.gifv'),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.topCenter,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken)),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox( height: 10,),
                                          Row(
                                            children:  const <Widget>[
                                              SizedBox(width: 75,),
                                              Flexible(
                                                  child : Padding(
                                                    padding: EdgeInsets.only(top: 4),
                                                    child: Text(
                                                      "ท่องเที่ยวป่า",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color(0xffFFF4DC),
                                                          fontWeight: FontWeight.w900,
                                                          fontSize: 25),
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                          /*Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children:  <Widget>[Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Icon(Icons.location_on,
                                                      color: Color(0xff66c57f),
                                                      size: 18),
                                                ),
                                                  SizedBox(width: 7,),
                                                  Flexible(
                                                      child : Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: Text(
                                                          // "${widget.result[index]['price']} บาท",
                                                          "อำเภอตะกั่วทุ่ง,จังหวัดพังงา" ,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: Color(0xff66c57f),
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 10),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              ),
                                              /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                            ],
                                          ),
                                          Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //จบจังหวัดที่กำลังนิยม
                  SizedBox(height: 20,),
                  // Divider(thickness: 1, color: Color(0xff827E7E)),
                  //เริ่มบล็อคล่าสุด
                  Text(" บล็อคล่าสุด", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff1D3557))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                    padding: const EdgeInsets.only(top: 15, left: 30),
                    child: const Text(
                      "กำลังเป็นที่นิยม",
                      style: TextStyle(fontSize: 18, color: Color(0xff1D3557)),
                    ),
                  ),*/
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.only( right: 20),
                          scrollDirection: Axis.horizontal,
                          //itemCount: widget.result2 == null ? 0 : widget.result2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child : GestureDetector(
                                onTap: () {
                                  //selectid = widget.result2[index]["_id"];
                                  //getdatafromid();
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 3,
                                      color: const Color(0xff1D3557),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),

                                      child: Container(
                                        height: 260,
                                        width: 200,
                                        child : Column(
                                          children: <Widget> [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                              child: Image.network(
                                                  //"${widget.result2[index]['image'][0]}",
                                                "https://i.ytimg.com/vi/Eanaq7dw9Hk/maxresdefault.jpg",
                                                  height: 150,
                                                  width: MediaQuery.of(context).size.width,
                                                  fit: BoxFit.cover),
                                            ),
                                            SizedBox(
                                              height: 100,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox( height: 10,),
                                                      Row(
                                                        children:  const <Widget>[
                                                          SizedBox(width: 15,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  "สะพานลิงไม้ ข้ามแม่น้ำน่าน เขาตะปู",
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xffFFF4DC),
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.location_on,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result[index]['price']} บาท",
                                                                  "อำเภอตะกั่วทุ่ง,จังหวัดพังงา" ,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 10),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                          /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                                        ],
                                                      ),
                                                      /*Row(
                                                        children:  <Widget>[Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Icon(Icons.monetization_on_rounded,
                                                              color: Color(0xff66c57f),
                                                              size: 18),
                                                        ),
                                                          SizedBox(width: 7,),
                                                          Flexible(
                                                              child : Padding(
                                                                padding: EdgeInsets.only(top: 4),
                                                                child: Text(
                                                                  // "${widget.result2[index]['price']} บาท",
                                                                  "price",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(0xff66c57f),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14),
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),*/
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //จบที่บล็อคล่าสุด
                  SizedBox(height: 20,),
                  //Divider(thickness: 1, color: Color(0xff827E7E)),
                ],
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Addpostgallery()
          ));
        },
        backgroundColor: Color(0xffFF831F),
        child: Icon(Icons.add,size: 40,),
      ),
    );
  }
  }

