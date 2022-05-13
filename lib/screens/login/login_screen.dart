import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mu3een_dashboard/controllers/user_bloc.dart';
import 'package:mu3een_dashboard/responsive.dart';
import 'package:mu3een_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:mu3een_dashboard/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import '../../widgets/svg_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              const SVGWidget(
                "logo",
                height: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ||
                            Responsive.isTablet(context)
                        ? MediaQuery.of(context).size.width * .1
                        : MediaQuery.of(context).size.width * .4),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Enter your login information",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the email and password to correct the message to log in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == "") return "Field required";
                          return null;
                        },
                        onSaved: (value) {
                          userName = value;
                        },
                        style: const TextStyle(letterSpacing: 1),
                        decoration: InputDecoration(
                          label: const Text("Username"),
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
                        validator: (value) {
                          if (value == "") return "Field required";
                          return null;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(letterSpacing: 1),
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text("Password"),
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context
                                .read<UserBloc>()
                                .login(userName!, password!, context);
                          }
                        },
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
