import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:http/http.dart' as http;

class PasswordRecoveryForm extends StatefulWidget {
  const PasswordRecoveryForm({Key key}) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordRecoveryForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var _findFailed = false;
  var _findSuccess = false;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future save() async {
      var res = await http.post(Uri.parse('http://10.0.2.2:8080/passwordrecover'),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            "email": emailController.text,
          });
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('success');
        setState((){
          _findSuccess = true;
          _findFailed = false;
        });
      }
      else {
        setState((){
          _findSuccess = false;
          _findFailed = true;
        });
        print('failure');
      }
    }

    return Form(
        key: _formKey,
        child: Stack(
        children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: paddingValue,
            right: paddingValue,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Stack(
                  children: [
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                      ),
                      alignment: Alignment.topLeft,

                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("ลืมรหัสผ่าน",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                ),

              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'กรุณากรอกอีเมลหรือหมายเลขโทรศัพท์',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                    ),
                    errorText: _findFailed ? 'ไม่พบอีเมลหรือหมายเลขโทรศัพท์บนระบบ' : null,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่อีเมลหรือเบอร์โทรศัพท์ของคุณ';
                  }
                  return null;
                },
                controller: emailController,
              ),
              SizedBox(height: size.height * 0.03,),

              _findSuccess ?
                Text(
                'ส่งข้อความเข้าไปในอีเมลหรือโทรศัพท์ของคุณแล้ว',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: primaryColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                ) : Container(),

              SizedBox(height: size.height * 0.03,),
              Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  height: 50.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                    color: primaryColor,
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          save();
                        }
                      },
                      child: Center(
                        child: Text(
                          'ดำเนินการต่อ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ],


    ),
    );
  }
}

