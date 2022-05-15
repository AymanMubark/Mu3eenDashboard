import 'dart:typed_data';
import 'package:mu3een_dashboard/models/add_reward_request.dart';
import 'package:mu3een_dashboard/utils/globle_functions.dart';
import 'package:mu3een_dashboard/widgets/my_image.dart';
import 'package:mu3een_dashboard/widgets/search_field.dart';
import '../../apis/reward_api.dart';
import '../../models/fetch_error.dart';
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
  AddRewardRequest? addmodel;
  final _formKey = GlobalKey<FormState>();

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
                  onPressed: () {
                    addmodel = AddRewardRequest();
                    setState(() {});
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            buildAddForm(),
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
                                label: Text("Points"),
                              ),
                              DataColumn(
                                label: Text("Date"),
                              ),
                              DataColumn(
                                label: Text("Action"),
                              ),
                            ],
                            rows: List.generate(
                              rewards!.length,
                              (index) => rewardDataRow(
                                rewards![index],
                                index,
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                            "Confirm",
                                            style:
                                                TextStyle(color: primaryColor),
                                          ),
                                          content:
                                              const Text("Delete Event !?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                try {
                                                  showDialogProgressIndicator(
                                                      context);
                                                  await RewardApi().delete(
                                                      rewards![index].id!);
                                                  load();
                                                } on FetchError catch (error) {
                                                  showToast(error.message,
                                                      context: context);
                                                } catch (e) {
                                                  print(e);
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                ],
                              ),
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

  buildAddForm() {
    if (addmodel == null) {
      return const SizedBox();
    } else {
      return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                ),
                child: addmodel!.image == null
                    ? Center(
                        child: Icon(Icons.camera_alt,
                            color: Theme.of(context).colorScheme.primary),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          addmodel!.image!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  selectImage(context).then((Uint8List? value) {
                    if (value != null) {
                      addmodel!.image = value;
                      setState(() {});
                    }
                  });
                },
                child: Text("Change Image"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == "") return "Field required";
                  return null;
                },
                onSaved: (value) {
                  addmodel!.name = value;
                },
                style: const TextStyle(letterSpacing: 1, fontSize: 14),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(letterSpacing: 1, fontSize: 14),
                  label: Text("Title"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == "") return "Field required";
                  return null;
                },
                onSaved: (value) {
                  addmodel!.content = value;
                },
                style: const TextStyle(letterSpacing: 1, fontSize: 14),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(letterSpacing: 1, fontSize: 14),
                  label: Text("Content"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") return "Field required";
                        return null;
                      },
                      onSaved: (value) {
                        addmodel!.points = int.tryParse(value!);
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(letterSpacing: 1, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelStyle:
                            const TextStyle(letterSpacing: 1, fontSize: 14),
                        label: Text("Points"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") return "Field required";
                        return null;
                      },
                      onSaved: (value) {
                        addmodel!.numbers = int.tryParse(value!);
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(letterSpacing: 1, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelStyle:
                            const TextStyle(letterSpacing: 1, fontSize: 14),
                        label: Text("Count"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          showDialogProgressIndicator(context);
                          try {
                            await RewardApi().add(model: addmodel!);
                            addmodel = null;
                            load();
                            showToast("Add event successfuly",
                                context: context);
                          } on FetchError catch (error) {
                            showToast(error.message, context: context);
                          } catch (e) {
                            print(e);
                          }
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

DataRow rewardDataRow(Reward reward, index, {List<Widget>? actions}) {
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
              ),
              child: reward.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(reward.imageUrl!, fit: BoxFit.cover),
                    )
                  : const SVGWidget("logo", height: 15),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text("${reward.name}"),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text("${reward.numbers}")),
      DataCell(Text("${reward.points}")),
      DataCell(Text(
          buildDateTime("${reward.createdAt}", customeFromat: 'dd/MM/yyyy'))),
      if (actions != null) DataCell(Row(children: actions)),
    ],
  );
}
