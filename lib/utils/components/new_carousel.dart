// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/utils/components/custom_button.dart';
import 'package:vpma_nagpur/utils/components/custom_container.dart';

class NewCarousel extends StatefulWidget {
  final Function? dialogCallback;
  const NewCarousel({super.key, this.dialogCallback});

  @override
  State<NewCarousel> createState() => _NewCarouselState();
}

class _NewCarouselState extends State<NewCarousel> {
  int _currentPage = 0;
  int? limit;
  @override
  Widget build(BuildContext context) {
    List<NewsData> data = Provider.of<List<NewsData>>(context);
    if (data != null) {
      List<NewsData> newsData = [];
      if (data.length < 6) {
        limit = data.length;
      } else {
        limit = 6;
      }
      for (int i = 0; i < limit!; i++) {
        if (data[i] != null) {
          newsData.add(data[i]);
        }
      }
      return Column(
        children: [
          Builder(builder: (context) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 500,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              items: newsData
                  .map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: NewsBlock(
                            dialogCallback: widget.dialogCallback,
                            newsData: item,
                            imageVisible: (item.image != null),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: newsData.map((url) {
                  int index = newsData.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
      );
    } else {
      return Container(
        color: Colors.transparent,
      );
    }
  }
}

class NewsBlock extends StatefulWidget {
  final NewsData? newsData;
  bool? imageVisible;
  Function? dialogCallback;
  NewsBlock({super.key, this.newsData, this.imageVisible, this.dialogCallback});

  @override
  State<NewsBlock> createState() => _NewsBlockState();
}

class _NewsBlockState extends State<NewsBlock> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageVisible!) {
      return CustomContainer(
        elevation: 7.0,
        leftPadding: 3.0,
        rightPadding: 3.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11.0),
          child: Stack(
            children: [
              Container(
                child: Image.network(
                  widget.newsData!.image!,
                  fit: BoxFit.fill,
                  height: double.maxFinite,
                  width: double.maxFinite,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(200, 0, 0, 0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.newsData!.head!,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: CustomButtonWidget(
                                icon: EvaIcons.infoOutline,
                                title: 'Know More',
                                onTap: () => widget.dialogCallback!(
                                    widget.newsData, true),
                              ),
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
      );
    } else {
      return CustomContainer(
        elevation: 7.0,
        leftPadding: 3.0,
        rightPadding: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.newsData!.head!,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20.0,
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                      width: double.maxFinite,
                    ),
                    Text(
                      widget.newsData!.description!,
                      textAlign: TextAlign.center,
                      maxLines: 6,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20.0,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: CustomButtonWidget(
                  icon: EvaIcons.infoOutline,
                  title: 'Know More',
                  onTap: () => widget.dialogCallback!(widget.newsData, false),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
