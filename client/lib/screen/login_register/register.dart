import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';
import 'package:se_app2/screen/login_register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(),

    );
  }
}