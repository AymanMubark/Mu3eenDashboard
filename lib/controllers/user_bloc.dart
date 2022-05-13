import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mu3een_dashboard/apis/admin_api.dart';
import 'package:mu3een_dashboard/models/admin.dart';
import 'package:mu3een_dashboard/models/admin_response.dart';
import 'package:mu3een_dashboard/screens/main/main_screen.dart';
import '../models/fetch_error.dart';
import '../utils/globle_functions.dart';

class UserBloc with ChangeNotifier, DiagnosticableTreeMixin {
  AdminLoginResponse? adminUser;
  Admin? get admin => adminUser?.user;
  Future<FutureOr> login(
      String username, String password, BuildContext context) async {
    try {
      showDialogProgressIndicator(context);
      adminUser =
          await AdminApi().login(username: username, password: password);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "/Main", (_) => true);
    } on FetchError catch (e) {
      Navigator.pop(context);
      showToast(e.message, context: context);
    } catch (ex) {
      Navigator.pop(context);
      print(ex);
    }
  }
}
