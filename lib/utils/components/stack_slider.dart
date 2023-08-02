// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/utils/components/custom_container.dart';
import 'package:vpma_nagpur/utils/constants.dart';

var globalItemCount;

class StackSlider extends StatefulWidget {
  const StackSlider({super.key});

  @override
  State<StackSlider> createState() => _StackSliderState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _StackSliderState extends State<StackSlider> {
  @override
  Widget build(BuildContext context) {
    List<NewsData> newsList = Provider.of<List<NewsData>>(context);
    if (newsList != null) {
      if (newsList.length == 0) {
        return Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'NONE YET!!!',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        return OperationWidget(
          newsList: newsList,
          currentPage: newsList.length - 1,
        );
      }
    } else {
      return Container();
    }
  }
}

class OperationWidget extends StatefulWidget {
  List<NewsData>? newsList;
  var currentPage;
  OperationWidget({super.key, this.newsList, this.currentPage});

  @override
  State<OperationWidget> createState() => _OperationWidgetState();
}

class _OperationWidgetState extends State<OperationWidget> {
  int? itemCount;
  PageController? controller;
  @override
  void initState() {
    super.initState();
    if (widget.newsList!.length < 6) {
      itemCount = widget.newsList!.length;
    } else {
      itemCount = 6;
    }
    controller = PageController(initialPage: widget.newsList!.length - 1);
    globalItemCount = itemCount;
  }

  Widget build(BuildContext context) {
    controller!.addListener(() {
      setState(() {
        widget.currentPage = controller!.page;
      });
    });
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              CardScrollWidget(
                currentPage: widget.currentPage,
                newsList: widget.newsList,
              ),
              Positioned.fill(
                child: PageView.builder(
                  itemCount: itemCount,
                  controller: controller,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => NewsInfoView(
                        //       data: widget.newsList[
                        //           (widget.newsList.length - 1) -
                        //               controller.page.round()],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                          constraints: const BoxConstraints.expand(),
                          width: double.maxFinite),
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.newsList!.map((url) {
                  int index = widget.newsList!.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (((widget.newsList!.length - 1) -
                                  widget.currentPage) ==
                              index)
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.2),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardScrollWidget extends StatefulWidget {
  List<NewsData>? newsList;
  var currentPage;
  CardScrollWidget({super.key, this.newsList, this.currentPage});

  @override
  State<CardScrollWidget> createState() => _CardScrollWidgetState();
}

class _CardScrollWidgetState extends State<CardScrollWidget> {
  var padding = 20.0;
  var verticalInset = 20.0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;
          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var primaryCardHeight = safeHeight;
          var primaryCardWidth = primaryCardHeight * cardAspectRatio;

          var primaryCardLeft = safeWidth - primaryCardWidth;
          var horizontalInset = primaryCardLeft / 2;
          List<Widget> cardList = [];

          for (var i = globalItemCount - 1, j = 0;
              i >= 0 && j < widget.newsList!.length;
              i--, j++) {
            var delta = j - widget.currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: Container(
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      stackWidget(
                        data: widget.newsList![i],
                      ),
                    ],
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }

  Widget stackWidget({NewsData? data}) {
    if (data!.image != null) {
      return Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(11.0),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Image.network(
                  data.image!,
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
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              data.head!,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                                fontSize: 20.0,
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
        color: kSecondaryColor.withOpacity(0.2),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                data.head!,
                maxLines: 4,
                style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    data.description!,
                    maxLines: 10,
                    style: const TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
