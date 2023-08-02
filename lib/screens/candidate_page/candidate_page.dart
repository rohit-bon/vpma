import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vpma_nagpur/screens/mobile_view/mobile_candidate.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class CandidatePage extends StatelessWidget {
  final Constants _constants = Constants.getReferenceObject;
  CandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    _constants.height = MediaQuery.of(context).size.height;
    _constants.width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout.builder(
      // desktop: (BuildContext context) => DesktopCandidatePage(),
      // tablet: (BuildContext context) => DesktopCandidatePage(),
      mobile: (BuildContext context) => MobileCandidate(),
    );
  }
}
