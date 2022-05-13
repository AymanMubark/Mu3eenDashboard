import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _currentPage = const DashboardScreen();
  Widget get currentPage => _currentPage;

  set currentPage(value) {
    _currentPage = value;
    notifyListeners();
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
