

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Rentcar_detail_car.dart';
class Rentcar_info extends StatefulWidget {

  String dategetcar, timegetcar,datesentcar,yourlocation,timesentcar;
  Map data;

  Rentcar_info({this.dategetcar,this.timegetcar,this.datesentcar,this.timesentcar,this.yourlocation,this.data});
  @override
  _Rentcar_infoState createState() => _Rentcar_infoState();
}

class _Rentcar_infoState extends State<Rentcar_info> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String id;
  Map data;
  Map partnerdata;
  String partnerid;


  Future getdetailpartnercar() async {
    print('getdetailpartnercar');
    http.Response res =
    await http.get(Uri.parse(
        "http://10.0.2.2:8080/rentcar/" + partnerid + '/infopartner'));
    partnerdata = json.decode(res.body);
    print(data);
    print(data['foundCar']);
    print(data['foundCar']['car_name']);
    var destination = new List(data['foundCar']['car_locationpickup'].length);
    for(int i=0;i<data['foundCar']['car_locationpickup'].length;i++){

      destination[i] = data['foundCar']['car_locationpickup'][i].toString() + ' ( + THB ' +data['foundCar']['car_pricelocationpickup'][i].toString() + ' )';
      print(destination[i]);
    }
    print(destination);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        cardetail(
          dategetcar: widget.dategetcar,
          timegetcar: widget.timegetcar,
          datesentcar: widget.datesentcar,
          timesentcar: widget.timesentcar,
          yourlocation: widget.yourlocation,
          destination: destination,
          data: data,
          partnerdata: partnerdata,
        ),));
  }

  Future getdetailcar() async {
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
    print('getdetailcar');
    id = '62134d4c6201bfd27183856a';
    http.Response res =
    await http.get(
        Uri.parse("http://10.0.2.2:8080/rentcar/" + id + '/infocar'));
    data = json.decode(res.body);
    partnerid = data['foundCar']['PartnerID'];
  }

  @override
  void initState() {
    super.initState();
    print('data');
    print(widget.data);
    print(widget.data['foundCar'].length);
    print(widget.data['foundCar'][0]);
    print(widget.data['foundCar'][0]['car_price']);
    print(widget.data['foundCar'][0]['car_name']);
    print(widget.data['foundCar'][0]['car_image'][0]);
    print(widget.data['foundCar'][0]['car_image'].length);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF4DC),
        toolbarHeight: 70,
        elevation: 0.0,
        title: Text('${widget.yourlocation}'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1d3557),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RaisedButton(
                          onPressed: () async =>
                          {
                            // await querycar(),

                            await getdetailcar(),
                            await getdetailpartnercar(),


                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Stupid Buttom',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffFFF4DC)
                              ),
                            ),
                          ),
                          color: Color(0xff1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // <-- Radius
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
