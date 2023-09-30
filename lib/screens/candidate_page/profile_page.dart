// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpma_nagpur/main.dart';
import 'package:vpma_nagpur/screens/logout.dart';
import 'package:vpma_nagpur/utils/components/image_selector.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? _nameController,
      _shopController,
      _shopAddController,
      _emailController,
      _contactController,
      _gstController,
      _renewalController,
      _passController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _shopController = TextEditingController();
    _shopAddController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();
    _passController = TextEditingController();
    _renewalController = TextEditingController();
    _gstController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nameController!.text = nameGlobal!;
    _shopController!.text = snameGlobal!;
    _shopAddController!.text = addGlobal!;
    _emailController!.text = emailGlobal!;
    _contactController!.text = contactGlobal!;
    _renewalController!.text = dateGlobal!;
    _passController!.text = '************';
    _gstController!.text = gstGlobal!;
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(151),
        child: Container(
          color: kPrimaryColor,
          child: SafeArea(
            child: Container(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    OwnerWidget(),
                    const SizedBox(width: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              color: kThirdColor,
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 260,
                        width: 260,
                        child: Stack(
                          children: [
                            getUserProfile(imageGlobal!),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, right: 10.0),
                                child: FloatingActionButton(
                                  backgroundColor: kSecondaryColor,
                                  onPressed: () {
                                    // getImage().then((value) {
                                    //   if (value.name.contains('.jpg') ||
                                    //       value.name.contains('.JPG') ||
                                    //       value.name.contains('.png') ||
                                    //       value.name.contains('.PNG') ||
                                    //       value.name.contains('.jpeg') ||
                                    //       value.name.contains('.JPEG')) {
                                    //     _dbRef
                                    //         .uploadProfileImage(
                                    //             _user!.id.toString(), value,
                                    //             isSelf: true)
                                    //         .then((value) {
                                    //       if (!value) {
                                    //         showFlushBar(
                                    //           context: context,
                                    //           title:
                                    //               'Problem occured while updating profile image!!!',
                                    //           alertStyle: true,
                                    //           message:
                                    //               'Please wait for some time or try again.',
                                    //         );
                                    //       } else {
                                    //         setState(() {
                                    //           _user!.userImage = value;
                                    //         });
                                    //         showFlushBar(
                                    //           context: context,
                                    //           title:
                                    //               'Member Profile Image Updated Successfully.',
                                    //           message: 'Perfect',
                                    //         );
                                    //       }
                                    //     });
                                    //   } else {
                                    //     showFlushBar(
                                    //       context: context,
                                    //       title:
                                    //           'Image with invalid format selected!!!',
                                    //       alertStyle: true,
                                    //       message:
                                    //           'Select a image with ".jpg" or ".png" format only and try again.',
                                    //     );
                                    //   }
                                    // });
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          nameGlobal!,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: activeStatusGlobal!
                            ? Colors.greenAccent[400]
                            : (blacklistedGlobal!
                                ? Colors.redAccent[400]
                                : Colors.yellowAccent[400]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          child: Text(
                            (activeStatusGlobal!
                                ? '  ACTIVE  '
                                : (blacklistedGlobal!
                                    ? '  BLACKLISTED  '
                                    : '  INACTIVE  ')),
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  infoTextField(
                    labelText: 'Shop Name',
                    maxLines: 2,
                    controller: _shopController!,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var mapScheme = "http://maps.google.co.in/maps?q=" +
                          _shopAddController!.text;
                      if (await canLaunchUrl(Uri.parse(mapScheme))) {
                        await launchUrl(Uri.parse(mapScheme));
                      } else {
                        showFlushBar(
                          context: context,
                          title: 'Unable to redirect to Google Maps',
                          alertStyle: true,
                          message:
                              'Make sure you are connected to internet or Try Again!',
                        );
                      }
                    },
                    child: infoTextField(
                      labelText: 'Shop Address',
                      maxLines: 8,
                      controller: _shopAddController!,
                    ),
                  ),
                  infoTextField(
                    labelText: 'GST Number',
                    controller: _gstController!,
                  ),
                  infoTextField(
                    labelText: 'E-Mail',
                    controller: _emailController!,
                  ),
                  infoTextField(
                    labelText: 'Contact',
                    controller: _contactController!,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: infoTextField(
                          labelText: 'Renewal Date',
                          controller: _renewalController!,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Logout()),
                            (route) => false);
                      },
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: kSecondaryColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUserProfile(String userImage) {
    // if (userImage == null || userImage.toString() == 'null') {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 130.0,
      child: Icon(
        Icons.account_circle,
        color: Colors.blueGrey[100],
        size: 255.0,
      ),
    );
    // } else {
    //   return CircleAvatar(
    //     backgroundColor: Colors.transparent,
    //     radius: 130.0,
    //     backgroundImage: NetworkImage(userImage),
    //   );
    // }
  }

  Widget infoTextField(
      {Key? key,
      String? labelText,
      int maxLines = 2,
      TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      child: TextFormField(
        key: widget.key,
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: kPrimaryColor,
          ),
          hintText: labelText,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blueGrey[900]!,
              width: 2.5,
            ),
          ),
        ),
        minLines: 1,
        maxLines: maxLines,
      ),
    );
  }
}

logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
