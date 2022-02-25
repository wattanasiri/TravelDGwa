import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_deatil_partner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Rentcar_result_reserve.dart';

class cardetail extends StatefulWidget {
  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data,partnerdata;
  var destination = new List();


  cardetail({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data,this.partnerdata,this.destination});
  @override
  _cardetailState createState() => _cardetailState();
}

class _cardetailState extends State<cardetail> {

  @override
  void initState() {
    super.initState();
    print('data destination');
    print(widget.destination);
    print(widget.dategetcar);
    print(widget.timegetcar);
    print(widget.datesentcar);
    print(widget.timesentcar);
  }

  ValueNotifier<String> price = ValueNotifier('--');
  final GlobalKey<FormState> _formKey = GlobalKey();
  String value_of_pickuppoint;
  String value_price,value_destination,value_namedestination;
  int activeIndex = 0;
  bool checkprice = false;
  var k =0;
  var result_date_time,result_price_extra;
  var date_time_getcar,date_time_sentcar;
  var result_price_extra_;
  bool checkpriceextra = false;
  
  Future _price(String location) async{
    checkpriceextra = false;
    print('price');
    print(location);
    print('date');
    date_time_getcar = widget.dategetcar+ ' ' +  widget.timegetcar;
    date_time_sentcar = widget.datesentcar + ' ' + widget.timesentcar;
    print(date_time_getcar);
    print(date_time_sentcar);
    DateTime dt1 = DateTime.parse(date_time_sentcar);
    DateTime dt2 = DateTime.parse(date_time_getcar);
    Duration diff = dt1.difference(dt2);
    print('dif time');
    print(diff.inMinutes);
    print(diff.inMinutes%1440);
    print(diff.inMinutes~/1440);
    if(diff.inMinutes~/1440 == 0) {
      print('result :  1');
      result_date_time = 1;
      result_price_extra = 0;

    }
    if(diff.inMinutes > 1440){
      checkpriceextra = true;
    }
    if(diff.inMinutes~/1440 > 0){
      print('result :  ${diff.inMinutes~/1440}');
      print('result :  ${diff.inMinutes%1440}');
      result_date_time = diff.inMinutes~/1440;
      result_price_extra = diff.inMinutes%1440;
    }
    for(int i =0;i<widget.data['foundCar']['car_locationpickup'].length;i++){
      int endstring = location.length - 14;
      print(widget.data['foundCar']['car_locationpickup'][i]);
      if(widget.data['foundCar']['car_locationpickup'][i].contains(location.substring(0,endstring))){
        k = i;
      }
    }
    result_price_extra_ = result_price_extra*widget.data['foundCar']['car_price_minute'];
    price.value = ((widget.data['foundCar']['car_pricelocationpickup'][k]+widget.data['foundCar']['car_price']*result_date_time )+ result_price_extra_).toString();
    value_price = ((widget.data['foundCar']['car_pricelocationpickup'][k]+widget.data['foundCar']['car_price']*result_date_time) + result_price_extra_).toString();
    value_destination = widget.data['foundCar']['car_pricelocationpickup'][k].toString();
    value_namedestination = widget.data['foundCar']['car_locationpickup'][k];
    checkprice = true;
  }


