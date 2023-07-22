import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vpma_nagpur/screens/login/mobile_login.dart';
import 'package:vpma_nagpur/utils/constants.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  bool isNotAdmin;
  LoginPage({Key? key, this.isNotAdmin = false}) : super(key: key) {
    if (isNotAdmin) {
      Constants.isAdmin = false;
    }
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ScreenTypeLayout.builder(
        // desktop: (BuildContext context) => ,
        // tablet: ,
        mobile: (BuildContext context) =>
            MobileLogin(isAdmin: Constants.isAdmin),
      )),
    );
  }
}
