import 'package:flutter/material.dart';
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:se_app2/Widgets/notif_ok.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var _registerFailed = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController realnameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  SharedPreferences sharedPref;

  _initSharedPreferences() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future save() async {
      var res = await http.post(Uri.parse('http://10.0.2.2:8080/signup'),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            "email": emailController.text,
            "phone": phoneController.text,
            "realname": realnameController.text,
            "surname": surnameController.text,
            "password": passwordController.text,
          }).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return notifBox(
                title: 'Error',
                text: 'Request timeout.',
                fontSize: 14.0,
              );
            },
          );
          return http.Response('Error', 408);
        },)
      ;

      if (res.statusCode == 200) {
        print('success');
        await sharedPref.setString('token', res.body);
        Navigator.pushReplacementNamed(
            context, '/Navi',
        );
      }
      else if (res.statusCode != 408) {
        setState((){
          _registerFailed = true;
        });
        print('failure');
      }
    }
    return Form(
      key: _formKey,
      child: Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: paddingValue,
            right: paddingValue,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: const Center(
                  child: Text("?????????????????????????????????????????????????????????",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                key: Key(emailController.toString()), // <- Magic!
                decoration: InputDecoration(
                    labelText: '???????????????',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                    ),
                    errorText: _registerFailed ? '????????????????????????????????????????????????????????????' : null,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '?????????????????????????????????????????????????????????';
                  } else {
                    bool emailValidation = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if (!emailValidation) {
                      return '??????????????????????????????????????????????????????????????????';
                    }
                  }
                  return null;
                },
                controller: emailController,
              ),
              SizedBox(height: size.height * 0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                        decoration: InputDecoration(
                          labelText: '????????????',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '??????????????????????????????????????????????????????';
                        }
                        return null;
                      },
                      controller: realnameController,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02,),
                  new Flexible(
                    child: new TextFormField(
                        decoration: InputDecoration(
                          labelText: '?????????????????????',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '???????????????????????????????????????????????????????????????';
                        }
                        return null;
                      },
                      controller: surnameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '?????????????????????????????????????????????',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????????????????????????????????????????????????????????????????????????????????';
                  }
                  return null;
                },
                controller: phoneController,
              ),
              SizedBox(height: size.height * 0.01,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '????????????????????????',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return '?????????????????????????????????????????????????????????????????? 6 ???????????????????????????';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: size.height * 0.02,),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    save();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: primaryColor,
                      child: const Center(
                        child: Text(
                          '?????????????????????????????????',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                ),
              ),

              SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: grayColor, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(text: '????????????????????? TravelDKwa ???????????????????????? ? '),
                    TextSpan(
                        text: '????????????????????????????????? ',
                        style:  TextStyle(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, '/login',);
                          }),
                  ],
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