  Future next() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
    result_reserve(
        dategetcar: widget.dategetcar,
        timegetcar: widget.timegetcar,
        datesentcar: widget.datesentcar,
        timesentcar: widget.timesentcar,
        yourlocation: widget.yourlocation,
        // destination: value_destination,
        price: value_price,
        data: widget.data,
        partnerdata: widget.partnerdata,
        pricedestination : value_destination,
        namedestination : value_namedestination,
        result_price_extra: result_price_extra,
        result_price_extra_: result_price_extra_,
        result_date_time : result_date_time,
        checkpriceextra: checkpriceextra,

    ),));

  }


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
                  SizedBox(height: MediaQuery.of(context).size.height),
                  CarouselSlider.builder(
                    itemCount: widget.data['foundCar']['car_image'].length,
                    options: CarouselOptions(
                        height: 400.0,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) =>
                        {setState(() => activeIndex = index)}),
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = widget.data['foundCar']['car_image'][index];
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
                              widget.data['foundCar']['car_name'],
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
                                                CircleAvatar(radius: (20),
                                                    backgroundColor: Colors.white,
                                                    child: ClipRRect(
                                                      borderRadius:BorderRadius.circular(50),
                                                      child: Image.network(
                                                        widget.partnerdata['foundpartner']['image'][0],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
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
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                    detailpartner(
                                      dategetcar: widget.dategetcar,
                                      timegetcar: widget.timegetcar,
                                      datesentcar: widget.datesentcar,
                                      timesentcar: widget.timesentcar,
                                      yourlocation: widget.yourlocation,
                                      data: widget.data,
                                      partnerdata: widget.partnerdata,
                                      destination: widget.destination,
                                    ),));
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
                                                  'ปีจดทะเบียน      :    ${ widget.data['foundCar']['car_registration_year']}',
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
                                                  'จำนวนที่นั่ง        :    ${ widget.data['foundCar']['car_nunber_sit']}',
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
                                                  'กระเป๋าใหญ่       :    ${ widget.data['foundCar']['car_nunber_bigbag']}',
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
                                                  'กระเป๋าเล็ก        :     ${ widget.data['foundCar']['car_nunber_smallbag']}',
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
                                        itemCount: widget.data['foundCar']['car_service'].length,
                                        itemBuilder: (context, int index) =>
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.circle, color: const Color(0xff1D3557), size: 5),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                    child: Text(
                                                        '      ' + widget.data['foundCar']['car_service'][index],
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
                                            child:
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(Icons.attach_money, color: Color(0xffFF9A62)),
                                                    const SizedBox(width: 15),
                                                    Flexible(
                                                      child: Text(
                                                        'ราคา      :    ${ widget.data['foundCar']['car_price']}  ต่อวัน (24 ชั่วโมง)',
                                                        style: const TextStyle(
                                                          color: Color(0xff1D3557),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[

                                                    const SizedBox(width: 5),
                                                    Flexible(
                                                      child: Text(
                                                        'ราคาเกินกำหนดการส่งคืนรถ  :    ${ widget.data['foundCar']['car_price_minute']*60}  ต่อชั่วโมง',
                                                        style: const TextStyle(
                                                          color: Color(0xff1D3557),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],

                                            )


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
                                  items: (widget.destination).map<DropdownMenuItem<String>>((value) =>
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
                            if(checkprice == true)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'ราคาต่อวัน',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            if(checkprice == true)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '(${widget.dategetcar}-${widget.datesentcar})',
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            // Text('THB ${room_detail['price']}',
                                            Text(
                                              '(${result_date_time.toString()} วัน) ${widget.data['foundCar']['car_price']*result_date_time} THB',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ]
                                      ),
                                    )
                                  ]
                              ),
                            if(checkprice == true)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'ราคาเพิ่มเติม',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                  ]
                              ),
                            if(checkpriceextra == true)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '(${widget.timegetcar}-${widget.timesentcar})',
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            // Text('THB ${room_detail['price']}',
                                            Text(
                                              '(${result_price_extra.toString()} นาที) ${result_price_extra_}  THB',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ]
                                      ),
                                    )
                                  ]
                              ),
                            if(checkprice == true)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${value_namedestination}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            // Text('THB ${room_detail['price']}',
                                            Text(
                                              ' ${value_destination}   THB',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
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
                                  next(),

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
    ));
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
    count: widget.data['foundCar']['car_image'].length,
    effect: ScaleEffect(
        dotWidth: 8,
        dotHeight: 8,
        activeDotColor: const Color(0xffECFAFF),
        dotColor: const Color(0xffECFAFF).withOpacity(0.5)
    ),
  );
}


