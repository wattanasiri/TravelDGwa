import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/screen/login_register/components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),

    );
  }
}