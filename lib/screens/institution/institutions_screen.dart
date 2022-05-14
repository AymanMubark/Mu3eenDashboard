import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../apis/institutions_api.dart';
import '../../models/institution.dart';
import '../../models/search_institutions_request.dart';
import '../dashboard/components/header.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class InstitutionsScreen extends StatefulWidget {
  const InstitutionsScreen({Key? key}) : super(key: key);

  @override
  State<InstitutionsScreen> createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends State<InstitutionsScreen> {
  SearchInstitutionRequest model = SearchInstitutionRequest();

  List<Institution>? institutions;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    InstitutionApi().all(model: model).then((value) {
      institutions = value;
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
            const Header(title: "Institutions"),
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
                    "Recent institutions",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: institutions == null
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
                                label: Text("Email"),
                              ),
                              DataColumn(
                                label: Text("Phone"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                            ],
                            rows: List.generate(
                              institutions!.length,
                              (index) => institutionDataRow(
                                  institutions![index], index),
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

DataRow institutionDataRow(Institution institution, index) {
  return DataRow(
    cells: [
      DataCell(Text("${++index}")),
      DataCell(Text("${institution.name}")),
      DataCell(Text("${institution.email}")),
      DataCell(Text("${institution.phone}")),
      DataCell(Text(buildDateTime("${institution.createdAt}",
          customeFromat: 'dd/MM/yyyy'))),
    ],
  );
}
