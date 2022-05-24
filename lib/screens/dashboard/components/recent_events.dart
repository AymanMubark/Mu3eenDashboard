import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../apis/social_event_api.dart';
import '../../../constants.dart';
import '../../../models/social_event.dart';
import '../../../utils/globle_functions.dart';

class RecentEvents extends StatefulWidget {
  const RecentEvents({Key? key}) : super(key: key);

  @override
  State<RecentEvents> createState() => _RecentEventsState();
}

class _RecentEventsState extends State<RecentEvents> {
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
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Events",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: socialEvents == null
                ? const Center(child: CircularProgressIndicator())
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
                        label: Text("Type"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                    ],
                    rows: List.generate(
                      socialEvents!.length > 7 ? 7 : socialEvents!.length,
                      (index) =>
                          socialEventDataRow(socialEvents![index], index),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

DataRow socialEventDataRow(SocialEvent socialEvent, index) {
  return DataRow(
    cells: [
      DataCell(Text("${++index}")),
      DataCell(Text(socialEvent.name!)),
      DataCell(Text(socialEvent.socialEventType!.name!)),
      DataCell(Text(
          buildDateTime(socialEvent.createdAt!, customeFromat: 'dd/MM/yyyy'))),
    ],
  );
}
