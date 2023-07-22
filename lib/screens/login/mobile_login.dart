import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MobileLogin extends StatefulWidget {
  bool isAdmin;
  MobileLogin({super.key, required this.isAdmin});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
