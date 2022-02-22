import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:se_app2/Home/Accommodation/accommodation_room.dart';
import 'package:se_app2/Home/Accommodation/accommodation_transaction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class cardetail extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data,partnerdata;


  cardetail({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata});
  @override
  _cardetailState createState() => _cardetailState();
}

class _cardetailState extends State<cardetail> {

  @override
  void initState() {
    super.initState();
    print(widget.data['foundCar'][0]['car_locationpickup'].runtimeType);
    print('data');
    print(widget.data);
    print(widget.data['foundCar'][0]);
    print(widget.data['foundCar'][0]['car_price']);
    print(widget.data['foundCar'][0]['car_name']);
    print(widget.data['foundCar'][0]['car_image'][0]);
    print(widget.data['foundCar'][0]['car_image'].length);
    print('datapartner');
    print(widget.partnerdata);
    print(widget.partnerdata['foundpartner']['namepartner']);
  }

  ValueNotifier<String> price = ValueNotifier('--');
  final GlobalKey<FormState> _formKey = GlobalKey();
  String value_of_pickuppoint;
  int activeIndex = 0;
  var k =0;

  Future _price(String location) async{
    for(int i =0;i<widget.data['foundCar'][0]['car_locationpickup'].length;i++){
      if(location == widget.data['foundCar'][0]['car_locationpickup'][i]){
        k = i;
      }
    }
    price.value = (widget.data['foundCar'][0]['car_pricelocationpickup'][k]+widget.data['foundCar'][0]['car_price']).toString();

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
                  itemCount: widget.data['foundCar'][0]['car_image'].length,
                  options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                      {setState(() => activeIndex = index)}),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = widget.data['foundCar'][0]['car_image'][index];
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
                            widget.data['foundCar'][0]['car_name'],
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
                          InkWell(
                            child:  Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFEEC9),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                children: [
                                  Flexible(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CircleAvatar(radius: (28),
                                                    backgroundColor: Colors.white,
                                                    child: ClipRRect(
                                                      borderRadius:BorderRadius.circular(50),
                                                      child: Image.network(
                                                        widget.partnerdata['foundpartner']['image'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                ),


                                                Flexible(

                                                  child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                                                   child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: Text(
                                                          'ให้บริการโดย  :    ${ widget.partnerdata['foundpartner']['namepartner']}  ',
                                                          style: const TextStyle(
                                                            color: Color(0xff1D3557),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                )
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  'คลิกเพื่อดูรายละเอียดผู้ให้บริการ',
                                                  style: const TextStyle(
                                                    color: Color(0xff1D3557),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("tapped on container");
                            },
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
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          'ข้อมูลรถ',
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.app_registration, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'ปีจดทะเบียน      :    ${ widget.data['foundCar'][0]['car_registration_year']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.chair_alt_outlined, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'จำนวนที่นั่ง        :    ${ widget.data['foundCar'][0]['car_nunber_sit']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.shopping_bag_outlined, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'กระเป๋าใหญ่       :    ${ widget.data['foundCar'][0]['car_nunber_bigbag']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.shopping_bag_sharp, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'กระเป๋าเล็ก        :     ${ widget.data['foundCar'][0]['car_nunber_smallbag']}',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEEC9),
                                borderRadius: BorderRadius.all(Radius.circular(15)
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'อุปกรณ์ภายในรถ',
                                  style: TextStyle(
                                    color: Color(0xff1D3557),
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: widget.data['foundCar'][0]['car_service'].length,
                                      itemBuilder: (context, int index) =>
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.circle, color: const Color(0xff1D3557), size: 5),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                  child: Text(
                                                      '      ' + widget.data['foundCar'][0]['car_service'][index],
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: const Color(0xff1D3557),
                                                        fontSize: 14,
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          'ราคา',
                                          style: TextStyle(
                                            color: Color(0xff1D3557),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.attach_money, color: Color(0xffFF9A62)),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                'ราคา      :    ${ widget.data['foundCar'][0]['car_price']}  ต่อวัน (24 ชั่วโมง)',
                                                style: const TextStyle(
                                                  color: Color(0xff1D3557),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),

                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Flexible(
                                  child: const Text(
                                    'เลือกจุดรับรถ - คืนรถ (จุดเดียวกัน)',
                                    style: TextStyle(
                                      color: Color(0xff1D3557),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Container(
                              width: 362,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border:  Border.all(color:const Color(0xFFB0BEC5),width: 1),
                              ),
                              child:  DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.airport_shuttle,color: Colors.black,),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                ),
                                hint: const Text(' เลือกจุดรับรถ - คืนรถ',style: TextStyle(color: Colors.black),),
                                value: value_of_pickuppoint,
                                iconSize: 16,
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                                isExpanded: true,
                                items: widget.data['foundCar'][0]['car_locationpickup'].map<DropdownMenuItem<String>>((value) =>
                                new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                )
                                ).toList(),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณาระบุจังหวัด';
                                  }
                                  return null;
                                },
                                onChanged: (String newValue) {
                                  setState(() {
                                    _price(newValue);
                                    // valuetype = newValue;
                                    // typeshuttle = valuetype;
                                    // _price(_yourlocationcontroller.text);
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),

                          const Divider(
                            thickness: 1.5,
                            color: Color(0xff827E7E),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Flexible(
                                  child: Text(
                                    'ราคา',
                                    style: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                  // Text('THB ${room_detail['price']}',
                                        ValueListenableBuilder(
                                          valueListenable: price,
                                          builder: (BuildContext context,String newValue,Widget child) {
                                            return Text(
                                              newValue + '   THB',
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            );
                                          },
                                        ),

                                      ]
                                  ),
                                )
                              ]
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              onPressed: () => {

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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
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
    count: widget.data['foundCar'][0]['car_image'].length,
    effect: ScaleEffect(
        dotWidth: 8,
        dotHeight: 8,
        activeDotColor: const Color(0xffECFAFF),
        dotColor: const Color(0xffECFAFF).withOpacity(0.5)
    ),
  );
}


