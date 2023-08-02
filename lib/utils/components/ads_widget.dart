// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/add_data.dart';
import 'package:vpma_nagpur/models/database_manager.dart';

class AdsWidget extends StatelessWidget {
  final DatabaseManager _dbRef = DatabaseManager.getDbReference;
  final bool isMobile;
  AdsWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    var adData = _dbRef.getAds();
    return StreamProvider<List<AdData>>(
      create: (_) => adData,
      initialData: [],
      child: AdCarousel(
        isMobile: isMobile,
      ),
    );
  }
}

class AdCarousel extends StatefulWidget {
  final bool isMobile;
  AdCarousel({super.key, required this.isMobile});

  @override
  State<AdCarousel> createState() => _AdCarouselState();
}

class _AdCarouselState extends State<AdCarousel> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    List<AdData> adData = Provider.of<List<AdData>>(context);
    if (adData != null) {
      return Stack(
        children: [
          Builder(builder: (context) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: false,
                autoPlay: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              items: adData
                  .map((item) => GestureDetector(
                        onTap: () {
                          if (widget.isMobile) {
                            showDialog(
                              context: context,
                              builder: (_) => Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Image.network(
                                    item.wideAdURL!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: CarouselContainer(
                            item.adURL!, MediaQuery.of(context).size.width),
                      ))
                  .toList(),
            );
          }),
          Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: adData.map((url) {
                      int index = adData.indexOf(url);
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget CarouselContainer(String item, double width) {
    if (!widget.isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image.network(
            item,
            fit: BoxFit.fill,
            height: double.maxFinite,
            width: width, //_constants.width * 0.80,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          child: Image.network(
            item,
            fit: BoxFit.fill,
            height: double.maxFinite,
            width: width, //_constants.width * 0.80,
          ),
        ),
      );
    }
  }
}
