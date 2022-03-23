
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se_app2/Data/data_selectlocation.dart';
import 'package:se_app2/Home/Map/map.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../Data/data_currentuser.dart';
import '../../Data/data_locations.dart';

class Mapmain extends StatefulWidget {

  @override
  State<Mapmain> createState() => _MapmainState();
}

class _MapmainState extends State<Mapmain> {
  List<dynamic> selectlocation;
  Map<String,dynamic> datalocation;

  Future model() async{
    final rawCsvContent = await rootBundle.loadString("assets/dataset/diabetes.csv");
    // print(rawCsvContent);
    final samples = DataFrame.fromRawCsv(rawCsvContent);
    print('samples');
    print(samples);
    final targetColumnName = 'Group';
    final splits = splitData(samples, [0.7]);
    print('spilts');
    print(splits);
    final validationData = splits[0];
    final testData = splits[1];
    print('validation');
    print(validationData);
    print('testdata');
    print(testData);
    final validator = CrossValidator.kFold(validationData, numberOfFolds: 5);
    final createClassifier = (DataFrame samples) =>
        KnnClassifier(
          samples,
          targetColumnName,
          2,
        );
    final scores = await validator.evaluate(createClassifier, MetricType.accuracy);
    final accuracy = scores.mean();
    print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');
    final testSplits = splitData(testData, [0.8]);
    final classifier = createClassifier(testSplits[0]);
    final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);
    print('accuracy on k fold validation: ${finalScore.toStringAsFixed(2)}');
    // print(classifier.costPerIteration);
    print(classifier);
    final unlabelledData = DataFrame(<Iterable<num>>[
      [10000,10000,10000,10000,10000,10000,10000,10000],
      [0,0,0,0,0,0,0,0],

    ], headerExists: false);
    final prediction = classifier.predict(unlabelledData);
    print(prediction);
    print(prediction.header);
    print(prediction.rows);
  }

  Future savedata() async {
    Datauser datauser = Datauser();
    print('id');
    print(datauser.id);
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/map/register_mapinfo'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "usernameID" : datauser.id,
          "display_name": 'นายสมปอง ดองงาน',
          "car_brand": 'ฮอนด้า',
          "car_registration": 'ฟฟ6207',
          "phone": '097-3182012',
          "email": 'franky123@gmail.com',
        });
  }
  Future _submit(){
    Datalocation data = Datalocation();
    Dataselectlocation selectdata = Dataselectlocation();
    model();
    savedata();
    // print(data.location);
    // print(data.location[0]);
    // print(data.location[0]['name']);
    // selectlocation.addAll(data.location[0]);
    selectlocation = selectdata.selectlocation;
    print(selectlocation);
    // print('selectlocation 0');
    // print(selectlocation[5]);
    selectlocation.add(
      data.location[0]
    );
    selectlocation.add(
        data.location[1]
    );
    selectlocation.add(
        data.location[2]
    );
    selectlocation.add(
        data.location[3]
    );
    selectlocation.add(
        data.location[4]
    );
    selectlocation.add(
        data.location[5]
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample(
      data: selectlocation,
    ),

    ));
  }
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
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
