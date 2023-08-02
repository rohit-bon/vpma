// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class ContactWidget extends StatelessWidget {
  final Function? callback;
  List<MemberData>? memberData;
  ContactWidget({super.key, this.callback, this.memberData});

  @override
  Widget build(BuildContext context) {
    return Phonebook(
      memberData: memberData,
      callback: callback,
    );
  }
}

class Phonebook extends StatefulWidget {
  final Function? callback;
  List<MemberData>? memberData;
  Phonebook({super.key, this.callback, this.memberData});

  @override
  State<Phonebook> createState() => _PhonebookState();
}

class _PhonebookState extends State<Phonebook> {
  @override
  Widget build(BuildContext context) {
    if (widget.memberData![0].shopAddress == 'NOT FOUND') {
      return const SizedBox(
        height: 200,
        width: double.maxFinite,
        child: Center(
          child: Text(
            'no result found ',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      children: [
        DataTable(
          showCheckboxColumn: false,
          columnSpacing: 8.0,
          horizontalMargin: 10.0,
          columns: const [
            DataColumn(
              label: Text(' '),
              numeric: false,
            ),
            DataColumn(
              label: Text(
                'Member Name',
                style: kTableHead,
              ),
              numeric: false,
            ),
            DataColumn(
              label: Text(
                'Shop Name',
                style: kTableHead,
              ),
              numeric: false,
            ),
            DataColumn(
              label: Text(
                'Contact',
                style: kTableHead,
              ),
              numeric: true,
            ),
          ],
          rows: widget.memberData!
              .map(
                (data) => DataRow(
                  onSelectChanged: (isSelected) {
                    if (isSelected!) {
                      widget.callback!(data);
                    }
                  },
                  cells: [
                    DataCell(
                      Text(
                        (widget.memberData!.indexOf(data) + 1).toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        data.memberName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        data.shopName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        data.contact!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
