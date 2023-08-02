// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpma_nagpur/utils/components/image_selector.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class MemberProfile extends StatelessWidget {
  final MemberData? data;
  MemberProfile({super.key, this.data});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _shopController = TextEditingController();
  TextEditingController _shopAddController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = data!.memberName!;
    _shopController.text = data!.shopName!;
    _shopAddController.text = data!.shopAddress!;
    _contactController.text = data!.contact!;
    _latController.text = data!.latitude!;
    _longController.text = data!.longitude!;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: data!.memberName!.split(',').map((name) {
                        return Text(
                          name.trim(),
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  infoTextField(
                    labelText: 'Shop Name',
                    maxLines: 2,
                    controller: _shopController,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // var _adds = await Geocoder.local
                      //     .findAddressesFromQuery(_shopAddController.text);

                      // Address _first = _adds.first;
                      // print(_first.coordinates.latitude);

                      // double lat = _first.coordinates.latitude,
                      //     long = _first.coordinates.latitude;
                      var mapScheme =
                          "http://maps.google.co.in/maps?q=${_shopAddController.text}";
                      // 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                      if (await canLaunch(mapScheme)) {
                        await launch(mapScheme);
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
                      controller: _shopAddController,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _contactController.text.split(',').map((number) {
                      final TextEditingController _temp =
                          new TextEditingController();
                      _temp.text = number.trim();
                      int i =
                          (_contactController.text.split(',').indexOf(number) +
                              1);
                      return GestureDetector(
                        onTap: () async {
                          if (await canLaunchUrl(
                              Uri.parse('tel:${_temp.text}'))) {
                            await launchUrl(Uri.parse('tel:${_temp.text}'));
                          } else {
                            showFlushBar(
                              context: context,
                              title: 'Unable to launch dialer!',
                              message:
                                  'No supported app found on device, please install one & try again.',
                            );
                          }
                        },
                        child: infoTextField(
                          labelText: 'Contact $i',
                          controller: _temp,
                        ),
                      );
                    }).toList(),
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

  Widget infoTextField(
      {Key? key,
      String? labelText,
      int maxLines = 2,
      TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      child: TextFormField(
        key: this.key,
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          hintText: labelText,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
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
