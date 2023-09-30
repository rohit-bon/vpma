// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/utils/components/stack_slider.dart';
import 'package:vpma_nagpur/utils/constants.dart';
import 'package:http/http.dart' as http;

class NewsFrag extends StatefulWidget {
  const NewsFrag({super.key});

  @override
  State<NewsFrag> createState() => _NewsFragState();
}

Future<List<NewsData>> getNews() async {
  final response = await http.get(Uri.parse('${url}news/'));

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    return body.map((e) => NewsData.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class _NewsFragState extends State<NewsFrag> {
  final Constants _constants = Constants.getReferenceObject;

  @override
  Widget build(BuildContext context) {
    _constants.height = MediaQuery.of(context).size.height;
    _constants.width = MediaQuery.of(context).size.width;
    print('data');
    Future<List<NewsData>> postsFuture = getNews();

    return FutureBuilder<List<NewsData>>(
      future: postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: SliderNews(
                  newsList: posts,
                  currentPage: posts.length,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
                child: Text(
                  'Past news',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              PastNews(
                newsList: posts,
              ),
              const SizedBox(height: 90),
            ],
          );
        } else {
          return const Text("No data available");
        }
      },
    );
  }
}

class SliderNews extends StatefulWidget {
  List<NewsData>? newsList;
  var currentPage;
  SliderNews({super.key, this.newsList, this.currentPage});

  @override
  State<SliderNews> createState() => _SliderNewsState();
}

class _SliderNewsState extends State<SliderNews> {
  @override
  Widget build(BuildContext context) {
    if (widget.newsList != null) {
      if (widget.newsList!.length == 0) {
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
          newsList: widget.newsList,
          currentPage: widget.newsList!.length - 1,
        );
      }
    } else {
      return Container();
    }
  }
}

class PastNews extends StatefulWidget {
  List<NewsData>? newsList;
  PastNews({super.key, this.newsList});

  @override
  State<PastNews> createState() => _PastNewsState();
}

class _PastNewsState extends State<PastNews> {
  @override
  Widget build(BuildContext context) {
    if (widget.newsList != null) {
      if (widget.newsList!.length < 6) {
        return Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'NONE YET!!!  \n',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        List<NewsData>? newsData =
            widget.newsList!.sublist(5, widget.newsList!.length);
        var data = newsData.map((e) => NewsData()).toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: newsData
              .map((data) => DataList(
                    data: data,
                  ))
              .toList(),
        );
      }
    } else {
      return Container(
        height: 10.0,
      );
    }
  }
}

class DataList extends StatelessWidget {
  final NewsData? data;
  const DataList({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    if (data!.image != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 240,
            width: double.maxFinite,
            child: Stack(
              children: [
                Image.network(
                  data!.image!,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
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
                      stops: [0.7, 1],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  data!.description!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Container(
                              child: Center(
                                  child: Tooltip(
                                verticalOffset: 30.0,
                                message: 'Know More',
                                child: RawMaterialButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             NewsInfoView(
                                      //               data: data,
                                      //             )));
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    fillColor: kSecondaryColor,
                                    constraints: const BoxConstraints(
                                        maxHeight: 38.0, maxWidth: 38.0),
                                    elevation: 2.0,
                                    child: const Center(
                                      child: Icon(
                                        Ionicons.information_circle_sharp,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                    )),
                              )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return const Text('dddd');
    }
  }
}
