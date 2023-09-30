// ignore_for_file: unused_local_variable, unnecessary_new

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpma_nagpur/models/nav_item_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/Query.dart';
import 'package:vpma_nagpur/screens/candidate_page/events_frag.dart';
import 'package:vpma_nagpur/screens/candidate_page/member_frag.dart';
import 'package:vpma_nagpur/screens/candidate_page/news_frag.dart';
import 'package:vpma_nagpur/screens/candidate_page/profile_page.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

List<NavItemData> navData = [
  NavItemData(title: 'News', icon: FontAwesomeIcons.newspaper),
  NavItemData(title: 'Events', icon: FontAwesomeIcons.calendar),
  NavItemData(title: 'Products', icon: Ionicons.cart_outline),
  NavItemData(title: 'Directory', icon: Ionicons.people),
  NavItemData(title: 'Queries', icon: Icons.comment),
];

class MobileCandidate extends StatefulWidget {
  MobileCandidate({super.key});

  @override
  State<MobileCandidate> createState() => _MobileCandidateState();
}

class _MobileCandidateState extends State<MobileCandidate>
    with TickerProviderStateMixin {
  Constants? _constants;
  TabController? _controller;
  ScrollPhysics? physics;

  bool? loggedIn;
  bool? activeStatus;
  bool? blacklisted;
  String? uID;
  String? email;
  String? password;
  String? contact;
  String? gst;
  String? name;
  String? type;
  String? date;
  String? add;
  String? sname;
  String? image;

  Future<bool> getCache() async {
    SharedPreferences _cache = await SharedPreferences.getInstance();

    loggedIn = _cache.getBool('isLoggedIn');
    activeStatus = _cache.getBool('activeStatus');
    blacklisted = _cache.getBool('blacklisted');
    uID = _cache.getString('userID');
    email = _cache.getString('userEmail');
    password = _cache.getString('userPassword');
    contact = _cache.getString('userCOntact');
    gst = _cache.getString('userGstNo');
    name = _cache.getString('userName');
    type = _cache.getString('userType');
    date = _cache.getString('userRenewalDate');
    add = _cache.getString('userShopAddress');
    sname = _cache.getString('userShopName');
    image = _cache.getString('userImage');
    print(uID);
    tp();

    return true;
  }

  void onTabChange() {
    setState(() {
      if (_controller!.index == 2) {
        physics = const NeverScrollableScrollPhysics();
      } else {
        physics = const AlwaysScrollableScrollPhysics();
      }
    });
  }

  void tp() {
    print(uID);
  }

  @override
  void initState() {
    _controller = new TabController(vsync: this, length: navData.length);
    _constants = Constants.getReferenceObject;
    physics = const AlwaysScrollableScrollPhysics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userCheck = getCache();

    _constants!.height = MediaQuery.of(context).size.height;
    _constants!.width = MediaQuery.of(context).size.width;

    _controller!.addListener(onTabChange);

    return DefaultTabController(
        length: navData.length,
        child: Scaffold(
          backgroundColor: kThirdColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(149),
            child: Container(
              color: kPrimaryColor,
              child: SafeArea(
                  child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OwnerWidget(),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            ),
                            child: getUserProfileIcon(),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      controller: _controller,
                      isScrollable: true,
                      indicatorWeight: 2.0,
                      indicatorColor: kPrimaryColor,
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.0),
                      tabs: navData
                          .map((data) => Tab(
                                text: data.title,
                                icon: Icon(
                                  data.icon,
                                  size: 24,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              )),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              physics: physics,
              controller: _controller,
              children: const [
                NewsFrag(),
                EventsFrag(),
                ProductFrag(),
                MembersFrag(),
                Query(),
              ],
            ),
          ),
        ));
  }

  Widget getUserProfileIcon() {
    // if (image == null) {
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
    //     backgroundImage: NetworkImage(image!),
    //   );
    // }
  }
}
