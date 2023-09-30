import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpma_nagpur/screens/candidate_page/news_query.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class Query extends StatelessWidget {
  const Query({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'Query responces  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 300,
                  child: Center(
                    child: Text(
                      'no recent replies  ',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            elevation: 10.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewQuery(),
                ),
              );
            },
            backgroundColor: kPrimaryColor,
            child: Icon(
              FontAwesomeIcons.comment,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
