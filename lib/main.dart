import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpma_nagpur/screens/login/login_page.dart';
import 'package:vpma_nagpur/utils/constants.dart';

bool? loggedInGlobal;
bool? activeStatusGlobal;
bool? blacklistedGlobal;
String? uIDGlobal;
String? emailGlobal;
String? passwordGlobal;
String? contactGlobal;
String? gstGlobal;
String? nameGlobal;
String? typeGlobal;
String? dateGlobal;
String? addGlobal;
String? snameGlobal;
String? imageGlobal;
Future<bool> getCache() async {
  SharedPreferences _cache = await SharedPreferences.getInstance();

  loggedInGlobal = _cache.getBool('isLoggedIn');
  activeStatusGlobal = _cache.getBool('activeStatus');
  blacklistedGlobal = _cache.getBool('blacklisted');
  uIDGlobal = _cache.getString('userID');
  emailGlobal = _cache.getString('userEmail');
  passwordGlobal = _cache.getString('userPassword');
  contactGlobal = _cache.getString('userCOntact');
  gstGlobal = _cache.getString('userGstNo');
  nameGlobal = _cache.getString('userName');
  typeGlobal = _cache.getString('userType');
  dateGlobal = _cache.getString('userRenewalDate');
  addGlobal = _cache.getString('userShopAddress');
  snameGlobal = _cache.getString('userShopName');
  imageGlobal = _cache.getString('userImage');
  print(uIDGlobal);

  return true;
}

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getCache();
    return MaterialApp(
      title: 'Vidarbha Plywood Merchant\'s Association',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'ProductSans',
            color: kPrimaryFontColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'ProductSans',
            color: kPrimaryFontColor,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(
        isNotAdmin: true,
      ),
    );
  }
}
