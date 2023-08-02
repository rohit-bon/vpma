// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/utils/components/new_carousel.dart';

class PastNewsWidget extends StatefulWidget {
  final Function? dialogCallback;
  final int? gridSize;
  const PastNewsWidget({super.key, this.gridSize, this.dialogCallback});

  @override
  State<PastNewsWidget> createState() => _PastNewsWidgetState();
}

class _PastNewsWidgetState extends State<PastNewsWidget> {
  @override
  Widget build(BuildContext context) {
    List<NewsData> newsData = Provider.of<List<NewsData>>(context);
    if (newsData != null) {
      if (newsData.length > 5) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridSize!),
          shrinkWrap: true,
          itemBuilder: (context, index) => ListBlock(
            data: newsData[index + 5],
            visible: (newsData[index + 5].image != null),
            dialogCallback: this.widget.dialogCallback,
          ),
          itemCount: newsData.length - 5,
        );
      } else {
        return Container(
          height: 200,
          child: Center(
            child: Text(
              'NONE YET',
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontFamily: 'Ubuntu',
                fontSize: 22.0,
              ),
            ),
          ),
        );
      }
    } else {
      return Container(
        child: Text(
          'NONE YET',
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontFamily: 'Ubuntu',
            fontSize: 22.0,
          ),
        ),
      );
    }
  }
}

class ListBlock extends StatelessWidget {
  final Function? dialogCallback;
  final NewsData? data;
  final bool? visible;
  const ListBlock({super.key, this.data, this.visible, this.dialogCallback});

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 20.0),
        height: 70,
        child: NewsBlock(
          newsData: data,
          imageVisible: visible,
          dialogCallback: this.dialogCallback,
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}
