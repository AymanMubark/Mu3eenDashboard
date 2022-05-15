import 'package:mu3een_dashboard/apis/admin_api.dart';
import '../../../models/admin_counts_report.dart';
import 'package:flutter/material.dart';
import '../../../models/my_files.dart';
import '../../../responsive.dart';
import '../../../constants.dart';
import 'file_info_card.dart';

class MyAdminCountsReport extends StatefulWidget {
  const MyAdminCountsReport({Key? key}) : super(key: key);

  @override
  State<MyAdminCountsReport> createState() => _MyAdminCountsReportState();
}

class _MyAdminCountsReportState extends State<MyAdminCountsReport> {
  @override
  void initState() {
    super.initState();
    load();
  }

  AdminCountsReport? model;
  load() {
    AdminApi().countsReport().then((value) {
      model = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Reports",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            model: model,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(
            model: model,
          ),
          desktop: FileInfoCardGridView(
            model: model,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  final AdminCountsReport? model;
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
    this.model,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      children: [
        FileInfoCard(
          info: CloudStorageInfo(
            title: "Volunteers",
            numOfFiles: model?.volunteers,
            svgSrc: "assets/icons/Documents.svg",
            color: primaryColor,
            percentage: 35,
          ),
        ),
        FileInfoCard(
          info: CloudStorageInfo(
            title: "Institutions",
            numOfFiles: model?.institutions,
            svgSrc: "assets/icons/google_drive.svg",
            color: const Color(0xFFFFA113),
            percentage: 35,
          ),
        ),
        FileInfoCard(
          info: CloudStorageInfo(
            title: "Rewards",
            numOfFiles: model?.rewards,
            svgSrc: "assets/icons/one_drive.svg",
            color: const Color(0xFFA4CDFF),
            percentage: 10,
          ),
        ),
      ],
    );
  }
}
