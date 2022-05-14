import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mu3een_dashboard/apis/admin_api.dart';
import 'package:mu3een_dashboard/models/admin_response.dart';
import 'package:mu3een_dashboard/models/admin.dart';
import 'package:mu3een_dashboard/models/admin_update_request.dart';
import 'package:mu3een_dashboard/screens/main/main_screen.dart';
import '../services/local_storage_service.dart';
import '../utils/globle_functions.dart';
import '../models/fetch_error.dart';

class UserBloc with ChangeNotifier, DiagnosticableTreeMixin {
  AdminLoginResponse? adminUser;
  Admin? get admin => adminUser!.user;
  Future<FutureOr> login(
      String username, String password, BuildContext context) async {
    try {
      showDialogProgressIndicator(context);
      adminUser =
          await AdminApi().login(username: username, password: password);
      LocalStorageService().setUser(adminUser);
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const MainScreen()), (_) => true);
    } on FetchError catch (e) {
      Navigator.pop(context);
      showToast(e.message, context: context);
    } catch (ex) {
      Navigator.pop(context);
      print(ex);
    }
  }

  update(AdminUpdateRequest model, context) async {
    showDialogProgressIndicator(context);
    adminUser!.user = await AdminApi().update(id: admin!.id!, model: model);
    Navigator.pop(context);
    LocalStorageService().setUser(adminUser);
    notifyListeners();
  }

  initUser(Map<String, dynamic> model, context) {
    adminUser = AdminLoginResponse.fromJson(model);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const MainScreen()), (_) => true);
  }

  Future applogout(BuildContext context) async {
    // ApiService.userToken = null;
    if (await LocalStorageService().clear()) {
      // await FirebaseMessaging.instance.deleteToken();
      // await GoogleSignIn().signOut();
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil("/", (context) => false);
    }
  }
}
