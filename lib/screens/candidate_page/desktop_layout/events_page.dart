// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingEvent extends StatefulWidget {
  final double? horizontalPadding;
  const UpcomingEvent({super.key, this.horizontalPadding = 50.0});

  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  @override
  Widget build(BuildContext context) {
    var upComingEvent = Provider.of<String>(context);
    if (upComingEvent != null) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding!, vertical: 15.0),
        child: Text(
          upComingEvent + ' \n',
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
