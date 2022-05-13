import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

showDialogProgressIndicator(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      child: const Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      ),
    ),
  );
  bool shouldPop = false;
  showDialog(
    //prevent outside touch
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent Back button press
      return WillPopScope(
          onWillPop: () async {
            return shouldPop;
          },
          child: alert);
    },
  );
}

buildDateTime(String datetime, {String customeFromat = 'dd/MM/yyyy hh:mm a'}) {
  try {
    var date = DateTime.parse(datetime);
    DateFormat formatter = DateFormat(customeFromat);
    return formatter.format(date);
  } catch (e) {
    return "";
  }
}

showToast(message, {required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
