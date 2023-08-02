// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/member_profile.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class MembersFrag extends StatefulWidget {
  const MembersFrag({super.key});

  @override
  State<MembersFrag> createState() => _MembersFragState();
}

class _MembersFragState extends State<MembersFrag> {
  final DatabaseManager _dbRef = DatabaseManager.getDbReference;
  @override
  Widget build(BuildContext context) {
    Stream<List<MemberData>> memberData = _dbRef.getMembers();
    return StreamProvider<List<MemberData>>(
      initialData: [],
      create: (_) => memberData,
      child: const MemberDataList(),
    );
  }
}

class MemberDataList extends StatefulWidget {
  const MemberDataList({super.key});

  @override
  State<MemberDataList> createState() => _MemberDataListState();
}

class _MemberDataListState extends State<MemberDataList> {
  @override
  Widget build(BuildContext context) {
    List<MemberData> _memberData = Provider.of<List<MemberData>>(context);
    List<MemberData> _data = _memberData;
    return Container(
      color: kThirdColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (_data != null)
          ? MemberBlock(data: _data)
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
    );
  }
}

class MemberBlock extends StatefulWidget {
  final List<MemberData>? data;
  const MemberBlock({super.key, this.data});

  @override
  State<MemberBlock> createState() => _MemberBlockState();
}

class _MemberBlockState extends State<MemberBlock> {
  final TextEditingController _controller = TextEditingController();
  bool isTyping = false;
  List<MemberData>? _data;
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15.0,
          ),
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                TextFormField(
                  focusNode: _focus,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Search Members",
                    filled: false,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                  ),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (value) {
                    if (_controller.text != '') {
                      setState(() {
                        isTyping = true;
                        _data = _data!
                            .where((element) => (element.memberName!
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase()) ||
                                element.shopAddress!
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase()) ||
                                element.shopName!
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase())))
                            .toList();
                      });
                    } else if (_controller.text == '') {
                      setState(() {
                        isTyping = false;
                        _data = widget.data;
                      });
                    }
                    // changeMaded = true;
                  },
                ),
                Visibility(
                  visible: isTyping,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 60.0,
                      width: 40.0,
                      child: Center(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              _controller.text = '';
                              setState(() {
                                isTyping = false;
                                _data = widget.data;
                              });
                              _focus.unfocus();
                            },
                            child: Icon(
                              Ionicons.close_circle_outline,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: _data!
              .map(
                (member) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemberProfile(
                            data: member,
                          ),
                        ),
                      );
                    },
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
                              member.shopName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
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
                            const SizedBox(
                              height: 5.0,
                            ),
                            ShopOwnerList(
                              ownerNames: member.memberName,
                            ),
                            // Text(
                            //   member.memberName,
                            //   style: TextStyle(
                            //     fontSize: 18.0,
                            //     color: kThirdColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focus.dispose();

    super.dispose();
  }
}

class ShopOwnerList extends StatelessWidget {
  final String? ownerNames;
  const ShopOwnerList({super.key, this.ownerNames});

  @override
  Widget build(BuildContext context) {
    List<String> _names = ownerNames!.split(',');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _names
          .map((name) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 25,
                      child: Icon(
                        Icons.person,
                        color: kThirdColor,
                        size: 20.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        name.trim(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: kThirdColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
