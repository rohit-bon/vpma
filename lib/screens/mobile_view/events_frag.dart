// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/events_data.dart';
import 'package:vpma_nagpur/screens/candidate_page/desktop_layout/events_page.dart';
import 'package:vpma_nagpur/screens/mobile_view/eventinfo_page.dart';
import 'package:vpma_nagpur/utils/components/ads_widget.dart';

class EventsFrag extends StatelessWidget {
  DatabaseManager? _dbRef;
  EventsFrag({Key? key}) : super(key: key) {
    _dbRef = DatabaseManager.getDbReference;
  }

  @override
  Widget build(BuildContext context) {
    var upComingEvent = _dbRef!.getUpcomingEvent();
    var eventsData = _dbRef!.getEvents();
    return Stack(
      children: [
        StreamProvider<List<EventsData>>(
          initialData: [],
          create: (_) => eventsData,
          child: SingleChildScrollView(
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
                StreamProvider<String>(
                  initialData: '',
                  create: (_) => upComingEvent,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 14.0),
                    width: MediaQuery.of(context).size.width,
                    child: const UpcomingEvent(
                      horizontalPadding: 14.0,
                    ),
                  ),
                ),
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
                const PastEvetns(),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: AdsWidget(
                  isMobile: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PastEvetns extends StatefulWidget {
  const PastEvetns({super.key});

  @override
  State<PastEvetns> createState() => _PastEvetnsState();
}

class _PastEvetnsState extends State<PastEvetns> {
  @override
  Widget build(BuildContext context) {
    var eventData = Provider.of<List<EventsData>>(context);
    if (eventData != null) {
      if (eventData.length != 0) {
        return Container(
          margin: const EdgeInsets.all(12.0),
          child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventData.length,
              itemBuilder: (context, index) => Container(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventInfoPage(
                            data: eventData[index],
                          ),
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                eventData[index].eventThumb!,
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
                                      eventData[index].eventHead!,
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
