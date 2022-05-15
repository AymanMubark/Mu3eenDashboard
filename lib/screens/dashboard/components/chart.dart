import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mu3een_dashboard/models/socail_events_report.dart';

import '../../../constants.dart';

List<Color> colors = [
  primaryColor,
  const Color(0xFF26E5FF),
  const Color(0xFFFFCF26),
  const Color(0xFFEE2727),
  primaryColor.withOpacity(0.1),
];

class Chart extends StatelessWidget {
  final SocailEventsReport? model;
  const Chart({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> list = [];
    if (model != null)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < model!.typesCount!.length; i++) {
        list.add(
          PieChartSectionData(
            color: colors[i],
            value: double.parse(model!.typesCount![i].count!.toString()),
            showTitle: false,
            radius: 25,
          ),
        );
      }
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: list,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "${model?.total ?? ""}",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                const Text("of events")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
