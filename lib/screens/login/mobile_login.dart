// ignore_for_file: avoid_single_cascade_in_expression_statements, must_be_immutable, dead_code, use_build_context_synchronously, unused_field

import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/candidate_page.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class MobileLogin extends StatefulWidget {
  bool? isAdmin;
  MobileLogin({super.key, this.isAdmin});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  // final _auth = FirebaseAuth.instance;
  final Constants _const = Constants.getReferenceObject;
  late Widget screenLayer;
  bool checking = true;

  _MobileLoginState() {
    screenLayer = const SplashLoader();
  }
  @override
  Widget build(BuildContext context) {
    checkCacheLogin().then((value) async {
      if (!value) {
        await Future.delayed(const Duration(seconds: 2));
        try {
          setState(() {
            screenLayer = LoginScreen(
              isAdmin: widget.isAdmin,
            );
          });
        } catch (e) {
          print(e.toString());
        }
      }
    });
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: screenLayer,
    );
  }

  Future<bool> checkCacheLogin() async {
    SharedPreferences? _cache = await SharedPreferences.getInstance();
    try {
      if (_cache.getBool('isLoggedIn')!) {
        // if (_cache.getBool('activeStatus')! && _cache.getBool('blacklisted')!) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (route) => false);
        // }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      // _cache.clear();
      return false;
    }
  }
}

