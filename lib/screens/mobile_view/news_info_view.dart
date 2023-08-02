// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/back_appbar.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class NewsInfoView extends StatelessWidget {
  final Constants _const = Constants.getReferenceObject;
  UserData? _user;
  NewsData? data;
  NewsInfoView({Key? key, this.data}) : super(key: key) {
    _user = _const.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: backAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            getNewsThumb(),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${data!.head!}  ',
                maxLines: 8,
                style: const TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'ProductSans',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                bottom: 40.0,
                top: 10.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Text(
                '${data!.description!}  \n',
                textAlign: TextAlign.justify,
                maxLines: 100,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'ProductSans',
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: kPrimaryFontColor,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '${data!.published.toDate()}  \n',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'ProductSans',
                      color: kPrimaryFontColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }

  Widget getNewsThumb() {
    if (data!.image != null) {
      return Image.network(
        data!.image!,
        width: double.maxFinite,
        fit: BoxFit.fitWidth,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget getUserProfileIcon() {
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
        backgroundImage: NetworkImage(_user!.userImage!),
      );
    }
  }
}
