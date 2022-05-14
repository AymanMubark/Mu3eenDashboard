import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import '../../apis/reward_api.dart';
import '../../models/search_reward_request.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../../widgets/svg_widget.dart';
import 'package:flutter/material.dart';
import '../../models/reward.dart';
import '../../constants.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  SearchRewardRequest model = SearchRewardRequest();

  List<Reward>? rewards;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    RewardApi().all(model: model).then((value) {
      rewards = value;
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
            const Header(title: "Rewards"),
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
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
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
                    "Recent rewards",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: rewards == null
                        ? const Center(child: CircularProgressIndicator())
                        : DataTable2(
                            columnSpacing: defaultPadding,
                            minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("Title"),
                              ),
                              DataColumn(
                                label: Text("Numbers"),
                              ),
                              DataColumn(
                                label: Text("ExpiryDate"),
                              ),
                              DataColumn(
                                label: Text("Points"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                            ],
                            rows: List.generate(
                              rewards!.length,
                              (index) => rewardDataRow(rewards![index], index),
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

DataRow rewardDataRow(Reward reward, index) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
                image: reward.imageUrl != null
                    ? DecorationImage(image: NetworkImage("${reward.imageUrl}"))
                    : null,
              ),
              child: reward.imageUrl != null
                  ? null
                  : const SVGWidget("logo", height: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text("${reward.name}"),
            ),
          ],
        ),
      ),
      DataCell(Text("${reward.numbers}")),
      DataCell(Text("${reward.expiryDate}")),
      DataCell(Text("${reward.points}")),
      DataCell(Text(
          buildDateTime("${reward.createdAt}", customeFromat: 'dd/MM/yyyy'))),
    ],
  );
}
