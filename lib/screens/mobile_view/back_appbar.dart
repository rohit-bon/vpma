import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/profile_page.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

PreferredSize backAppBar(context) {
  return PreferredSize(
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
                    OwnerWidget(
                      width: 45,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  ),
                  child: getUserProfileIcon(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget getUserProfileIcon() {
  final Constants _const = Constants.getReferenceObject;
  UserData? _user = _const.user;
  if (_user!.userImage.toString() == 'null') {
    return const CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 20.0,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 38.0,
      ),
    );
  } else {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(_user.userImage!),
    );
  }
}
