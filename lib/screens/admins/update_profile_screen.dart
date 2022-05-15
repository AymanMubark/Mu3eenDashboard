import 'dart:typed_data';

import 'package:mu3een_dashboard/models/admin_update_request.dart';
import 'package:mu3een_dashboard/utils/globle_functions.dart';
import '../dashboard/components/header.dart';
import '../../controllers/user_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_image.dart';
import '../../models/admin.dart';
import '../../constants.dart';
import 'dart:io';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  AdminUpdateRequest model = AdminUpdateRequest();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scaffoldKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(title: "My Profile"),
            const SizedBox(height: defaultPadding),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      child: (model.image == null &&
                              context.watch<UserBloc>().admin!.imageUrl == null)
                          ? Center(
                              child: Icon(Icons.camera_alt,
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: model.image != null
                                  ? Image.memory(
                                      model.image!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      context
                                          .watch<UserBloc>()
                                          .admin!
                                          .imageUrl!,
                                    ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        selectImage(context).then((Uint8List? value) {
                          if (value != null) {
                            model.image = value;
                            setState(() {});
                          }
                        });
                      },
                      child: Text("Change Image"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: context.watch<UserBloc>().admin!.name,
                      validator: (name) {
                        if (name == "") return "Field required";
                        return null;
                      },
                      onSaved: (value) {
                        model.name = value;
                      },
                      decoration: InputDecoration(
                        label: const Text("Name"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: context.watch<UserBloc>().admin!.email,
                      validator: (value) {
                        // if (!EmailValidator.validate(value!)) {
                        //   return "Enter the email correctly";
                        // }
                        return null;
                      },
                      onSaved: (value) {
                        model.email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(letterSpacing: 1),
                      decoration: InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context.read<UserBloc>().update(model, context);
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
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
              child: ClipRRect(
                child: Image.network(admin.imageUrl!),
                borderRadius: BorderRadius.circular(50),
              ),
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
