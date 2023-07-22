import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF2F140B);
const Color kSecondaryColor =
    Color(0x822F140B); //Color(0xE2ec9454); //Color(0x92ffaf4f);
const Color kThirdColor = Color(0xFFfff8d2);
const Color kPrimaryFontColor = Color(0xFF373435);
const Color kSecondaryFontColor = Color(0xE5ED3237);

const kPageTitleStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Ubuntu',
);

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'ProductSans',
  fontWeight: FontWeight.bold,
);

const kTableHead = TextStyle(
  fontFamily: 'ProductSans',
  fontWeight: FontWeight.bold,
  fontSize: 17.0,
);

const kViewMsg = TextStyle(
  fontSize: 12,
);

const kUnviewMsg = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

const kSelectedTextStyle =
    TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold);

const kUnselectedTextStyle = TextStyle(fontSize: 16.0, color: Colors.white60);

const kAppTitleStyle = TextStyle(
  color: kSecondaryFontColor,
  fontFamily: 'Ubuntu',
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(0, 3),
      blurRadius: 4.0,
      color: Color.fromARGB(90, 0, 0, 0),
    ),
  ],
);

const kBottomTextStyle = TextStyle(
  fontFamily: 'ProductSans',
  color: Colors.white,
  fontSize: 16.0,
);
