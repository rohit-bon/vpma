// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/models/reply_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/back_appbar.dart';
import 'package:vpma_nagpur/utils/constants.dart';
import 'package:intl/intl.dart' as intl;

class QueryReply extends StatelessWidget {
  ReplyData? data;
  QueryReply({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: backAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25.0),
                  Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${data!.query}  ',
                            textAlign: TextAlign.right,
                            maxLines: 100,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            '${intl.DateFormat.MMMd().parse(data!.queryDate!)}  ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: data!.reply != null,
              child: Container(
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        color: kPrimaryColor,
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data!.reply.toString() + '  ',
                                textAlign: TextAlign.left,
                                maxLines: 100,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                data!.replyDate != null
                                    ? '${intl.DateFormat.MMMd().parse(data!.replyDate!)}  '
                                    : '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 25.0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }
}
