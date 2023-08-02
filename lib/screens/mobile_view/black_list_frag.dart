// ignore_for_file: unnecessary_null_comparison, prefer_is_empty, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class BlackListFrag extends StatefulWidget {
  const BlackListFrag({super.key});

  @override
  State<BlackListFrag> createState() => _BlackListFragState();
}

class _BlackListFragState extends State<BlackListFrag> {
  final DatabaseManager _dbRef = DatabaseManager.getDbReference;
  @override
  Widget build(BuildContext context) {
    Stream<List<MemberData>> memberData = _dbRef.getMembers();
    return StreamProvider<List<MemberData>>(
      create: (_) => memberData,
      initialData: [],
      child: const BlackList(),
    );
  }
}

class BlackList extends StatefulWidget {
  const BlackList({super.key});

  @override
  State<BlackList> createState() => _BlackListState();
}

class _BlackListState extends State<BlackList> {
  @override
  Widget build(BuildContext context) {
    List<MemberData>? _memberData = Provider.of<List<MemberData>>(context);
    List<MemberData>? _data;
    if (_memberData != null) {
      _data = _memberData.where((element) => element.blacklisted!).toList();
    }
    return Container(
      color: kThirdColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (_data != null)
          ? BlackListBlock(data: _data)
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
    );
  }
}

class BlackListBlock extends StatefulWidget {
  final List<MemberData>? data;
  const BlackListBlock({super.key, this.data});

  @override
  State<BlackListBlock> createState() => _BlackListBlockState();
}

class _BlackListBlockState extends State<BlackListBlock> {
  List<MemberData>? _data;
  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  Widget build(BuildContext context) {
    if (_data!.length == 0) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            'no data found...',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
    return ListView(
      children: _data!
          .map(
            (member) => Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15.0),
              child: Material(
                borderRadius: BorderRadius.circular(
                  4.0,
                ),
                color: kPrimaryColor,
                elevation: 6.0,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.memberName!,
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: kThirdColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        member.shopName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: kThirdColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        member.shopAddress!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: kThirdColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
