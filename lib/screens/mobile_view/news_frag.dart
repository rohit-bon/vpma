// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/news_info_view.dart';
import 'package:vpma_nagpur/utils/components/custom_button.dart';
import 'package:vpma_nagpur/utils/components/custom_container.dart';
import 'package:vpma_nagpur/utils/components/custom_floating_button.dart';
import 'package:vpma_nagpur/utils/components/stack_slider.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class NewsFrag extends StatefulWidget {
  const NewsFrag({super.key});

  @override
  State<NewsFrag> createState() => _NewsFragState();
}

class _NewsFragState extends State<NewsFrag> {
  final Constants _constants = Constants.getReferenceObject;
  late DatabaseManager _dbRef;
  _NewsFragState() {
    _dbRef = DatabaseManager.getDbReference;
  }
  @override
  Widget build(BuildContext context) {
    _constants.height = MediaQuery.of(context).size.height;
    _constants.width = MediaQuery.of(context).size.width;
    var newsData = _dbRef.getNews();
    return Stack(
      children: [
        StreamProvider<List<NewsData>>(
          create: (_) => newsData,
          initialData: [],
          child: ListView(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const StackSlider(),
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
              const PastNews(),
              const SizedBox(height: 90),
            ],
          ),
        )
      ],
    );
  }
}

class PastNews extends StatefulWidget {
  const PastNews({super.key});

  @override
  State<PastNews> createState() => _PastNewsState();
}

class _PastNewsState extends State<PastNews> {
  @override
  Widget build(BuildContext context) {
    var newsData = Provider.of<List<NewsData>>(context);
    if (newsData != null) {
      if (newsData.length < 6) {
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
        newsData = newsData.sublist(5, newsData.length);
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: newsData
              .map((data) => dataTile(
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

class dataTile extends StatelessWidget {
  final NewsData? data;
  const dataTile({super.key, this.data});

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: CustomFloatingButton(
                                    icon: Ionicons.information_circle_sharp,
                                    tooltip: 'Know More',
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsInfoView(
                                          data: data,
                                        ),
                                      ),
                                    ),
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
              )),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        child: CustomContainer(
          color: kSecondaryColor.withOpacity(0.7),
          elevation: 5.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  data!.description!,
                  maxLines: 10,
                  style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    CustomButtonWidget(
                      title: 'Know More',
                      icon: Ionicons.information_circle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsInfoView(
                            data: data,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
