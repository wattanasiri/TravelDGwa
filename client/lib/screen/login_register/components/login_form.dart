import 'package:flutter/material.dart';
import 'package:se_app2/Data/data_currentuser.dart';
import 'package:se_app2/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se_app2/navigator/nav.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>  {
  GlobalKey<FormState> _formKey = GlobalKey();

  var _loginFailed = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      var res = await http.post(Uri.parse('http://10.0.2.2:8080/signin'),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            "email": emailController.text,
            "password": passwordController.text,
          });
      await sharedPref.setString('token', res.body);
      print(sharedPref.getString('token'));
      print(res.body);
      String currentid = res.body;
      Datauser datauser = Datauser();
      datauser.id = currentid;
      print('id');
      print(datauser.id);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('success');
        // _getProfile(body);
        Navigator.pushNamed(
          context, '/Navi',
        );
      }
      else {
        setState((){
          _loginFailed = true;
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
                child: Center(
                  child: Text("ลงชื่อเข้าใช้งาน",
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
                decoration: InputDecoration(
                    labelText: 'อีเมลหรือหมายเลขโทรศัพท์',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                    ),
                    errorText: _loginFailed ? 'อีเมลหรือรหัสผ่านไม่ถูกต้อง' : null,
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
              SizedBox(height: size.height * 0.01,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'รหัสผ่าน',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่รหัสผ่าน';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: size.height * 0.006,),
              Container(
                child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/password',);
                },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("ลืมรหัสผ่าน ?",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.07,),
               GestureDetector(
                 onTap: () {
                   if (_formKey.currentState.validate()) {
                     save();
                   }
                 },
                 child: Container(
                   padding: EdgeInsets.only(
                     left: 10,
                     right: 10,
                   ),
                   height: 50.0,
                   child: Material(
                     borderRadius: BorderRadius.circular(30.0),
                     color: primaryColor,

                     child: Center(
                       child: Text(
                         'เข้าสู่ระบบ',
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
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("หรือเข้าใช้งานด้วย",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print('google');
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/icons/google-icon.png',
                            width: 30.0, height: 30.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        print('facebook');
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/icons/facebook-icon.png',
                            width: 30.0, height: 30.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: grayColor, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(text: 'หรือ '),
                    TextSpan(
                        text: 'ลงทะเบียน ',
                        style:  TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, '/register',);
                          }),
                    TextSpan(text: 'เข้าใช้งานด้วยอีเมลและหมายเลขโทรศัพท์'),
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

