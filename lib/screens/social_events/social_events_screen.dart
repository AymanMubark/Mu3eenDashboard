import 'package:mu3een_dashboard/models/search_social_event_request.dart';
import 'package:mu3een_dashboard/apis/social_event_type_api.dart';
import 'package:mu3een_dashboard/models/social_event_type.dart';
import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/apis/social_event_api.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import 'package:mu3een_dashboard/models/social_event.dart';
import 'package:data_table_2/data_table_2.dart';
import '../dashboard/components/header.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class SocialEventsScreen extends StatefulWidget {
  const SocialEventsScreen({Key? key}) : super(key: key);

  @override
  State<SocialEventsScreen> createState() => _SocialEventsScreenState();
}

class _SocialEventsScreenState extends State<SocialEventsScreen> {
  SearchSocialEventRequest model = SearchSocialEventRequest();

  List<SocialEvent>? socialEvents;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    SocialEventApi().all(model: model).then((value) {
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
                Expanded(
                  child: SearchField(
                    onSubmitted: (value) {
                      model.key = value;
                      load();
                    },
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: SocialTypeDropDown(
                    onChange: (SocialEventType value) {
                      model.socialEventTypeId = value.id;
                      load();
                    },
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

class SocialTypeDropDown extends StatefulWidget {
  final Function onChange;
  const SocialTypeDropDown({Key? key, required this.onChange})
      : super(key: key);

  @override
  State<SocialTypeDropDown> createState() => _SocialTypeDropDownState();
}

class _SocialTypeDropDownState extends State<SocialTypeDropDown> {
  List<SocialEventType>? types;
  SocialEventType? selectType;

  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    SocialEventTypeApi().all().then((value) {
      types = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return types == null
        ? const SizedBox()
        : Container(
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: DropdownButton(
              value: selectType,
              elevation: 0,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              hint: const Text("All Type"),
              items: types!.map((SocialEventType type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name!),
                );
              }).toList(),
              onChanged: (SocialEventType? newValue) {
                setState(() {
                  selectType = newValue;
                  widget.onChange(selectType);
                });
              },
            ),
          );
  }
}
