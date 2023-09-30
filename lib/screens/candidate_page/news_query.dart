// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpma_nagpur/main.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/query_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/back_appbar.dart';
import 'package:vpma_nagpur/utils/components/image_selector.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class NewQuery extends StatelessWidget {
  TextEditingController? _controller;
  // Constants? _const;
  // userData? _user;
  // DatabaseManager? _dbRef;
  NewQuery({Key? key}) : super(key: key) {
    _controller = TextEditingController();
    // _dbRef = DatabaseManager.getDbReference;
    // _const = Constants.getReferenceObject;
    // _user = _const!.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: backAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'New query  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 14.0,
              ),
              child: TextFormField(
                key: key,
                controller: _controller,
                enabled: true,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: kPrimaryFontColor,
                  ),
                  hintText: 'Type a message...',
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
                minLines: 10,
                maxLines: 100,
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: kPrimaryColor,
                onPressed: () async {
                  // if (_controller!.text != '') {
                  //   queryData _data = queryData(
                  //     memberContact: _user!.userContact,
                  //     memberEmail: _user!.email,
                  //     memberName: _user!.userName,
                  //     memberID: _user!.userID.toString(),
                  //     msgDate: FieldValue.serverTimestamp().toString(),
                  //     query: _controller!.text,
                  //   );
                  //   _dbRef!.sendQuery(_data).then((value) {
                  //     if (value) {
                  //       Navigator.pop(context);
                  //       showFlushBar(
                  //         context: context,
                  //         title: 'Query Sent.',
                  //         message: 'Great',
                  //       );
                  //     } else {
                  //       showFlushBar(
                  //         context: context,
                  //         title: 'Error occured while sending query!!!',
                  //         message: 'Please wait for sometime or Try again',
                  //         alertStyle: true,
                  //       );
                  //     }
                  //   });
                  // }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 7.0),
                      Icon(
                        FontAwesomeIcons.forward,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }

  Widget getUserProfileIcon() {
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
}
