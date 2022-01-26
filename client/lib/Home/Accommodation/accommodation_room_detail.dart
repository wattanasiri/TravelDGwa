import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Accommodation/accommodation_transaction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ionicons/ionicons.dart';

class RoomDetail extends StatefulWidget {
  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  final room_detail;
  final hotel_name;

  const RoomDetail(
      {Key key,
      @required this.checkInHolder,
      this.checkOutHolder,
      this.numberOfPeopleHolder,
      this.numberOfRoomsHolder,
      this.room_detail,
      this.hotel_name})
      : super(key: key);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();
  var room_detail;
  var hotel_name;

  @override
  void initState() {
    super.initState();
    hotel_name = widget.hotel_name;
    room_detail = widget.room_detail;
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit =
        TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
  }

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height),
                CarouselSlider.builder(
                  itemCount: urlImages.length,
                  options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          {setState(() => activeIndex = index)}),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Color(0xffECFAFF)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Container(
                    height: 400,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: buildIndicator()),
                Container(
                  margin: const EdgeInsets.only(top: 380),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xffFFF4DC),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${room_detail['room_name']}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff1D3557),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'รายละเอียดที่พัก',
                                        style: TextStyle(
                                          color: Color(0xff1D3557),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: <Widget>[
                                          Icon(Ionicons.expand,
                                              color: Color(0xffFF9A62)),
                                          SizedBox(width: 15),
                                          Text(
                                            '${room_detail['area']} ตร.ม',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: const <Widget>[
                                          Icon(Ionicons.people,
                                              color: Color(0xffFF9A62)),
                                          SizedBox(width: 15),
                                          Text(
                                            '2 ผู้เข้าพัก (เข้าพักสูงสุดได้ 2 คน)',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: const <Widget>[
                                          Icon(Icons.king_bed_rounded,
                                              color: Color(0xffFF9A62)),
                                          SizedBox(width: 15),
                                          Text(
                                            '1 เตียงควีนไซส์',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: const <Widget>[
                                          Icon(Icons.chair_rounded,
                                              color: Color(0xffFF9A62)),
                                          SizedBox(width: 15),
                                          Text(
                                            '2 โซฟา',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: const <Widget>[
                                          Icon(Icons.smoke_free_rounded,
                                              color: Color(0xffFF9A62)),
                                          SizedBox(width: 15),
                                          Text(
                                            'ห้ามสูบบุหรี่',
                                            style: TextStyle(
                                              color: Color(0xff1D3557),
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Wrap(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'สิ่งอำนวยความสะดวกภายในห้อง',
                                        style: TextStyle(
                                          color: Color(0xff1D3557),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff1D3557),
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'เครื่องปรับอากาศ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFEEC9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: Color(0xff1D3557),
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'เครื่องปรับอากาศ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Wrap(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'ราคา',
                                      style: TextStyle(
                                          color: Color(0xff1D3557),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text('THB ${room_detail['price']}',
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xffF25B52),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800)),
                                          Text('2,200.00',
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          const Text('/ห้อง/คืน',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Color(0xff827E7E),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              ))
                                        ])
                                  ])
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccommodationTransaction(
                                              checkInHolder: checkInEdit.text,
                                              checkOutHolder: checkOutEdit.text,
                                              numberOfPeopleHolder:
                                                  numberOfPeopleEdit.text,
                                              numberOfRoomsHolder:
                                                  numberOfRoomsEdit.text,
                                              userNameHolder:
                                                  'Sedtawut Chalothornnarumit',
                                              userEmailHolder:
                                                  'sedtawut.62-50@gmail.com',
                                              userPhoneHolder: '09-8765-4321',
                                              room_detail: room_detail,
                                              hotel_name: hotel_name,
                                            )))
                              },
                              style: ElevatedButton.styleFrom(
                                onPrimary: const Color(0xff1D3557),
                                primary: const Color(0xff1D3557),
                                minimumSize: const Size(350, 60),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                              child: const Text(
                                'จองห้องพัก',
                                style: TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.black,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: ScaleEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: const Color(0xffECFAFF),
            dotColor: const Color(0xffECFAFF).withOpacity(0.5)),
      );
}
