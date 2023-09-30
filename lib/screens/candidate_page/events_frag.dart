// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:vpma_nagpur/models/events_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/desktop_layout/events_page.dart';
import 'package:vpma_nagpur/utils/constants.dart';

Future<String> getUpComingEvent() async {
  final response = await http.get(Uri.parse('${url}upComingEvents/'));

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    print(body[0]['eventDesc']);
    return body[0]['eventDesc'];
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<EventsData>> getEvents() async {
  final response = await http.get(Uri.parse('${url}events/'));

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    return body.map((e) => EventsData.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class EventsFrag extends StatelessWidget {
  const EventsFrag({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> upEvent = getUpComingEvent();
    Future<List<EventsData>> postEvents = getEvents();
    return Stack(
      children: [
        FutureBuilder<List<EventsData>>(
            future: postEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              } else if (snapshot.hasData) {
                final posts = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 22.0),
                        child: Text(
                          'Upcoming event  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blueGrey[900],
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      FutureBuilder<String>(
                          future: upEvent,
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ));
                            } else if (snap.hasData) {
                              final datas = snap.data!;
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 14.0),
                                width: MediaQuery.of(context).size.width,
                                child: UpcomingEvent(
                                  horizontalPadding: 14.0,
                                  data: datas,
                                ),
                              );
                            } else {
                              return const Text("No data available");
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 22.0),
                        child: Text(
                          'Event\'s gallery  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blueGrey[900],
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      PastEvetns(
                        eventData: posts,
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                );
              } else {
                return const Text("No data available");
              }
            })
      ],
    );
  }
}

class PastEvetns extends StatefulWidget {
  List<EventsData>? eventData;
  PastEvetns({super.key, this.eventData});

  @override
  State<PastEvetns> createState() => _PastEvetnsState();
}

class _PastEvetnsState extends State<PastEvetns> {
  @override
  Widget build(BuildContext context) {
    // var eventData = Provider.of<List<EventsData?>>(context);
    if (widget.eventData! != null) {
      if (widget.eventData!.length != 0) {
        return Container(
          margin: const EdgeInsets.all(12.0),
          child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.eventData!.length,
              itemBuilder: (context, index) => Container(
                    child: GestureDetector(
                      // onTap: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EventInfoPage(
                      //       data: widget.eventData![index],
                      //     ),
                      //   ),
                      // ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                widget.eventData![index].eventThumb!,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: [
                                    Text(
                                      widget.eventData![index].eventHead!,
                                      maxLines: 3,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(1, index.isEven ? 1.3 : 1.9)),
        );
      } else {
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
      }
    } else {
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
    }
  }
}
