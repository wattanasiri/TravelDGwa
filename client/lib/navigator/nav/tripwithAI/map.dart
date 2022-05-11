
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Data/data_selectlocation.dart';

class MapSample extends StatefulWidget {
  List<dynamic> data;
  MapSample({this.data});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _initMarkers();
    print('selectdata');
    print(widget.data);
    print(widget.data.length);
  }
  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: const Text('แผนที่ทริป'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }


  Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          IconButton(
              icon: Icon(FontAwesomeIcons.searchMinus,color:Colors.black26),
              onPressed: () {
                zoomVal--;
                _minus( zoomVal);
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.mapLocation,color:Colors.black26),
              onPressed: () {
                _resetLocation();
              }),
        ],
      )

    );
  }
  Widget _zoomplusfunction() {

    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus,color:Colors.black26),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(widget.data[0]['lat'],  widget.data[0]['lng']), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(widget.data[0]['lat'],  widget.data[0]['lng']), zoom: zoomVal)));
  }
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.data== null ? 0 : widget
              .data.length,
            itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  widget.data[index]['image'],
                  widget.data[index]['lat'],
                  widget.data[index]['lng'],
                  widget.data[index]['name'],
                  widget.data[index]['star'],
                  widget.data[index]['openday'],
                  widget.data[index]['timeopen-close']),
            );
            }
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String Name,int star,String openday,String opentime) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(Name,openday,opentime,star),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String Name,String openday, String opentime,int star) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(Name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      ' (' + star.toString() + ') ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                _buildRatingStars(star),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "วันที่เปิด " + openday,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "เวลาเปิด-ปิด "+ opentime,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng( widget.data[0]['lat'],  widget.data[0]['lng']), zoom: 13),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // markers: {
        //   newyork1Marker,newyork2Marker,newyork3Marker,gramercyMarker,bernardinMarker,blueMarker
        // },
        markers: _marker.toSet(),
      ),
    );
  }

  List<Marker> _marker = [];

  void _initMarkers() {
    if (widget.data != null) {
      _marker.clear();
      for (int i = 0; i < widget.data.length; i++) {
        if (widget.data[i]['lat']!= null && widget.data[i]['lng']!= null) {
          if(i==0)
            _marker.add(
              new Marker(
                markerId: MarkerId(widget.data[i]['name']),
                position: LatLng(widget.data[i]['lat'], widget.data[i]['lng']),
                infoWindow: InfoWindow(title: widget.data[i]['name']),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            );
          if(i != 0 && i != widget.data.length)
          _marker.add(
            new Marker(
              markerId: MarkerId(widget.data[i]['name']),
              position: LatLng(widget.data[i]['lat'], widget.data[i]['lng']),
              infoWindow: InfoWindow(title: widget.data[i]['name']),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            ),
          );
          if(i == widget.data.length-1)
            _marker.add(
              new Marker(
                markerId: MarkerId(widget.data[i]['name']),
                position: LatLng(widget.data[i]['lat'], widget.data[i]['lng']),
                infoWindow: InfoWindow(title: widget.data[i]['name']),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                ),
              ),
            );

  }
  }
  }
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }

  Future<void> _resetLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(widget.data[0]['lat'],  widget.data[0]['lng']), zoom: 13),
     ));
  }
}
//
// Marker gramercyMarker = Marker(
//   markerId: MarkerId('สวนน้ำรามายณะ'),
//   position: LatLng(12.7499141, 100.9618801),
//   infoWindow: InfoWindow(title: 'สวนน้ำรามายณะ'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueRed,
//   ),
// );
//
// Marker bernardinMarker = Marker(
//   markerId: MarkerId('Coffee Philosophy @ Silver Lake'),
//   position: LatLng(12.7605304, 100.9642901),
//   infoWindow: InfoWindow(title: 'Coffee Philosophy @ Silver Lake'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker blueMarker = Marker(
//   markerId: MarkerId('ไร่แสงจรรย์ แคมป์ & คาเฟ่'),
//   position: LatLng(12.7771679, 100.9549920),
//   infoWindow: InfoWindow(title: 'ไร่แสงจรรย์ แคมป์ & คาเฟ่'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
//
// //New York Marker
//
// Marker newyork1Marker = Marker(
//   markerId: MarkerId("ปางช้างเขาชีจรรย์"),
//   position: LatLng(12.7832140, 100.9525809),
//   infoWindow: InfoWindow(title: 'ปางช้างเขาชีจรรย์'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker newyork2Marker = Marker(
//   markerId: MarkerId('วิหารเซียน'),
//   position: LatLng(12.7882354, 100.9550759),
//   infoWindow: InfoWindow(title: 'วิหารเซียน'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet,
//   ),
// );
// Marker newyork3Marker = Marker(
//   markerId: MarkerId('Mushroom cafe pattaya'),
//   position: LatLng(12.7896552, 100.9492414),
//   infoWindow: InfoWindow(title: 'Mushroom cafe pattaya'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueBlue,
//   ),
// );