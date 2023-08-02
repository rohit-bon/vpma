// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/screens/mobile_view/back_appbar.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class GalleryView extends StatefulWidget {
  int? index;
  List<String>? imageList;
  GalleryView({super.key, this.imageList, this.index});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  PageController _controller = PageController();
  ScrollController _scrollController = ScrollController();
  int? selectedImage;
  @override
  void initState() {
    super.initState();
    PageController(initialPage: widget.index!);
    selectedImage = widget.index;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: backAppBar(context),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (page) {
                    setState(() {
                      selectedImage = page;
                    });
                    _scrollController.animateTo(
                      (selectedImage! * 118).roundToDouble(),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  children: widget.imageList!
                      .map((image) => Image.network(
                            image,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ))
                      .toList(),
                ),
              ),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: widget.imageList!
                      .map(
                        (img) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = widget.imageList!.indexOf(img);
                            });
                            _controller.animateToPage(
                              selectedImage!,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: (selectedImage ==
                                          widget.imageList!.indexOf(img))
                                      ? 6.0
                                      : 0.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            height: 118,
                            width: 118,
                            child: Image.network(
                              img,
                              scale: 1.0,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
