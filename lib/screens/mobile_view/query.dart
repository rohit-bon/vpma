// ignore_for_file: unnecessary_null_comparison, unused_field, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/reply_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/news_query.dart';
import 'package:vpma_nagpur/utils/constants.dart';
import 'package:intl/intl.dart' as intl;

class Query extends StatelessWidget {
  DatabaseManager? _dbRef = DatabaseManager.getDbReference;
  Constants? _const = Constants.getReferenceObject;
  Query({super.key});

  @override
  Widget build(BuildContext context) {
    var queryReplies = _dbRef!.getQueryReply(_const!.user!.id.toString());
    return StreamProvider<List<ReplyData>>(
      initialData: [],
      create: (_) => queryReplies,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      'Query responces  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  ReplyList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FloatingActionButton(
              elevation: 10.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewQuery(),
                  ),
                );
              },
              backgroundColor: kPrimaryColor,
              child: Icon(
                FontAwesomeIcons.comment,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReplyList extends StatefulWidget {
  const ReplyList({super.key});

  @override
  State<ReplyList> createState() => _ReplyListState();
}

class _ReplyListState extends State<ReplyList> {
  Constants _const = Constants.getReferenceObject;
  @override
  Widget build(BuildContext context) {
    var queryReply = Provider.of<List<ReplyData>>(context);
    if (queryReply != null) {
      if (queryReply.length > 0) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: queryReply
              .map(
                (reply) => InkWell(
                  onTap: () async {
                    // await Firestore.instance
                    //     .collection('memberDatabase')
                    //     .document(_const.user.userID)
                    //     .collection('queryReplies')
                    //     .document(reply.replyID)
                    //     .updateData({'viewed': true});

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => QueryReply(
                    //       data: reply,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 10.0,
                          ),
                          child: CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            radius: 25.0,
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  '${reply.query!}  ',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: reply.viewed! ? kViewMsg : kUnviewMsg,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 2.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${intl.DateFormat.MMMd().parse(reply.queryDate!)}  ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 9,
                                      ),
                                    ),
                                    Text(
                                      '${intl.DateFormat.Hm().parse(reply.queryDate!)}  ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      } else {
        return Container(
          width: double.maxFinite,
          height: 300,
          child: Center(
            child: Text(
              'no recent replies  ',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        );
      }
    } else {
      return Container(
        width: double.maxFinite,
        height: 300,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              kPrimaryColor,
            ),
          ),
        ),
      );
    }
  }
}