class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/vpma_logo.png',
                      height: (MediaQuery.of(context).size.width * 0.6),
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Vidarbha Plywood\nMerchant\'s Association  ',
                      textAlign: TextAlign.center,
                      style: kAppTitleStyle.copyWith(
                          fontSize: 32.0, fontFamily: 'ProductSans'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/yhts.png',
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                  const Text(
                    'Powered By',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Yarsh Hybrid Technology Solutions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  bool? isAdmin;
  LoginScreen({super.key, this.isAdmin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  final Constants _const = Constants.getReferenceObject;
  Widget buttonFront = const Padding(
    padding: EdgeInsets.all(12.0),
    child: Text(
      'LOGIN',
      style: TextStyle(
          color: Colors.white, fontFamily: 'ProductSans', fontSize: 16.0),
    ),
  );
  String? email, password;
  Color? btnColor;
  _LoginScreenState() {
    btnColor = const Color(0xFFed733f);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 85.0,
          ),
          Hero(
            tag: 'logo',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/vpma_logo.png',
                      height: 64,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'VPMA',
                      maxLines: 1,
                      style: kAppTitleStyle.copyWith(
                          fontSize: 70.0, fontFamily: 'ProductSans'),
                    ),
                  ],
                ),
                const Text(
                  'Vidarbha Plywood Merchant\'s Association\n',
                  textAlign: TextAlign.center,
                  style: kAppTitleStyle,
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0x92ffaf4f),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFed733f),
                          width: 2.5,
                        ),
                      ),
                    ),
                    maxLines: 1,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your email!' : null,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0x92ffaf4f),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFed733f),
                          width: 2.5,
                        ),
                      ),
                    ),
                    maxLines: 1,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your password!' : null,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(btnColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: btnColor!)))),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () async {
                          try {
                            setState(() {
                              btnColor = widget.isAdmin!
                                  ? Colors.blueGrey[200]
                                  : const Color(0x92ffaf4f);
                              buttonFront = CircularProgressIndicator(
                                valueColor: widget.isAdmin!
                                    ? AlwaysStoppedAnimation<Color>(
                                        Colors.blueGrey[900]!)
                                    : const AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                              );
                            });

                            if (email == null ||
                                password == null ||
                                email!.isEmpty ||
                                password!.isEmpty) {
                              resetButtonAppearence();
                              showFlushBar(
                                  'Blank Fields are not allowed!!!', context);
                            } else {
                              print('response getting');
                              final response = await http.get(
                                Uri.parse('${url}memberDatabse/'),
                              );
                              print(response.body);

                              var ddd = jsonDecode(response.body);

                              List<UserData> data_list = (ddd as List)
                                  .map((data) => new UserData.fromJson(data))
                                  .toList();

                              int flag = 0;
                              for (int i = 0; i < data_list.length; i++) {
                                if (data_list[i].email == email &&
                                    data_list[i].password == password) {
                                  _const.user = data_list[i];
                                  print(_const.user!.email);
                                  if (!_const.user!.blacklisted!) {
                                    if (_const.user!.activeStatus!) {
                                      storeCacheData(
                                          true,
                                          _const.user!.activeStatus!,
                                          _const.user!.blacklisted!,
                                          _const.user!.id!.toString(),
                                          _const.user!.email!,
                                          _const.user!.password!,
                                          _const.user!.contact!,
                                          _const.user!.gstNo!,
                                          _const.user!.memberName!,
                                          _const.user!.memberType!,
                                          _const.user!.renewalDate!,
                                          _const.user!.shopAddress!,
                                          _const.user!.shopName!,
                                          _const.user!.userImage!);

                                      if (_const.user!.memberType! ==
                                          'normal') {
                                        resetButtonAppearence();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MobileCandidate()),
                                            (route) => false);
                                      } else {
                                        print('object');
                                        showFlushBar(
                                            'Invalid Credentials Provided!!!',
                                            context);
                                        resetButtonAppearence();
                                      }
                                    } else {
                                      showFlushBar(
                                          'Not a Active Member ID!!!', context);
                                      resetButtonAppearence();
                                    }
                                  } else {
                                    showFlushBar(
                                        'Blacklisted Member ID!!!', context);
                                    resetButtonAppearence();
                                  }
                                  print("Valid User");
                                  flag = 1;
                                }
                              }
                              if (flag == 0) {
                                showFlushBar(
                                    'Invalid Credentials Provided!!!', context);
                                resetButtonAppearence();
                                print("InValid User");
                              }
                            }
                          } catch (e) {
                            print('error');
                            print(e);
                            if (email == null ||
                                password == null ||
                                email!.isEmpty ||
                                password!.isEmpty) {
                              resetButtonAppearence();
                              showFlushBar(
                                  'Blank Fields are not allowed!!!', context);
                            } else if (e
                                .toString()
                                .contains('auth/invalid-email')) {
                              resetButtonAppearence();
                              showFlushBar('Invalid Email Entered!!!', context);
                            } else if (e
                                .toString()
                                .contains('auth/wrong-password')) {
                              resetButtonAppearence();
                              showFlushBar(
                                  'Incorrect Password Entered!!!', context);
                            } else {
                              resetButtonAppearence();
                              showFlushBar(
                                  'Invalid Credentials Provided!!!', context);
                            }
                          }
                        },

                        child: buttonFront,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 56.0,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void resetButtonAppearence() {
    try {
      setState(() {
        btnColor =
            widget.isAdmin! ? Colors.blueGrey[900] : const Color(0xFFed733f);
        buttonFront = const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.white, fontFamily: 'ProductSans', fontSize: 16.0),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void showFlushBar(String title, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      borderRadius: BorderRadius.circular(8.0),
      backgroundGradient: LinearGradient(
        colors: [Colors.red[600]!, Colors.redAccent[400]!],
        stops: [0.4, 1],
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
      message: 'Contact System Admin or Try Again ',
      duration: const Duration(seconds: 5),
    )..show(context);
  }

  void storeCacheData(
      bool loggedIn,
      bool activeStatus,
      bool blacklisted,
      String uID,
      String email,
      String password,
      String contact,
      String gst,
      String name,
      String type,
      String date,
      String add,
      String sname,
      String image) async {
    SharedPreferences _cache = await SharedPreferences.getInstance();
    _cache.setBool('isLoggedIn', loggedIn);
    _cache.setBool('activeStatus', activeStatus);
    _cache.setBool('blacklisted', blacklisted);
    _cache.setString('userID', uID);
    _cache.setString('userEmail', email);
    _cache.setString('userPassword', password);
    _cache.setString('userCOntact', contact);
    _cache.setString('userGstNo', gst);
    _cache.setString('userName', name);
    _cache.setString('userType', type);
    _cache.setString('userRenewalDate', date);
    _cache.setString('userShopAddress', add);
    _cache.setString('userShopName', sname);
    _cache.setString('userImage', image);
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MobileCandidate())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/vpma_logo.png',
                          height: (MediaQuery.of(context).size.width * 0.6),
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Vidarbha Plywood\nMerchant\'s Association  ',
                          textAlign: TextAlign.center,
                          style: kAppTitleStyle.copyWith(
                              fontSize: 32.0, fontFamily: 'ProductSans'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/yhts.png',
                        height: 50,
                        fit: BoxFit.fitHeight,
                      ),
                      const Text(
                        'Powered By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Yarsh Hybrid Technology Solutions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
