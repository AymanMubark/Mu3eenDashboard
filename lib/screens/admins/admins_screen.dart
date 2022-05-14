import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../models/search_admin_request.dart';
import '../../widgets/svg_widget.dart';
import '../dashboard/components/header.dart';
import '../../apis/admin_api.dart';
import 'package:flutter/material.dart';
import '../../models/admin.dart';
import '../../constants.dart';

class AdminsScreen extends StatefulWidget {
  const AdminsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen> {
  SearchAdminRequest model = SearchAdminRequest();

  List<Admin>? admins;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    AdminApi().all(model: model).then((value) {
      admins = value;
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
            const Header(title: "Admins"),
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
                    "Recent admins",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: admins == null
                        ? const Center(child: CircularProgressIndicator())
                        : DataTable2(
                            columnSpacing: defaultPadding,
                            minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("Name"),
                              ),
                              DataColumn(
                                label: Text("Email"),
                              ),
                              DataColumn(
                                label: Text("UserName"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                            ],
                            rows: List.generate(
                              admins!.length,
                              (index) => adminDataRow(admins![index], index),
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

DataRow adminDataRow(Admin admin, index) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              child: admin.imageUrl != null
                  ? null
                  : const SVGWidget("logo", height: 15),
              backgroundImage: admin.imageUrl != null
                  ? NetworkImage("${admin.imageUrl}")
                  : null,
              radius: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text("${admin.name}"),
            ),
          ],
        ),
      ),
      DataCell(Text("${admin.email}")),
      DataCell(Text("${admin.userName}")),
      DataCell(Text(
          buildDateTime("${admin.createdAt}", customeFromat: 'dd/MM/yyyy'))),
    ],
  );
}
