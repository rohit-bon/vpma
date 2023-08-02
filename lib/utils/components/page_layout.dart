// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/utils/components/owner_widget.dart';

class PageLayoutComponent extends StatelessWidget {
  final String? pageTitle;
  final Widget? child;
  double? height;
  PageLayoutComponent({super.key, this.pageTitle, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    height ??= MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: double.maxFinite,
      child: ListView(
        shrinkWrap: true,
        children: [
          MainComponent(
            pageTitle: pageTitle,
            child: child,
          ),
        ],
      ),
    );
  }
}

class MainComponent extends StatelessWidget {
  final String? pageTitle;
  final Widget? child;
  const MainComponent({super.key, this.child, this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            left: 24.0,
            right: 28.0,
            bottom: 20.0,
          ),
          child: Row(
            children: [
              Hero(tag: 'logo', child: OwnerWidget()),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Text(
                pageTitle!,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
        ),
        child!,
      ],
    );
  }
}
