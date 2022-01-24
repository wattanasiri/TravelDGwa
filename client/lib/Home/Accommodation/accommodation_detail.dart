import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Accommodation/accommodation_room.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class AccommodationDetail extends StatefulWidget {

  final checkInHolder;
  final checkOutHolder;
  final numberOfPeopleHolder;
  final numberOfRoomsHolder;
  const AccommodationDetail({
    Key key,
    @required this.checkInHolder,
    this.checkOutHolder,
    this.numberOfPeopleHolder,
    this.numberOfRoomsHolder
  }) : super(key: key);

  @override
  _AccommodationDetailState createState() => _AccommodationDetailState();
}

class _AccommodationDetailState extends State<AccommodationDetail> {

  var checkInEdit = TextEditingController();
  var checkOutEdit = TextEditingController();
  var numberOfPeopleEdit = TextEditingController();
  var numberOfRoomsEdit = TextEditingController();

  int activeIndex = 0;
  final urlImages = [
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
    'https://placeimg.com/640/480/any',
  ];

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  bool viewVisible = false ;

  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }

  @override
  void initState() {
    super.initState();
    checkInEdit = TextEditingController(text: widget.checkInHolder);
    checkOutEdit = TextEditingController(text: widget.checkOutHolder);
    numberOfPeopleEdit = TextEditingController(text: widget.numberOfPeopleHolder);
    numberOfRoomsEdit = TextEditingController(text: widget.numberOfRoomsHolder);
  }

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
                    onPageChanged: (index, reason) => {
                      setState(() => activeIndex = index)
                    }
                  ),
                  itemBuilder: (context, index, realIndex){
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
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xffECFAFF)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: buildIndicator()
                ),
                Container(
                  margin: const EdgeInsets.only(top: 380),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xffFFF4DC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                  ),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16.0,bottom: 20.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Cape Dara Resort',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff1D3557),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () => {},
                                    icon: const Icon(Boxicons.bxs_phone),
                                    color: const Color(0xff1D3557),
                                    iconSize: 30
                                  ),
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Boxicons.bxs_chat),
                                      color: const Color(0xff1D3557),
                                      iconSize: 30
                                  )
                                ],
                              )
                            ],
                          ),
                          _buildRatingStars(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff1D3557),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                    children: const <Widget>[
                                      Icon(Icons.map_rounded, color: Color(0xffFF9A62)),
                                      SizedBox(width: 10),
                                      Text(
                                        'เส้นทาง',
                                        style: TextStyle(
                                          color: Color(0xffECFAFF),
                                          fontSize: 16
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite_border_rounded,
                                  color: Color(0xff1D3557),
                                ),
                                iconSize: 30,
                                onPressed: () => {
                                  // setState(() => data.isFavorite = !data.isFavorite)
                                },
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFEEC9),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'ตำแหน่งที่ตั้ง',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    '256 หาดดารา ซ.20 ถ.พัทยานาเกลือ พัทยาเหนือ, นาเกลือ, พัทยา, ชลบุรี, ประเทศไทย, 20150',
                                    style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'รายละเอียดที่พัก',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'เคป ดารา รีสอร์ท เป็นที่พักอันยอดเยี่ยมสำหรับผู้ไปเยือนพัทยา ไม่ว่าจะเพื่อพักผ่อนท่องเที่ยวหรือติดต่อธุรกิจจากที่พักท่านสามารถเดินทาง ได้อย่างสะดวกง่ายดายไปยังทุกที่ในเมืองที่มีชีวิตชีวานี้ อีกทั้งยังอยู่ใกล้ วงเวียนโลมา, เทวารัณย์ สปา, สถานกงสุลกิติมศักดิ์สวีเดน อีกด้วย',
                                    style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => {
                              viewVisible
                                  ? hideWidget()
                                  : showWidget()
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 2, color: Color(0xff827E7E)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'ดูรีวิว',
                                    style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 16
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      viewVisible
                                          ? hideWidget()
                                          : showWidget()
                                    },
                                    icon: viewVisible
                                        ? const Icon(Icons.keyboard_arrow_up_rounded)
                                        : const Icon(Icons.keyboard_arrow_down_rounded)
                                  )
                                ],
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: viewVisible ? 500 : 0,
                            color: Colors.green,
                            child: const Center(child: Text('Show Hide Text View Widget in Flutter',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                  fontSize: 23)))
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccommodationRoom(
                                      checkInHolder : checkInEdit.text,
                                      checkOutHolder : checkOutEdit.text,
                                      numberOfPeopleHolder : numberOfPeopleEdit.text,
                                      numberOfRoomsHolder : numberOfRoomsEdit.text,
                                    )
                                  )
                                )
                              },
                              style: ElevatedButton.styleFrom(
                                onPrimary: const Color(0xff1D3557),
                                primary: const Color(0xff1D3557),
                                minimumSize: const Size(350, 60),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                              child: const Text(
                                'จองห้องพัก',
                                style: TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontSize: 20
                                ),),
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
      dotColor: const Color(0xffECFAFF).withOpacity(0.5)
    ),
  );
}
