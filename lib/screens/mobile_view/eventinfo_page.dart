// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison, prefer_is_empty, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:vpma_nagpur/models/database_manager.dart';
import 'package:vpma_nagpur/models/events_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/screens/mobile_view/back_appbar.dart';
import 'package:vpma_nagpur/screens/mobile_view/gallery_view.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class EventInfoPage extends StatelessWidget {
  final Constants _const = Constants.getReferenceObject;
  final DatabaseManager _dbRef = DatabaseManager.getDbReference;
  UserData? _user;
  EventsData? data;
  EventInfoPage({Key? key, this.data}) : super(key: key) {
    _user = _const.user;
  }

  @override
  Widget build(BuildContext context) {
    var eventImages = _dbRef.getEventImages(data!.id.toString());
    return Scaffold(
      backgroundColor: kThirdColor,
      appBar: backAppBar(context),
      body: SafeArea(
        child: StreamProvider<List<String>>(
          initialData: [],
          create: (_) => eventImages,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    data!.eventHead! + '  ',
                    maxLines: 8,
                    style: const TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 40.0,
                    top: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Text(
                    data!.eventDesc! + '  ',
                    textAlign: TextAlign.justify,
                    maxLines: 100,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                ),
                ImageGrid(),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const Icon(
                        Icons.access_time,
                        color: kPrimaryFontColor,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        data!.eventDate.toString() + '  ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'ProductSans',
                          color: kPrimaryFontColor,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getUserProfileIcon() {
    if (_user!.userImage.toString() == 'null') {
      return const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20.0,
        child: Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 38.0,
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(_user!.userImage!),
      );
    }
  }
}

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key});

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    var eventImages = Provider.of<List<String>>(context);
    if (eventImages != null) {
      if (eventImages.length != 0) {
        return Container(
          margin: const EdgeInsets.all(12.0),
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            physics: NeverScrollableScrollPhysics(),
            itemCount: eventImages.length,
            itemBuilder: (context, index) => Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryView(
                        imageList: eventImages,
                        index: index,
                      ),
                    ),
                  );
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    eventImages[index],
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(1, index.isEven ? 1.3 : 1.9),
          ),
        );
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }
}
