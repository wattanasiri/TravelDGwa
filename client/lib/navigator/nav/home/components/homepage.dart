import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:se_app2/Home/Accommodation/accommodation.dart';
import 'package:se_app2/Home/Activity/activity.dart';
import 'package:se_app2/Home/Airport_Transfer/Airport_Transfer_driver_input.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_detail_car.dart';
import 'package:se_app2/Home/Rentcar/Rentcar_main.dart';
import 'package:se_app2/constants.dart';
import 'home_button.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/homebg.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png',
                        width: 80.0, height: size.height * 0.08,),
                  ),
                SizedBox(width: 1),
                Text("TravelDGwa",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(-2.0, 2.0),
                          color: primaryColor,
                        ),
                        Shadow(
                          offset: Offset(-4.0, 4.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HomeButton(icon: 'assets/icons/01.png', text: 'ค้นหาที่พัก', route: AccommodationPage()),
                SizedBox(width: 40),
                HomeButton(icon: 'assets/icons/02.png', text: 'เที่ยวบิน', route: '/findhotel'),
              ],
            ),
            SizedBox(height: size.height * 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HomeButton(icon: 'assets/icons/03.png', text: 'บริการรับ-ส่ง', route: ShuttlePage()),
                SizedBox(width: 30),
                HomeButton(icon: 'assets/icons/04.png', text: 'เช่ารถ', route: rentcar()),
                SizedBox(width: 30),
                HomeButton(icon: 'assets/icons/05.png', text: 'แผนที่', route: '/findhotel'),
              ],
            ),
            SizedBox(height: size.height * 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HomeButton(icon: 'assets/icons/06.png', text: 'กิจกรรม', route: activity()),
                SizedBox(width: 30),
                HomeButton(icon: 'assets/icons/07.png', text: 'สถานที่ท่องเที่ยว', route: '/findhotel'),
                SizedBox(width: 30),
                HomeButton(icon: 'assets/icons/08.png', text: 'ร้านอาหาร', route: '/findhotel'),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: paddingValue / 2,
                right: paddingValue / 2,
              ),

              child: Row(
                children: [
                  Image.asset('assets/icons/promotion.png',
                      width: 20.0, height: 20.0, fit:BoxFit.fill),
                  SizedBox(width: 10),
                  Text("Promotion",
                    style: TextStyle(
                      color: grayColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            SizedBox(height: 5),

            CarouselSlider(
              options: CarouselOptions(
                height: size.height * 0.16,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child: Text('image no. $i', style: TextStyle(fontSize: 24.0),)
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: paddingValue / 2,
                right: paddingValue / 2,
              ),

              child: Row(
                children: [
                  Image.asset('assets/icons/compass.png',
                      width: 20.0, height: 20.0, fit:BoxFit.fill),
                  SizedBox(width: 10),
                  Text("Recommended",
                    style: TextStyle(
                      color: grayColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            CarouselSlider(
              options: CarouselOptions(
                height: size.height * 0.12,
                viewportFraction: 0.35,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(8),),
                        ),
                        child: Text('image no. $i', style: TextStyle(fontSize: 24.0),)
                    );
                  },
                );
              }).toList(),
            ),

          ],
        ),
      ],


    );
  }
}

