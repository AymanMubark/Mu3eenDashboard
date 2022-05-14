import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../models/search_volunteer_request.dart';
import '../../widgets/svg_widget.dart';
import '../dashboard/components/header.dart';
import '../../apis/volunteer_api.dart';
import 'package:flutter/material.dart';
import '../../models/volunteer.dart';
import '../../constants.dart';

class VolunteersScreen extends StatefulWidget {
  const VolunteersScreen({Key? key}) : super(key: key);

  @override
  State<VolunteersScreen> createState() => _VolunteersScreenState();
}

class _VolunteersScreenState extends State<VolunteersScreen> {
  SearchVolunteerRequest model = SearchVolunteerRequest();

  List<Volunteer>? volunteers;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    VolunteerApi().all(model: model).then((value) {
      volunteers = value;
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
            const Header(title: "Volunteers"),
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
                const Expanded(child: SizedBox()),
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
                    "Recent volunteers",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: volunteers == null
                        ? const Center(child: CircularProgressIndicator())
                        : DataTable2(
                            columnSpacing: defaultPadding,
                            minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("Name"),
                              ),
                              DataColumn(
                                label: Text("Gender"),
                              ),
                              DataColumn(
                                label: Text("Phone"),
                              ),
                              DataColumn(
                                label: Text("Points"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                            ],
                            rows: List.generate(
                              volunteers!.length,
                              (index) =>
                                  volunteerDataRow(volunteers![index], index),
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

DataRow volunteerDataRow(Volunteer volunteer, index) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              child: volunteer.imageUrl != null
                  ? null
                  : const SVGWidget("logo", height: 15),
              backgroundImage: volunteer.imageUrl != null
                  ? NetworkImage("${volunteer.imageUrl}")
                  : null,
              radius: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text("${volunteer.name}"),
            ),
          ],
        ),
      ),
      DataCell(Text(volunteer.gender ?? "-")),
      DataCell(Text("${volunteer.phone}")),
      DataCell(Text("${volunteer.points}")),
      DataCell(Text(buildDateTime("${volunteer.createdAt}",
          customeFromat: 'dd/MM/yyyy'))),
    ],
  );
}
