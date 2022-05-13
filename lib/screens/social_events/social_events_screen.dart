import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mu3een_dashboard/apis/social_event_api.dart';
import 'package:mu3een_dashboard/models/social_event.dart';
import 'package:mu3een_dashboard/utils/globle_functions.dart';

import '../../constants.dart';
import '../../models/recent_file.dart';
import '../dashboard/components/header.dart';

class SocialEventsScreen extends StatefulWidget {
  const SocialEventsScreen({Key? key}) : super(key: key);

  @override
  State<SocialEventsScreen> createState() => _SocialEventsScreenState();
}

class _SocialEventsScreenState extends State<SocialEventsScreen> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<SocialEvent>? socialEvents;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    SocialEventApi().all().then((value) {
      socialEvents = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(title: "Social Events"),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Expanded(child: SearchField()),
                const SizedBox(width: 50),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      elevation: 0, underline: const SizedBox(),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent events",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: socialEvents == null
                        ? Center(child: const CircularProgressIndicator())
                        : DataTable2(
                            columnSpacing: defaultPadding,
                            minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("ID"),
                              ),
                              DataColumn(
                                label: Text("Name"),
                              ),
                              DataColumn(
                                label: Text("Address"),
                              ),
                              DataColumn(
                                label: Text("Type"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                              DataColumn(
                                label: Text("Points"),
                              ),
                            ],
                            rows: List.generate(
                              socialEvents!.length,
                              (index) => socialEventDataRow(
                                  socialEvents![index], index),
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

DataRow socialEventDataRow(SocialEvent socialEvent, index) {
  return DataRow(
    cells: [
      DataCell(Text("${++index}")),
      DataCell(Text(socialEvent.name!)),
      DataCell(Text(socialEvent.address!)),
      DataCell(Text(socialEvent.socialEventType!.name!)),
      DataCell(Text(
          buildDateTime(socialEvent.createdAt!, customeFromat: 'dd/MM/yyyy'))),
      DataCell(Text(socialEvent.points!.toString())),
    ],
  );
}
