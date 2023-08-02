// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_this

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/nav_item_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/utils/constants.dart';

// ignore: must_be_immutable
class CollapsingNavbar extends StatefulWidget {
  List<NavItemData>? navData;
  Function? callback;
  bool isAdmin;
  Function? profileCall;
  CollapsingNavbar(
      {super.key,
      this.navData,
      this.callback,
      this.isAdmin = false,
      this.profileCall});

  @override
  State<CollapsingNavbar> createState() => _CollapsingNavbarState();
}

class _CollapsingNavbarState extends State<CollapsingNavbar> {
  final Constants _constants = Constants.getReferenceObject;
  final DatabaseManager _dbRef = DatabaseManager.getDbReference;
  double expandWidth = 250.0;
  int selectedTab = 0;
  UserData? _user;

  @override
  Widget build(BuildContext context) {
    _user = _constants.user;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.isAdmin ? Colors.blueGrey[900] : kPrimaryColor,
      height: MediaQuery.of(context).size.height,
      width: expandWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: widget.isAdmin ? Colors.blueGrey : kSecondaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: InkWell(
                    onTap: () => this.widget.profileCall!(_user),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getUserProfileIcon(),
                        Expanded(
                            child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              _user!.memberName!,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              _dbRef.signOut().then((value) {
                                if (value) {
                                  if (widget.isAdmin) {
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Logout(
                                    //       isAdmin: widget.isAdmin,
                                    //     ),
                                    //   ),
                                    // );
                                  } else {
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Logout(),
                                    //   ),
                                    // );
                                  }
                                } else {
                                  showFlushBar(
                                    context: context,
                                    title: 'Error signing out!!!',
                                    alertStyle: true,
                                    message:
                                        'Please wait for sometime or Try again',
                                  );
                                }
                              });
                            },
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getUserProfileIcon() {
    try {
      if (_user!.userImage.toString() == 'null' || _user!.userImage == null) {
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
    } catch (e) {
      print('Set Profile Image\n\n' + e.toString());
      return const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20.0,
        child: Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 38.0,
        ),
      );
    }
  }

  void showFlushBar(
      {String? title,
      required BuildContext context,
      bool alertStyle = false,
      String message = 'Please wait ofr sometime or Try again '}) {
    Flushbar(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15.0),
      borderRadius: BorderRadius.circular(8.0),
      backgroundGradient: LinearGradient(
        colors: alertStyle
            ? [
                const Color.fromARGB(255, 255, 23, 68),
                const Color.fromARGB(255, 255, 23, 68)
              ]
            : [
                const Color.fromARGB(255, 0, 230, 118),
                const Color.fromARGB(255, 0, 230, 118)
              ],
        stops: const [0.4, 1],
      ),
      boxShadows: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 4,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: message,
      duration: const Duration(seconds: 5),
    ).show(context);
  }
}
