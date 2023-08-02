import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpma_nagpur/models/nav_item_data.dart';
import 'package:ionicons/ionicons.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/logout.dart';
import 'package:vpma_nagpur/screens/mobile_view/events_frag.dart';
import 'package:vpma_nagpur/screens/mobile_view/members_frag.dart';
import 'package:vpma_nagpur/screens/mobile_view/news_frag.dart';
import 'package:vpma_nagpur/screens/mobile_view/profile_page.dart';
import 'package:vpma_nagpur/screens/mobile_view/query.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';
import 'package:vpma_nagpur/utils/constants.dart';

List<NavItemData> navData = [
  NavItemData(title: 'News', icon: FontAwesomeIcons.newspaper),
  NavItemData(title: 'Events', icon: FontAwesomeIcons.calendar),
  NavItemData(title: 'Directory', icon: Ionicons.people),
  NavItemData(title: 'Queries', icon: Icons.comment),
];

class MobileCandidate extends StatefulWidget {
  const MobileCandidate({super.key});

  @override
  State<MobileCandidate> createState() => _MobileCandidateState();
}

class _MobileCandidateState extends State<MobileCandidate>
    with SingleTickerProviderStateMixin {
  Constants? _constants;
  UserData? _user;
  TabController? _controller;
  ScrollPhysics? physics;

  _MobileCandidateState() {
    _controller = new TabController(vsync: this, length: navData.length);
    _constants = Constants.getReferenceObject;
    _user = _constants!.user;
    physics = const AlwaysScrollableScrollPhysics();
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

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Logout(),
        ),
      );
    }
    _controller!.addListener(onTabChange);
    return DefaultTabController(
        length: navData.length,
        child: Scaffold(
          backgroundColor: kThirdColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(149),
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
                                builder: (context) => ProfilePage(),
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
                          .copyWith(fontSize: 14.0),
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
              children: [
                NewsFrag(),
                EventsFrag(),
                MembersFrag(),
                Query(),
              ],
            ),
          ),
        ));
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
