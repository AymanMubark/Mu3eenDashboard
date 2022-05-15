import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:mu3een_dashboard/constants.dart';
import 'dart:typed_data';

showDialogProgressIndicator(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      child: const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
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

Future<Uint8List?> _loadImage(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoad.first;
  reader.onLoadEnd;
  return reader.result as Uint8List;
}

Future<Uint8List?> selectImage(context) async {
  var file = await ImagePickerWeb.getImageAsFile();
  if (file != null) {
    return await _loadImage(file);
  }
  return null;
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
