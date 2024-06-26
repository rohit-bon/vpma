// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';

class UpcomingEvent extends StatefulWidget {
  final double? horizontalPadding;
  String? data;
  UpcomingEvent({super.key, this.horizontalPadding = 50.0, this.data});

  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding!, vertical: 15.0),
        child: Text(
          widget.data! + ' \n',
          textAlign: TextAlign.center,
          maxLines: 14,
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      );
    } else {
      return Container(
        height: 20.0,
      );
    }
  }
}
