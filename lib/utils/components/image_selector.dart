// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:html' as html;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

Future<html.File> getImage() async {
  html.File? _image = await ImagePickerWeb.getImageAsFile();
  print(_image!.relativePath);
  return _image;
}

void showFlushBar(
    {String? title,
    required BuildContext context,
    bool alertStyle = false,
    String message = 'Please wait of sometime or Try again '}) {
  Flushbar(
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.all(15.0),
    borderRadius: BorderRadius.circular(8.0),
    backgroundGradient: LinearGradient(
      colors: alertStyle
          ? [
              const Color.fromARGB(255, 229, 57, 53),
              const Color.fromARGB(255, 255, 23, 68)
            ]
          : [
              const Color.fromARGB(255, 67, 160, 71),
              const Color.fromARGB(255, 0, 230, 118)
            ],
      stops: const [0.4, 1],
    ),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 4,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: message,
    duration: Duration(seconds: 5),
  ).show(context);
}
