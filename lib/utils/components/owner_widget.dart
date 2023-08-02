// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class OwnerWidget extends StatelessWidget {
  double? width;
  OwnerWidget({this.width = 55.0});
  //  OwnerWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/vpma_logo.png',
          fit: BoxFit.fitWidth,
          width: width,
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
    );
  }
}
