import 'package:flutter/material.dart';
import 'package:mu3een_dashboard/apis/admin_api.dart';
import 'package:mu3een_dashboard/models/socail_events_report.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'social_event_type_card_widget.dart';

class SocialEventsReportWidget extends StatefulWidget {
  const SocialEventsReportWidget({Key? key}) : super(key: key);

  @override
  State<SocialEventsReportWidget> createState() =>
      _SocialEventsReportWidgetState();
}

class _SocialEventsReportWidgetState extends State<SocialEventsReportWidget> {
  SocailEventsReport? model;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    AdminApi().socailEventsReport().then((value) {
      model = value;
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
          const Text(
            "Events Type",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Chart(model: model),
          if (model != null)
            for (int i = 0; i < model!.typesCount!.length; i++)
              SocialEventTypeCardWidget(
                color: colors[i],
                title: "${model!.typesCount![i].name}",
                amountOfFiles: model!.typesCount![i].count!,
              ),
        ],
      ),
    );
  }
}
