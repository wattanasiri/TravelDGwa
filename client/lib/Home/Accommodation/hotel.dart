import 'package:flutter/material.dart';
import 'package:se_app2/Home/Accommodation/hotel_info.dart';
import 'package:http/http.dart' as http;

class hotel extends StatefulWidget {
  const hotel({Key key}) : super(key: key);

  @override
  _hotelState createState() => _hotelState();
}

class _hotelState extends State<hotel> {
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var res = await http.post(Uri.parse("http://10.0.2.2:8080/signup"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "email": info.email,
          "password": info.password
        });
    print(res.body);
  }

  Hotel_info info = Hotel_info('', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('เลือกสถานที่'),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController(text: info.email),
                    onChanged: (value) {
                      info.email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter something';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController(text: info.password),
                    onChanged: (value) {
                      info.password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter something';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              save();
            } else {
              print('not ok');
            }
          },
          tooltip: 'Refresh list',
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
        ),
      ]),
    );
  }
}
