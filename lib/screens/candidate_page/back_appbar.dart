// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpma_nagpur/main.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/profile_page.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

bool? loggedIn;
bool? activeStatus;
bool? blacklisted;
String? uID;
String? email;
String? password;
String? contact;
String? gst;
String? name;
String? type;
String? date;
String? add;
String? sname;
String? image;
Future<bool> getCache() async {
  SharedPreferences _cache = await SharedPreferences.getInstance();

  loggedIn = _cache.getBool('isLoggedIn');
  activeStatus = _cache.getBool('activeStatus');
  blacklisted = _cache.getBool('blacklisted');
  uID = _cache.getString('userID');
  email = _cache.getString('userEmail');
  password = _cache.getString('userPassword');
  contact = _cache.getString('userCOntact');
  gst = _cache.getString('userGstNo');
  name = _cache.getString('userName');
  type = _cache.getString('userType');
  date = _cache.getString('userRenewalDate');
  add = _cache.getString('userShopAddress');
  sname = _cache.getString('userShopName');
  image = _cache.getString('userImage');
  print(uID);

  return true;
}

PreferredSize backAppBar(context) {
  getCache();
  return PreferredSize(
    preferredSize: const Size.fromHeight(151),
    child: Container(
      child: Container(
        color: kPrimaryColor,
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/vpma_logo.png',
                        fit: BoxFit.fitWidth,
                        width: 45,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Vidarbha Playwood\nMerchent\'s Association  ',
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: kAppTitleStyle,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                child: getUserProfileIcon(),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              )
            ],
          ),
        )),
      ),
    ),
  );
}

Widget getUserProfileIcon() {
  getCache();
  // if (imageGlobal.toString() == 'null') {
  return const CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 20.0,
    child: Icon(
      Icons.account_circle,
      color: Colors.white,
      size: 38.0,
    ),
  );
  // } else {
  //   return CircleAvatar(
  //     backgroundColor: Colors.transparent,
  //     backgroundImage: NetworkImage(imageGlobal!),
  //   );
  // }
}
