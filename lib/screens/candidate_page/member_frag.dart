// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/member_profile.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class MembersFrag extends StatefulWidget {
  const MembersFrag({super.key});

  @override
  State<MembersFrag> createState() => _MembersFragState();
}

Future<List<UserData>> getNews() async {
  final response = await http.get(Uri.parse('${url}memberDatabse/'));

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    return body.map((e) => UserData.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class _MembersFragState extends State<MembersFrag> {
  @override
  Widget build(BuildContext context) {
    Future<List<UserData>> postsFuture = getNews();
    return FutureBuilder<List<UserData>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return MemberDataList(
              data: posts,
            );
          } else {
            return const Text("No data available");
          }
        });
  }
}

class ProductFrag extends StatefulWidget {
  const ProductFrag({super.key});

  @override
  State<ProductFrag> createState() => _ProductFragState();
}

Future<List<ProductData>> getProduct() async {
  final response = await http.get(Uri.parse('${url}productDatabse/'));

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    return body.map((e) => ProductData.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class _ProductFragState extends State<ProductFrag> {
  @override
  Widget build(BuildContext context) {
    Future<List<ProductData>> postsFuture = getProduct();
    return FutureBuilder<List<ProductData>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ProductDataList(
              data: posts,
            );
          } else {
            return const Text("No data available");
          }
        });
  }
}

class MemberDataList extends StatefulWidget {
  List<UserData>? data;
  MemberDataList({super.key, this.data});

  @override
  State<MemberDataList> createState() => _MemberDataListState();
}

class _MemberDataListState extends State<MemberDataList> {
  @override
  Widget build(BuildContext context) {
    print('object');
    print(widget.data!.isEmpty);
    return Container(
      color: kThirdColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (widget.data! != null)
          ? MemberBlock(data: widget.data!)
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
    );
  }
}

class ProductDataList extends StatefulWidget {
  List<ProductData>? data;
  ProductDataList({super.key, this.data});

  @override
  State<ProductDataList> createState() => _ProductDataListState();
}

class _ProductDataListState extends State<ProductDataList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThirdColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (widget.data! != null)
          ? ProductBlock(data: widget.data!)
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
    );
  }
}

class MemberBlock extends StatefulWidget {
  final List<UserData>? data;
  const MemberBlock({super.key, this.data});

  @override
  State<MemberBlock> createState() => _MemberBlockState();
}

class _MemberBlockState extends State<MemberBlock> {
  final TextEditingController _controller = TextEditingController();
  bool isTyping = false;
  List<UserData>? _data;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  Widget build(BuildContext context) {
    _data = widget.data;
    print('object');
    print(widget.data!.isEmpty);
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
                              member.shopName!.toString(),
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
                            //   member.memberName!,
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

class ProductBlock extends StatefulWidget {
  List<ProductData>? data;
  ProductBlock({super.key, this.data});

  @override
  State<ProductBlock> createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  List<ProductData>? _data;
  // final FocusNode _focus = FocusNode();

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _data = widget.data;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
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
                          builder: (context) => ProductInfo(
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
                            Image.network(
                              member.productImage!.toString(),
                              width: double.maxFinite,
                              fit: BoxFit.fitWidth,
                            ),
                            Text(
                              member.productName!.toString(),
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
                              member.productSpec!,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: kThirdColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            ShopOwnerList(
                              ownerNames: member.sellers,
                            ),
                            // Text(
                            //   member.memberName!,
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
