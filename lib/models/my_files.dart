import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}
