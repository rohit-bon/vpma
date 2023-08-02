// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vpma_nagpur/models/events_data.dart';
import 'package:vpma_nagpur/utils/components/custom_container.dart';
import 'package:vpma_nagpur/utils/components/custom_floating_button.dart';

class PastEventsWidget extends StatefulWidget {
  final int? gridSize;
  final Function? showDialog;
  const PastEventsWidget({super.key, this.gridSize, this.showDialog});

  @override
  State<PastEventsWidget> createState() => _PastEventsWidgetState();
}

class _PastEventsWidgetState extends State<PastEventsWidget> {
  @override
  Widget build(BuildContext context) {
    List<EventsData> eventsData = Provider.of<List<EventsData>>(context);
    if (eventsData != null) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridSize!),
        shrinkWrap: true,
        itemBuilder: (context, index) => ListBlock(
          data: eventsData[index],
          visible: (eventsData[index].eventThumb != null),
          showDialog: widget.showDialog,
        ),
        itemCount: eventsData.length,
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
  }
}

class ListBlock extends StatelessWidget {
  final EventsData? data;
  final bool? visible;
  final Function? showDialog;
  const ListBlock({super.key, this.data, this.visible, this.showDialog});

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Container(
        margin: const EdgeInsets.all(20.0),
        height: 150,
        child: EventsBlock(
          data: data,
          imageVisible: visible,
          showDialog: showDialog,
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}

class EventsBlock extends StatelessWidget {
  final EventsData? data;
  bool? imageVisible;
  final Function? showDialog;
  EventsBlock({super.key, this.data, this.imageVisible, this.showDialog});

  @override
  Widget build(BuildContext context) {
    if (imageVisible!) {
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
                  data!.eventThumb!,
                  fit: BoxFit.fill,
                  height: double.maxFinite,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                data!.eventHead!,
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: CustomFloatingButton(
                                icon: Ionicons.information_circle,
                                tooltip: 'Know More',
                                onTap: () => showDialog!(data),
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
                child: Center(
                  child: Text(
                    data!.eventHead!,
                    textAlign: TextAlign.center,
                    maxLines: 12,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20.0,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ),
              Container(
                child: CustomFloatingButton(
                  icon: Ionicons.information_circle,
                  tooltip: 'Know More',
                  onTap: () => showDialog!(data),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
